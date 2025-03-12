require("dotenv").config();
const axios = require("axios");
const pool = require("./db"); // Asegura que esté correctamente importado

// Configuración de la API
const API_URL = "http://api.aviationstack.com/v1/flights";
const API_KEY = process.env.API_KEY_AVIATIONSTACK;

// Función para obtener vuelos desde la API de AviationStack
async function obtenerVuelos() {
  try {
    const response = await axios.get(API_URL, {
      params: {
        access_key: API_KEY,
        limit: 50, // Límite de vuelos a obtener
      },
    });

    if (!response.data || !response.data.data) {
      console.error("❌ Error: Respuesta de API inválida");
      return [];
    }

    const vuelos = response.data.data;
    console.log(`✅ Se obtuvieron ${vuelos.length} vuelos.`);
    return vuelos;
  } catch (error) {
    console.error("Error al obtener vuelos:", error.message);
    return [];
  }
}

// Función para insertar aeropuertos en la base de datos
async function insertarAeropuerto(data) {
  if (!data || !data.iata || !data.icao) return null;

  // Validación: Si nombre es null, asignamos un valor predeterminado
  const nombreAeropuerto = data.airport ? data.airport : "Desconocido";

  try {
    const result = await pool.query(
      `INSERT INTO aeropuertos (nombre, ciudad, pais, iata, icao) 
       VALUES ($1, $2, $3, $4, $5) 
       ON CONFLICT (iata) DO NOTHING 
       RETURNING id`,
      [nombreAeropuerto, data.city, data.country, data.iata, data.icao]
    );

    if (result.rows.length > 0) {
      return result.rows[0].id;
    } else {
      const existing = await pool.query(
        "SELECT id FROM aeropuertos WHERE iata = $1",
        [data.iata]
      );
      return existing.rows[0]?.id || null;
    }
  } catch (error) {
    console.error("Error al insertar aeropuerto:", error.message);
    return null;
  }
}

// Función para insertar aerolíneas en la base de datos
async function insertarAerolínea(data) {
  if (!data || !data.iata || !data.icao) return null;

  try {
    const result = await pool.query(
      `INSERT INTO aerolineas (nombre, iata, icao) 
       VALUES ($1, $2, $3) 
       ON CONFLICT (iata) DO NOTHING 
       RETURNING id`,
      [data.name || "Desconocida", data.iata, data.icao]
    );

    if (result.rows.length > 0) {
      return result.rows[0].id;
    } else {
      const existing = await pool.query(
        "SELECT id FROM aerolineas WHERE iata = $1",
        [data.iata]
      );
      return existing.rows[0]?.id || null;
    }
  } catch (error) {
    console.error("Error al insertar aerolínea:", error.message);
    return null;
  }
}

// Función para insertar vuelos en la base de datos
async function insertarVuelos() {
  const vuelos = await obtenerVuelos();

  for (const vuelo of vuelos) {
    try {
      const { departure, arrival, airline, flight } = vuelo;

      // Validar que los datos sean correctos antes de procesarlos
      if (!departure || !arrival || !airline || !flight || !flight.number) {
        console.warn(`Vuelo omitido por datos incompletos: ${JSON.stringify(vuelo)}`);
        continue;
      }

      const idOrigen = await insertarAeropuerto(departure);
      const idDestino = await insertarAeropuerto(arrival);
      const idAerolínea = await insertarAerolínea(airline);

      if (!idOrigen || !idDestino || !idAerolínea) {
        console.warn(`Vuelo ${flight.number} omitido por falta de información clave.`);
        continue;
      }

      await pool.query(
        `INSERT INTO vuelos (fecha, estado, id_aeropuerto_origen, id_aeropuerto_destino, id_aerolinea, numero_vuelo, iata, icao, horario_salida, horario_llegada) 
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) 
         ON CONFLICT (numero_vuelo) DO NOTHING`,
        [
          vuelo.flight_date,
          vuelo.flight_status,
          idOrigen,
          idDestino,
          idAerolínea,
          flight.number,
          flight.iata || "N/A",
          flight.icao || "N/A",
          departure.scheduled,
          arrival.scheduled,
        ]
      );

      console.log(`Vuelo ${flight.number} insertado correctamente.`);
    } catch (error) {
      console.error("Error al insertar vuelo:", error.message);
    }
  }

  console.log("Carga de vuelos finalizada.");
}

// Ejecutar la función principal
insertarVuelos();

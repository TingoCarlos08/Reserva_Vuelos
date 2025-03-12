# ✈️ API de Reserva de Vuelos

Este proyecto es una **API REST** para gestionar reservas de vuelos, permitiendo a los usuarios **registrarse, iniciar sesión, buscar vuelos y realizar reservas** de manera segura.

## 🚀 Tecnologías Utilizadas

- **Node.js** con **Express.js**
- **PostgreSQL** como base de datos
- **JWT (JSON Web Token)** para autenticación
- **bcrypt** para el cifrado de contraseñas
- **AviationStack API** para obtener datos de vuelos
- **pgAdmin** para la gestión de la base de datos

## 📥 Instalación y Configuración

### 1️⃣ **Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/backend-vuelos.git
cd backend-vuelos
```
### 2️⃣ **Instalar dependencias**
```bash
npm install
```
### 3️⃣ **Configurar las variables de entorno**
Crear un archivo .env en la raíz del proyecto con el siguiente contenido:
```.env
DB_USER=postgres
DB_HOST=localhost
DB_DATABASE=reserva_Vuelos
DB_PASSWORD=tu_contraseña
DB_PORT=5432
JWT_SECRET=tu_clave_secreta
API_KEY_AVIATIONSTACK=tu_api_key
```

### 4️⃣ **Crear la base de datos**
Ejecutar el script de creación de la base de datos y las tablas en PostgreSQL.
````sql
-- Crear la base de datos (ejecutar esto solo si la base de datos no existe)
CREATE DATABASE reserva_Vuelos;

-- Usar la base de datos
\c reserva_Vuelos;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT NOW()
);

-- Tabla de aeropuertos
CREATE TABLE aeropuertos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    ciudad VARCHAR(100),
    pais VARCHAR(100),
    iata VARCHAR(10) UNIQUE NOT NULL,
    icao VARCHAR(10) UNIQUE NOT NULL
);

-- Tabla de aerolíneas
CREATE TABLE aerolineas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    iata VARCHAR(10) UNIQUE NOT NULL,
    icao VARCHAR(10) UNIQUE NOT NULL
);

-- Tabla de vuelos
CREATE TABLE vuelos (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    fecha DATE NOT NULL,
    estado VARCHAR(50),
    id_aeropuerto_origen INTEGER REFERENCES aeropuertos(id) ON DELETE CASCADE,
    id_aeropuerto_destino INTEGER REFERENCES aeropuertos(id) ON DELETE CASCADE,
    id_aerolinea INTEGER REFERENCES aerolineas(id) ON DELETE CASCADE,
    numero_vuelo VARCHAR(20) UNIQUE NOT NULL,
    iata VARCHAR(10),
    icao VARCHAR(10),
    horario_salida TIMESTAMP,
    horario_llegada TIMESTAMP
);

-- Tabla de reservas
CREATE TABLE reservas (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    id_usuario UUID REFERENCES usuarios(id) ON DELETE CASCADE,
    id_vuelo UUID REFERENCES vuelos(id) ON DELETE CASCADE,
    fecha_reserva TIMESTAMP DEFAULT NOW(),
    estado VARCHAR(50) DEFAULT 'Confirmada'
);
````
### 🔹 Ejecutar el Script en PostgreSQL
Abre PgAdmin4 o conéctate a PostgreSQL desde la terminal.
Si usas la terminal de PostgreSQL, ejecuta:
````bash
psql -U postgres -f database.sql
````
Si lo haces desde PgAdmin4:
- Abre PgAdmin4 y selecciona la base de datos reserva_Vuelos.
- Haz clic en "Query Tool".
- Copia y pega el contenido de database.sql en el editor.
- Ejecuta el script (icono de "Play").
### 🔹 Después de ejecutar esto, tu base de datos y tablas estarán listas. Luego, puedes ejecutar:
````bash
node populateDatabase.js
````
Para poblar la base de datos con datos de vuelos.

Si deseas importar la base de datos con datos, usa el backup disponible en /backup/reserva_vuelos.sql y restáuralo con:

````bash
psql -U postgres -d reserva_Vuelos -f backup/reserva_vuelos.sql
````
Si solo deseas crear las tablas, usa:

````bash
psql -U postgres -d reserva_Vuelos -f backup/schema.sql
````
### 5️⃣ **Poblar la base de datos con vuelos**
Ejecutar el siguiente comando para poblar la base de datos con vuelos:
```bash
node populateDatabase.js
````

### 6️⃣ **Configurar las variables de entorno**
````bash
node server.js
````
El servidor se ejecutará en:
📍 http://localhost:3000

## 📌 Endpoints
## 🔐 Autenticación
### ➕ Registro de usuario
- URL: POST /api/auth/register
- Body (JSON):

````json
{
  "nombre": "Juan Perez",
  "email": "juan@example.com",
  "password": "123456"
}
````
Respuesta:
````json
{
  "message": "Usuario registrado exitosamente",
  "usuario": {
    "id": "uuid",
    "nombre": "Juan Perez",
    "email": "juan@example.com",
    "fecha_registro": "2025-03-12T05:41:04.436Z"
  }
}
````

### 🔑 Inicio de sesión
- URL: POST /api/auth/login
- Body (JSON):
````json
{
  "email": "juan@example.com",
  "password": "123456"
}
````

Respuesta:
````json
{
  "message": "Inicio de sesión exitoso",
  "token": "jwt_token"
}
````
### 🎟️ Reservas
### ✅ Crear una reserva
- URL: POST /api/reservas
- Headers:
- Authorization: Bearer jwt_token
- Body (JSON):
````json
{
  "vuelo_id": "uuid"
}
````
Respuesta:
````json
{
  "message": "Reserva creada exitosamente",
  "reserva": {
    "id": "uuid",
    "id_usuario": "uuid",
    "id_vuelo": "uuid",
    "fecha_reserva": "2025-03-12T05:41:04.436Z",
    "estado": "Confirmada"
  }
}

````
### 📄 Obtener reservas del usuario
- URL: GET /api/reservas
- Headers:
- Authorization: Bearer jwt_token
Respuesta:
````json
[
  {
    "id": "uuid",
    "fecha_reserva": "2025-03-12T05:41:04.436Z",
    "numero_vuelo": "8546",
    "estado": "scheduled"
  }
]
````
### ❌ Cancelar una reserva
- URL: DELETE /api/reservas/:id
- Headers:
- Authorization: Bearer jwt_token
Respuesta:
````json
{
  "message": "Reserva cancelada exitosamente"
}
````
### 👤 Autor
Desarrollado por **Carlos Tingo**

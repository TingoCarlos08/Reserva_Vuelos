const express = require("express");
const cors = require("cors");
require("dotenv").config();
const pool = require("./db");
const verificarToken = require("./middleware/auth"); // Importa el middleware

const app = express();

// Middlewares
app.use(express.json());
app.use(cors());

// Prueba de conexión a la BD
pool.query("SELECT NOW()", (err, res) => {
    if (err) {
        console.error("Error en la conexión a la base de datos:", err.message);
        process.exit(1); // Termina la ejecución si la conexión falla
    } else {
        console.log("Base de datos conectada correctamente:", res.rows[0]);
    }
});

// Rutas públicas
app.use("/api/auth", require("./routes/auth"));
app.use("/api/vuelos", require("./routes/vuelos"));
app.use("/api/usuarios", require("./routes/usuarios"));

// Rutas protegidas (requieren autenticación)
app.use("/api/reservas", verificarToken, require("./routes/reservas"));

// Puerto del servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

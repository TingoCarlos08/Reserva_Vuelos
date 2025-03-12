const express = require("express");
const pool = require("../db");
const router = express.Router();

// Buscar vuelos por origen, destino y fecha
router.get("/", async (req, res) => {
    try {
        const { origen, destino, fecha } = req.query;

        let query = "SELECT * FROM vuelos WHERE 1=1";
        let values = [];

        if (origen) {
            query += " AND id_aeropuerto_origen = $1";
            values.push(origen);
        }
        if (destino) {
            query += " AND id_aeropuerto_destino = $2";
            values.push(destino);
        }
        if (fecha) {
            query += " AND fecha = $3";
            values.push(fecha);
        }

        const result = await pool.query(query, values);
        res.json(result.rows);
    } catch (error) {
        console.error("Error al buscar vuelos:", error);
        res.status(500).json({ message: "Error al buscar vuelos" });
    }
});

module.exports = router;

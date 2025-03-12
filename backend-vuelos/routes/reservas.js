const express = require("express");
const pool = require("../db");
const router = express.Router();
const verificarToken = require("../middleware/auth"); // Importa el middleware correcto

// **Crear una reserva (requiere autenticación)**
router.post("/", verificarToken, async (req, res) => {
    try {
        const { id_vuelo } = req.body;
        const id_usuario = req.usuario.id; // Se obtiene del token

        if (!id_vuelo) {
            return res.status(400).json({ message: "El vuelo es obligatorio" });
        }

        const result = await pool.query(
            "INSERT INTO reservas (id_usuario, id_vuelo, fecha_reserva) VALUES ($1, $2, NOW()) RETURNING *",
            [id_usuario, id_vuelo]
        );

        res.status(201).json({
            message: "Reserva creada exitosamente",
            reserva: result.rows[0],
        });
    } catch (error) {
        console.error("Error al crear reserva:", error);
        res.status(500).json({ message: "Error al crear reserva", detalles: error.message });
    }
});


// Obtener reservas del usuario autenticado
router.get("/", verificarToken, async (req, res) => {
    try {
        const usuario_id = req.usuario.id;

        const result = await pool.query(
            "SELECT r.id, r.fecha_reserva, v.numero_vuelo, v.estado FROM reservas r JOIN vuelos v ON r.id_vuelo = v.id WHERE r.id_usuario = $1",
            [usuario_id]
        );


        res.json(result.rows);
    } catch (error) {
        console.error("Error al obtener reservas:", error);
        res.status(500).json({ message: "Error al obtener reservas", detalles: error.message });
    }
});

//Eliminar reservasr

router.delete("/:id", verificarToken, async (req, res) => {
    try {
        const { id } = req.params;
        const usuario_id = req.usuario.id; // Usuario autenticado

        // Verificar si la reserva existe y pertenece al usuario
        const reserva = await pool.query("SELECT * FROM reservas WHERE id = $1 AND id_usuario = $2", [id, usuario_id]);
        if (reserva.rows.length === 0) {
            return res.status(404).json({ message: "Reserva no encontrada o no autorizada" });
        }

        // Eliminar la reserva
        await pool.query("DELETE FROM reservas WHERE id = $1", [id]);
        res.json({ message: "Reserva cancelada exitosamente" });

    } catch (error) {
        console.error("Error al cancelar reserva:", error);
        res.status(500).json({ message: "Error al cancelar reserva" });
    }
});



module.exports = router;

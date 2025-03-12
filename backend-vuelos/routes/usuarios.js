const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const pool = require("../db");

const router = express.Router();

// Middleware para verificar el token JWT
const verificarToken = (req, res, next) => {
    const token = req.header("Authorization");

    if (!token) {
        return res.status(401).json({ message: "Acceso denegado. Token no proporcionado." });
    }

    try {
        const decoded = jwt.verify(token.replace("Bearer ", ""), process.env.JWT_SECRET);
        req.usuario = decoded;
        next();
    } catch (error) {
        return res.status(401).json({ message: "Token inválido." });
    }
};

router.post("/register", async (req, res) => {
    const { nombre, email, password } = req.body;

    try {
        console.log("Recibiendo solicitud de registro:", { nombre, email });

        // Verificar si el usuario ya existe
        const usuarioExistente = await pool.query("SELECT * FROM usuarios WHERE email = $1", [email]);

        if (usuarioExistente.rows.length > 0) {
            return res.status(400).json({ message: "El usuario ya está registrado." });
        }

        // Cifrar la contraseña antes de guardarla en la base de datos
        const hashedPassword = await bcrypt.hash(password, 10);
        console.log("Contraseña cifrada correctamente.");

        await pool.query(
            `INSERT INTO usuarios (id, fecha_registro, nombre, email, contraseña) 
             VALUES (gen_random_uuid(), NOW(), $1, $2, $3)`,
            [nombre, email, hashedPassword]
        );

        console.log("Usuario registrado correctamente.");
        res.status(201).json({ message: "Usuario registrado correctamente." });

    } catch (error) {
        console.error("Error al registrar usuario:", error.message);
        res.status(500).json({ message: "Error al registrar usuario", error: error.message });
    }
});


//Inicio de sesión
router.post("/login", async (req, res) => {
    const { email, password } = req.body;

    try {
        const result = await pool.query("SELECT * FROM usuarios WHERE email = $1", [email]);

        if (result.rows.length === 0) {
            return res.status(404).json({ message: "Usuario no encontrado" });
        }

        const usuario = result.rows[0];

        // Comparar la contraseña ingresada con la almacenada
        const passwordMatch = await bcrypt.compare(password, usuario.contraseña);

        if (!passwordMatch) {
            return res.status(401).json({ message: "Contraseña incorrecta" });
        }

        // Generar token JWT
        const token = jwt.sign(
            { id: usuario.id, email: usuario.email },
            process.env.JWT_SECRET,
            { expiresIn: "1h" }
        );

        res.json({ message: "Inicio de sesión exitoso", token });
    } catch (error) {
        console.error("Error en el login:", error.message);
        res.status(500).json({ message: "Error interno del servidor" });
    }
});

//Ruta protegida: obtener datos del usuario autenticado
router.get("/perfil", verificarToken, async (req, res) => {
    try {
        const usuario = await pool.query("SELECT id, nombre, email, fecha_registro FROM usuarios WHERE id = $1", [req.usuario.id]);

        if (usuario.rows.length === 0) {
            return res.status(404).json({ message: "Usuario no encontrado." });
        }

        res.json(usuario.rows[0]);
    } catch (error) {
        console.error("Error al obtener perfil:", error.message);
        res.status(500).json({ message: "Error al obtener perfil del usuario." });
    }
});

//Reservas Usuarios

router.get("/:usuarioId/reservas", verificarToken, async (req, res) => {
    try {
        const { usuarioId } = req.params;

        // Solo el usuario autenticado o un admin deberían poder ver las reservas
        if (req.usuario.id !== usuarioId) {
            return res.status(403).json({ message: "No autorizado" });
        }

        const result = await pool.query(
            "SELECT r.id, r.fecha_reserva, v.numero_vuelo, v.estado FROM reservas r JOIN vuelos v ON r.id_vuelo = v.id WHERE r.id_usuario = $1",
            [usuarioId]
        );

        res.json(result.rows);
    } catch (error) {
        console.error("Error al obtener reservas del usuario:", error);
        res.status(500).json({ message: "Error al obtener reservas" });
    }
});




module.exports = router;

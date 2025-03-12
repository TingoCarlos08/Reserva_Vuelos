const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const pool = require("../db"); // Conexión a la base de datos
require("dotenv").config();

const router = express.Router();

// **Registro de usuario**
router.post("/register", async (req, res) => {
    const { nombre, email, password } = req.body;

    try {
        // Validar que los campos no estén vacíos
        if (!nombre || !email || !password) {
            return res.status(400).json({ message: "Todos los campos son obligatorios" });
        }

        // Verificar si el usuario ya existe
        const existeUsuario = await pool.query("SELECT * FROM usuarios WHERE email = $1", [email]);
        if (existeUsuario.rows.length > 0) {
            return res.status(400).json({ message: "El usuario ya existe" });
        }

        // Hashear la contraseña antes de guardarla
        const salt = await bcrypt.genSalt(10);
        const passwordHasheado = await bcrypt.hash(password, salt);

        if (!passwordHasheado) {
            return res.status(500).json({ message: "Error al encriptar la contraseña" });
        }

        // Insertar usuario en la base de datos
        const nuevoUsuario = await pool.query(
            "INSERT INTO usuarios (nombre, email, password, fecha_registro) VALUES ($1, $2, $3, NOW()) RETURNING id, nombre, email, fecha_registro",
            [nombre, email, passwordHasheado]
        );

        res.status(201).json({ message: "Usuario registrado exitosamente", usuario: nuevoUsuario.rows[0] });

    } catch (error) {
        console.error("Error al registrar usuario:", error);
        res.status(500).json({ message: "Error al registrar usuario", detalles: error.message });
    }
});

// **Inicio de sesión**
router.post("/login", async (req, res) => {
    const { email, password } = req.body;

    try {
        // Validar que los campos no estén vacíos
        if (!email || !password) {
            return res.status(400).json({ message: "Email y contraseña son obligatorios" });
        }

        // Buscar usuario en la base de datos
        const usuario = await pool.query("SELECT * FROM usuarios WHERE email = $1", [email]);
        if (usuario.rows.length === 0) {
            return res.status(400).json({ message: "Usuario no encontrado" });
        }

        // Verificar la contraseña
        const passwordValida = await bcrypt.compare(password, usuario.rows[0].password);
        if (!passwordValida) {
            return res.status(401).json({ message: "Contraseña incorrecta" });
        }

        // Crear el token JWT
        const token = jwt.sign(
            { id: usuario.rows[0].id, email: usuario.rows[0].email },
            process.env.JWT_SECRET,
            { expiresIn: "2h" }
        );

        res.json({ message: "Inicio de sesión exitoso", token });

    } catch (error) {
        console.error("Error al iniciar sesión:", error);
        res.status(500).json({ message: "Error al iniciar sesión", detalles: error.message });
    }
});

// **Ruta protegida de prueba**
router.get("/perfil", async (req, res) => {
    try {
        const token = req.header("Authorization");

        if (!token) {
            return res.status(401).json({ message: "Acceso denegado. No hay token" });
        }

        const verificado = jwt.verify(token, process.env.JWT_SECRET);
        const usuario = await pool.query("SELECT id, nombre, email, fecha_registro FROM usuarios WHERE id = $1", [verificado.id]);

        if (usuario.rows.length === 0) {
            return res.status(404).json({ message: "Usuario no encontrado" });
        }

        res.json(usuario.rows[0]);
    } catch (error) {
        res.status(400).json({ message: "Token inválido" });
    }
});

function verificarToken(req, res, next) {
    const token = req.header("Authorization");
    if (!token) return res.status(401).json({ error: "Acceso denegado. No hay token" });

    try {
        const verificado = jwt.verify(token, process.env.JWT_SECRET);
        req.usuario = verificado;
        next();
    } catch (error) {
        res.status(400).json({ error: "Token no válido" });
    }
}

module.exports = router;  // Exporta solo el router

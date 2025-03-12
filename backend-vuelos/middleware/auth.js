const jwt = require("jsonwebtoken");
require("dotenv").config();

function verificarToken(req, res, next) {
    const token = req.header("Authorization");

    if (!token) {
        return res.status(401).json({ error: "Acceso denegado. No hay token" });
    }

    try {
        const tokenLimpio = token.replace("Bearer ", "").trim();

        const verificado = jwt.verify(tokenLimpio, process.env.JWT_SECRET);
        req.usuario = verificado;
        next();
    } catch (error) {
        return res.status(400).json({ error: "Token no válido" });
    }
}

module.exports = verificarToken;

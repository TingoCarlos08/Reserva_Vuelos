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

// const mysql = require('mysql2')
// const dotenv = require('dotenv');
// dotenv.config({ path: './env/.env' });

// const conexion = mysql.createConnection({
//     host : process.env.DB_HOST,
//     user : process.env.DB_USER,
//     password : process.env.DB_PASS,
//     database : process.env.DB_DATABASE,
//     port : process.env.DB_PORT,
// })

// conexion.connect((error) => {
//     if(error){
//         console.log('Error en la conexion a la BD: ' +error)
//         return
//     }
//     console.log('Conectado a la base de datos MySQL!')
// })

// module.exports = conexion

const mysql = require('mysql2');
const dotenv = require('dotenv');
dotenv.config({ path: './env/.env' });

let conexion;

function handleDisconnect() {
    conexion = mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASS,
        database: process.env.DB_DATABASE,
        port: process.env.DB_PORT,
    });

    // Conectar a la base de datos
    conexion.connect((err) => {
        if (err) {
            console.error('Error al conectar a la base de datos:', err);
            setTimeout(handleDisconnect, 2000); // Reintentar conexión tras 2 segundos
        } else {
            console.log('Conectado a la base de datos MySQL!');
        }
    });

    // Manejar errores de conexión
    conexion.on('error', (err) => {
        console.error('Error en la conexión:', err);
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.log('Conexión perdida. Reconectando...');
            handleDisconnect();
        } else {
            throw err;
        }
    });
}

// Inicializar la conexión
handleDisconnect();

module.exports = conexion;

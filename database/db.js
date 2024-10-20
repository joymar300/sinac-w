const mysql = require('mysql2')
const dotenv = require('dotenv');
dotenv.config({ path: './env/.env' });

const conexion = mysql.createConnection({
    host : process.env.DB_HOST,
    user : process.env.DB_USER,
    password : process.env.DB_PASS,
    database : process.env.DB_DATABASE,
    port : process.env.DB_PORT,
})

conexion.connect((error) => {
    if(error){
        console.log('Error en la conexion a la BD: ' +error)
        return
    }
    console.log('Conectado a la base de datos MySQL!')
})

module.exports = conexion
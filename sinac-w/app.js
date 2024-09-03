const express = require('express')
const dotenv = require('dotenv')
const cookieParser = require('cookie-parser')
//const Swal = require('sweetalert2')
const port = 8080;

const app = express()

//SET VIEW ENGINE (MOTOR DE PLANTILLA)
app.set('view engine', 'ejs');
app.set('views', './views')

//SET PUBLIC FOLDER para archivos estaticos
app.use(express.static('public'))


//PROCESAR datos desde formularios
app.use(express.urlencoded({extended:true}))
app.use(express.json())

//SET variables de entorno
dotenv.config({path: './env/.env'}) 

//Trabajar con las cookies de login
app.use(cookieParser())


//ROUTES Llamar al router para las rutas
app.use('/', require('./routes/router'))

//para eliminar el cache y no se pueda volver con el boton de atras despues del LOGOUT
app.use(function(req, res, next){
    if (!req.email)
        res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
        next();
    });


app.listen (port, () => {
    console.log(`Ejecutando servidor en puerto ${port}`)
});



//  const express = require('express');
//  const dotenv = require('dotenv');
//  const cookieParser = require('cookie-parser');
//  const { promisify } = require('util');
//  const jwt = require('jsonwebtoken');
//  const conexion = require('./database/db'); // Asegúrate de tener la conexión a la base de datos
//  const port = 8080
//  const app = express()
//  // Cargar variables de entorno
//  dotenv.config({ path: './env/.env' })
//  // Configurar motor de plantillas
//  app.set('view engine', 'ejs');
//  app.set('views', './views')
//  // Configurar carpeta pública para archivos estáticos
//  app.use(express.static('public'))
//  // Procesar datos desde formularios
//  app.use(express.urlencoded({ extended: true }));
//  app.use(express.json())
//  // Trabajar con las cookies
//  app.use(cookieParser())
//  // Middleware para establecer `idRol` en `res.locals`
//  app.use(async (req, res, next) => {
//      if (req.cookies.jwt) {
//          try {
//              const decoded = await promisify(jwt.verify)(req.cookies.jwt, process.env.JWT_SECRETO);
//              conexion.query('SELECT idRol, id, usuCedula  FROM usuario as u, rol as r WHERE r.idRol = u.Rol_idRol AND id = ?', [decoded.id], (error, results) => {
//                  if (error) {
//                      console.error('Error en la consulta de usuario:', error);
//                      return next();
//                  }
//                  res.locals.idRol = results[0]?.idRol || null;
//                  res.locals.id = results[0]?.id || null;
//                  res.locals.cedula = results[0]?.usuCedula || null;
//                  console.log("ide ro dwdas ", res.locals.idRol, "id", res.locals.id, "cedula:",res.locals.cedula )
//                  next();
//              });
//          } catch (error) {
//              console.error('Error al verificar JWT:', error);
//              res.locals.idRol = null;
//              next();
//          }
//      } else {
//          res.locals.idRol = null;
//          next();
//      }
//  })
//  // Middleware para eliminar caché y no permitir retroceso después del logout
//  app.use((req, res, next) => {
//      if (!req.email) {
//          res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
//      }
//      next();
//  })
//  // Rutas
//  app.use('/', require('./routes/router'))
//  // Iniciar el servidor
//  app.listen(port, () => {
//      console.log(`Ejecutando servidor en puerto ${port}`);
//  })


//---------------------------------------------------
const express = require('express');
const dotenv = require('dotenv');
const cookieParser = require('cookie-parser');
const { promisify } = require('util');
const jwt = require('jsonwebtoken');
const conexion = require('./database/db'); // Asegúrate de tener la conexión a la base de datos
const path = require('path');

const app = express();

// Cargar variables de entorno
dotenv.config({ path: './env/.env' });

// Configurar motor de plantillas
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views')); // Usa una ruta absoluta

// Configurar carpeta pública para archivos estáticos
app.use(express.static(path.join(__dirname, 'public'))); // Usa una ruta absoluta

// Procesar datos desde formularios
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Trabajar con las cookies
app.use(cookieParser());

// Middleware para establecer `idRol` en `res.locals`
app.use(async (req, res, next) => {
    if (req.cookies.jwt) {
        try {
            const decoded = await promisify(jwt.verify)(req.cookies.jwt, process.env.JWT_SECRETO);
            conexion.query(
                'SELECT idRol, id, usuCedula FROM usuario as u, rol as r WHERE r.idRol = u.Rol_idRol AND id = ?',
                [decoded.id],
                (error, results) => {
                    if (error) {
                        console.error('Error en la consulta de usuario:', error);
                        return next();
                    }
                    res.locals.idRol = results[0]?.idRol || null;
                    res.locals.id = results[0]?.id || null;
                    res.locals.cedula = results[0]?.usuCedula || null;
                    console.log("Rol ID:", res.locals.idRol, "User ID:", res.locals.id, "Cedula:", res.locals.cedula);
                    next();
                }
            );
        } catch (error) {
            console.error('Error al verificar JWT:', error);
            res.locals.idRol = null;
            next();
        }
    } else {
        res.locals.idRol = null;
        next();
    }
});

// Middleware para eliminar caché y no permitir retroceso después del logout
app.use((req, res, next) => {
    if (!req.email) {
        res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
    }
    next();
});

// Rutas
app.use('/', require('./routes/router'));

// Exportar la app para Vercel
module.exports = app;

const express = require('express')
const router = express.Router()
//Panel dinamico
const jwt = require('jsonwebtoken')
const {promisify} = require('util')


//CONEXION a la base de datos
const conexion = require('../database/db')

//REQUIRE controlador auth
const authController = require('../controllers/authController')
const update = require('../controllers/authController')
const { pbkdf2 } = require('crypto')

//ROUTER para las vistas GET
router.get('/', (req, res) => {
    res.render('index')
})
router.get('/login', (req, res) => {
    res.render('login', {alert:false})
})
router.get('/panel', async (req, res) => {
    try {
        const decodificada = await (promisify(jwt.verify)(req.cookies.jwt, process.env.JWT_SECRETO))
        conexion.query('SELECT usuNombre, usuApellidoP, usuApellidoM, idRol, roNombre FROM usuario as u, rol as r WHERE r.idRol = u.Rol_idRol AND id = ?', [decodificada.id], (error, results) =>{
            let rol = results[0].idRol
            let user = results[0]
            if (rol == 1 || rol == 2){
                res.render('panel', {nombre:user})
            } else if (rol == 3){
                res.render('panelDocente', {nombre:user})
            } else if (rol == 4){
                res.render('panelEstudiante', {nombre:user})
            }
        })

    } catch (error) {
        console.log(error)
    }
})
router.get('/panelNavBar', (req, res) => {
    res.render('panelNavBar', {
        idRol: res.locals.idRol
    });
});

router.get('/registro',authController.isAuthenticated, authController.isAdmin, (req, res) => {
    res.render('registro', {alert:false})
})
router.get('/matricula', (req, res) => {
    res.render('matricula')
})

router.get('/docente', (req, res) =>{
    conexion.query('SELECT * FROM grado ORDER BY graNombre ASC', (error, results) =>{
        if (error){
            throw error
        }else{
            conexion.query('SELECT * FROM materia', (error, materia) => {
                if (error){
                    throw error
                }else{
                    res.render('regDocente', {grado:results, materia:materia})
                }
            })
        }
    })

})

router.get('/materia', (req, res) => {
    conexion.query('SELECT * FROM grado ORDER BY graNombre ASC', (error, results) => {
        if (error){
            throw error
        }else{
            conexion.query('SELECT * FROM materia', (error, materia) =>{
                if (error){
                    throw error
                }else{
                    res.render('materia', {results:results, materia:materia})
                }
            })
        }
    })

})

router.get('/notas', (req, res) => {
    conexion.query('SELECT * FROM grado ORDER BY graNombre ASC', (error, results) => {
        if (error){
            throw error
        }else{
            conexion.query('SELECT * FROM materia', (error, materia) =>{
                if (error){
                    throw error
                }else{
                    res.render('regNotas', {results:results, materia:materia, alert:false})
                }
            })
        }
    })

})

//CALCULO DE PORCENTAJES
router.get('/calcular', (req, res) => {
    conexion.query('SELECT * FROM grado ORDER BY graNombre ASC', (error, results) => {
        if (error){
            throw error
        }else{
            conexion.query('SELECT * FROM materia', (error, materia) =>{
                if (error){
                    throw error
                }else{
                    res.render('porcent', {results:results, materia:materia, alert:false})
                }
            })
        }
    })
})

router.get('/grado', (req, res) => {
    res.render('cGrado', {alert:false})
})

router.get('/planta', (req, res) => {
    conexion.query('SELECT id, usuCedula, usuNombre, usuApellidoP, matNombre, graNombre as grados FROM usuario AS U, materia AS M, DocenteMateria AS DM, grado AS G WHERE U.id = DM.Docente_Usuario_id AND DM.Materia_idMateria = M.idMateria AND G.idGrado = DM.Grado_idGrado;', (error, results) =>{
        res.render('plaDocente', {results:results})
    })
})

router.get('/eventos', (req, res) => {
    conexion.query('SELECT * FROM eventos ORDER BY id DESC', (error, results) =>{
        res.render('eventos', {results:results})
    })
})

//Rutas para generacion de boletin
router.get('/boletin', (req, res) => {
    res.render('geneBoletin')
})

router.get('/boletin_estudiante', (req, res) =>{
    res.render('boleEstu')
})

router.get('/boletin_grupo', (req, res) => {
    conexion.query('SELECT * FROM grado ORDER BY graNombre ASC', (error, results) => {
        if (error){
            throw error
        }else{
            res.render('boleGrupo', {results:results})
        }
    })
})

router.get('/consulta', (req, res) => {
    res.render('consuCedula')
})

router.get('/buscar_matricula', (req, res) =>{
    res.render('matriEstu')
})

router.get('/salon', (req, res) => {
    conexion.query('SELECT * FROM grado ORDER BY graNombre ASC', (error, results) => {
        if (error) {
            throw error
        }else{
            res.render('consuGrupo', {results:results, alert:false})
        }
    })

})

router.get('/boleta', (req, res) =>{
    res.render('boletaEstudiante')
})


//ROUTER para metodos de authController
router.post('/login', authController.login)
router.post('/registro', authController.registro)
router.post('/matricula', authController.matricula)
router.post('/materia', authController.materia)
router.post('/docente', authController.docente)
router.post('/notas', authController.notas)
router.post('/grado', authController.grado)
router.post('/salon', authController.salon)
router.post('/consulta', authController.consulta)
router.post('/calcular', authController.calcular)
router.post('/buscar_matricula', authController.geneMatricula2)
router.post('/update', authController.update)
router.get('/logout', authController.logout)


module.exports = router
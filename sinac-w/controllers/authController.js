const jwt = require('jsonwebtoken')
const bcryptjs = require('bcryptjs')
const conexion = require('../database/db')
const {promisify} = require('util')
const pdf = require('html-pdf')
const path = require('path')
const ejs = require('ejs')

//procedimiento de registro usuarios
//Verificar en base de datos si la cedula ya esta
exports.registro = async (req, res) => {

    try {
        const rol = req.body.rol
        const cedula = req.body.cedula
        const nombre1 = req.body.nombre1
        const nombre2 = req.body.nombre2
        const apellido1 = req.body.apellido1
        const apellido2 = req.body.apellido2
        const telefono = req.body.telefono
        const vivienda = req.body.vivienda
        const email = req.body.email
        const password = req.body.password
        let passHash = await bcryptjs.hash(password, 8)
        //console.log(passHash)

        conexion.query('SELECT * FROM usuario WHERE usuCedula = ?', [cedula], (error, results)=>{
            if (results.length == 1){
                res.render('registro', {
                    alert:true,
                    alertTitle: 'Error',
                    alertMessage: 'Usuario ya se encuentra en sistema',
                    alertIcon: 'warning',
                    showConfirmButton: true,
                    timer: false,
                    ruta: 'registro'
                })
            }else{
                conexion.query('INSERT INTO usuario SET ?', {Rol_idRol:rol, usuCedula:cedula, usuNombre:nombre1, usuNombre2:nombre2, 
                    usuApellidoP:apellido1, usuApellidoM:apellido2, 
                    usuTelefono:telefono, usuDireccion:vivienda, usuCorreo:email, usuPassword:passHash}, (error, results)=>{
                    if (error){console.log(error)}
                    res.render('registro', {
                        alert:true,
                        alertTitle: 'Registro exitoso',
                        alertMessage: 'El usuario se registró con éxito',
                        alertIcon: 'success',
                        showConfirmButton: true,
                        timer: 800,
                        ruta: 'panel'
                    })
                    })

            }

        })

    } catch (error) {
        console.log(error)
    }
}


//procedimiento matricula de estudiante
exports.matricula = (req, res) => {
    const cedula = req.body.cedula
    const pago = req.body.pago
    const fechaNac = req.body.fechaNac
    const sexo = req.body.sexo
    conexion.query('SELECT id from usuario WHERE usuCedula = ?', [cedula], (error, results)=>{
        if (results.length == 0){
            res.render('blank', {
                alert:true,
                alertTitle: 'Error',
                alertMessage: 'Usuario no se encuentra registrado',
                alertIcon: 'error',
                showConfirmButton: true,
                timer: false,
                ruta: 'matricula'
            })
        }else{
            let id = results[0].id
            //console.log(results)
            //console.log(id)
            //console.log(pago, fechaNac, sexo)
    
            conexion.query('INSERT INTO estudiante SET ?', {Usuario_id:id, estPago:pago, 
                estNacimiento:fechaNac, estSexo:sexo}, (error, results) =>{
                if (error){console.log(error)} 
                res.redirect('/materia')   
            })
        }
    })  
}

exports.grado = (req, res) => {
    const grado = req.body.grado
    console.log(grado)

    conexion.query('SELECT * FROM grado WHERE graNombre = ?', [grado], (error, results)=>{
        if (results.length == 1){
            res.render('cGrado', {
                alert:true,
                alertTitle: 'Error',
                alertMessage: 'El grado ya existe en el sistema',
                alertIcon: 'warning',
                showConfirmButton: true,
                timer: false,
                ruta: 'grado'
            })
        }else{
            conexion.query('INSERT INTO grado SET ?', {graNombre:grado}, (error, results) =>{
                if(error){console.log(error)}
                res.render('cGrado', {
                    alert:true,
                    alertTitle: 'Registro exitoso',
                    alertMessage: 'El grado se ha registrado con éxito',
                    alertIcon: 'success',
                    showConfirmButton: true,
                    timer: 800,
                    ruta: 'panel'
                })
            })
        }
    })

}

//OPTIMIZAR BUCLES DESPUES
exports.materia = (req, res) => {
    const cedula = req.body.cedula
    const grado = req.body.grado
    const materias = req.body.materia
    //console.log(cedula)
    conexion.query('SELECT * FROM usuario WHERE usuCedula = ?', [cedula], (error, results) =>{
        if (results.length == 0){
            res.render('blank', {
                alert:true,
                alertTitle: 'Error',
                alertMessage: 'Usuario no se encuentra registrado',
                alertIcon: 'error',
                showConfirmButton: true,
                timer: false,
                ruta: 'materia'
            })
        }else{
            let id = results[0].id
            //console.log(results)
            //console.log(id)
            //console.log(grado)
            //ITERAR por todo el contenido de materia (que es un array)
            for (let i = 0; i < materias.length; i++) {
                const materia = materias[i]
                //console.log(materia)
                //console.log('El codigo de la materia es: '+materia+' El id de cedula: '+id+' En el grado: '+grado)
    
                conexion.query('INSERT INTO grupo SET ?', {Grado_idGrado:grado, Materia_idMateria:materia, Estudiante_Usuario_id:id}, (error, results)=>{
                    if(error){console.log(error)}
                    //El bucle sigue
                    conexion.query('SELECT * FROM periodo', (error, results) =>{
                        for (let j = 0; j < results.length; j++) {
                            const periodo = results[j].idPeriodo;
                            //console.log(periodo)
    
                            conexion.query('INSERT INTO evaluaciones SET ?', {Materia_idMateria:materia, Estudiante_Usuario_id:id,Periodo_idPeriodo:periodo, Grado_idGrado:grado, eva1:null, eva2:null, eva3:null,eva4:null,eva5:null,eva6:null,eva7:null,eva8:null,eva9:null,eva10:null, promedio:null}, (error, results) => {
                                if (error){console.log(error)}
                            })
                            
                        }
                        
                    })
                })
                //Bucle sigue aca tambien
    
            }
            if (error){console.log(error)}
            res.render('blank',{
                alert:true,
                alertTitle: 'Registro exitoso',
                alertMessage: 'Estudiante matriculado con éxito',
                alertIcon: 'success',
                showConfirmButton: true,
                timer: false,
                ruta: 'panel'
            })
        }

    })

}

//TERMINAR, MODIFICAR EL DOM DE LA SIGUIENTE INTERFAZ
exports.notas = (req, res) => {
    const grado = req.body.grado
    const materia = req.body.materia
    const periodo = req.body.periodo
    const cedula = req.body.cedula
    //console.log(grado, materia, periodo, cedula)
    conexion.query('SELECT DISTINCT id, usuCedula, usuNombre, usuNombre2, usuApellidoP, usuApellidoM, idMateria, matNombre, idGrado, graNombre, idPeriodo, perNombre, eva1, eva2, eva3, eva4, eva5, eva6, eva7, eva8, eva9, eva10 FROM usuario AS U, evaluaciones AS E, materia AS M, periodo AS P, grupo AS G, grado AS S WHERE U.id = E.Estudiante_Usuario_id AND M.idMateria = E.Materia_idMateria AND P.idPeriodo = E.Periodo_idPeriodo AND G.Grado_idGrado = S.idGrado AND M.idMateria = G.Materia_idMateria AND idGrado = ? AND idMateria = ? AND Periodo_idPeriodo = ? ',[grado, materia, periodo], (error, results) =>{
        if (results.length == 0){
            res.render('blank', {
                alert:true,
                alertTitle: 'Error',
                alertMessage: 'El estudiante no se encuentra en ese grado y/o materia',
                alertIcon: 'error',
                showConfirmButton: true,
                timer: false,
                ruta: 'notas'
            })
        }else{
            ubica = results[0]
            console.log(results)
            //console.log('Se ha cargado con exito la plantilla tablaNotas')
    
            res.render('tablaNotas', {results:results, place:ubica, alert:false})
    
            if (error){console.log(error)}

        }

    })
}

exports.docente = (req, res) =>{
    const cedula = req.body.cedula
    const materias = req.body.materia
    const grados = req.body.grado
    //console.log(cedula, materias, grados)
    conexion.query('SELECT * FROM usuario WHERE usuCedula = ?', [cedula], (error, results) =>{
        if (results.length == 0){
            res.render('blank', {
                alert:true,
                alertTitle: 'Error',
                alertMessage: 'Usuario no se encuentra registrado',
                alertIcon: 'error',
                showConfirmButton: true,
                timer: false,
                ruta: 'docente '
            })
        }else{
            id = results[0].id
            //console.log(id)
    
            conexion.query('INSERT INTO docente SET ?', {Usuario_id:id}, (error, results) => {
                if (error) {console.log(error)}
            })
    
            for (const materia of materias) {
                //console.log(materia)
    
                for (const grado of grados) {
                    //console.log(grado)
                    
                    //console.log('La materia: '+materia+ ' Inscrita en salon: '+grado)
                    conexion.query('INSERT INTO docentemateria SET ?', {Docente_Usuario_id:id, Materia_idMateria:materia, Grado_idGrado:grado}, (error, results) => {
                        if (error) {console.log(error)}
                        
                    })
                }
                
            } //console.log('DOCENTE SE HA REGISTRADO EXITOSAMENTE')
              res.render('blank', {
                alert:true,
                alertTitle: 'Registro exitoso',
                alertMessage: 'El docente se registró con éxito',
                alertIcon: 'success',
                showConfirmButton: true,
                timer: false,
                ruta: 'panel'
              })
        }
    })

}

exports.update = async (req, res) => {
    try {
        const id = req.body.id
        const materia = req.body.materia
        const periodo = req.body.periodo
        const eva1 = req.body.eva1
        const eva2 = req.body.eva2
        const eva3 = req.body.eva3
        const eva4 = req.body.eva4
        const eva5 = req.body.eva5
        const eva6 = req.body.eva6
        const eva7 = req.body.eva7
        const eva8 = req.body.eva8
        const eva9 = req.body.eva9
        const eva10 = req.body.eva10
    
        //console.log(id, materia, periodo, eva1)
    
        conexion.query('UPDATE evaluaciones SET eva1 = ?, eva2 = ?, eva3 = ?, eva4 = ?, eva5 = ?, eva6 = ?, eva7 = ?, eva8 = ?, eva9 = ?, eva10 = ? WHERE Estudiante_Usuario_id = ? AND Materia_idMateria = ? AND Periodo_idPeriodo = ?', [eva1, eva2, eva3, eva4, eva5, eva6, eva7, eva8, eva9, eva10, id, materia, periodo], (error, results) =>{
            if (error){console.log(error)}
            res.render('blank', {
                alert:true,
                alertTitle: 'Notas actualizadas',
                alertMessage: 'Las notas han sido actualizadas con éxito',
                alertIcon: 'success',
                showConfirmButton: true,
                timer: false,
                ruta: 'notas'
            })
        })
        const decodificada = await (promisify(jwt.verify)(req.cookies.jwt, process.env.JWT_SECRETO))
        const userID = decodificada.id
        let action = 'El usuario con ID: ' +userID+ ' ha actualizado notas'
        conexion.query('INSERT INTO eventos SET ?', {accion:action}, (error, results) =>{
            if (error){console.log(error)}
        } )
    } catch (error) {
        console.log(error)
    }
}

exports.consulta = async (req, res) => {
    try {
        const cedulaInput = req.body.cedula
        const tipo = req.body.tipo
        const decodificada = await (promisify(jwt.verify)(req.cookies.jwt, process.env.JWT_SECRETO))
        conexion.query('SELECT * FROM usuario WHERE id = ?', [decodificada.id], (error, results) => {
            const cedulaDB = results[0].usuCedula
            const rol = results[0].Rol_idRol
            if (rol == 4){
                if (cedulaInput != cedulaDB){
                    res.render('blank', {
                        alert:true,
                        alertTitle: 'Consulta inválida',
                        alertMessage: 'Solo puede consultar su información',
                        alertIcon: 'error',
                        showConfirmButton: true,
                        timer: false,
                        ruta: 'consulta'
                    })
                }else{
                    if (tipo == 'datos') {
                        conexion.query ('SELECT * FROM usuario WHERE usuCedula = ?', [cedulaInput], (error, results) =>{
                            res.render('consuUsuario', {usuario:results})
                        })
                        
                    }else{
                        conexion.query('SELECT DISTINCT usuNombre, usuApellidoP, usuApellidoM, matNombre, perNombre, eva1, eva2, eva3, eva4, eva5, eva6, eva7, eva8, eva9, eva10, promedio FROM usuario AS U, evaluaciones AS E, materia AS M, periodo AS P, grupo AS G, grado AS S WHERE U.id = E.Estudiante_Usuario_id AND M.idMateria = E.Materia_idMateria AND G.Grado_idGrado = S.idGrado AND P.idPeriodo = E.Periodo_idPeriodo AND E.Periodo_idPeriodo = P.idPeriodo AND usuCedula = ? ORDER BY perNombre', [cedulaInput], (error, results) =>{
                            const ubica = results[0] 
                            res.render('consuNotas', {notas:results, place:ubica})
                        })
                    }
                }
            }else{
                if (tipo == 'datos') {
                    conexion.query ('SELECT * FROM usuario WHERE usuCedula = ?', [cedulaInput], (error, results) =>{
                        res.render('consuUsuario', {usuario:results})
                    })
                    
                }else{
                    conexion.query('SELECT DISTINCT usuNombre, usuApellidoP, usuApellidoM, matNombre, perNombre, eva1, eva2, eva3, eva4, eva5, eva6, eva7, eva8, eva9, eva10, promedio FROM usuario AS U, evaluaciones AS E, materia AS M, periodo AS P, grupo AS G, grado AS S WHERE U.id = E.Estudiante_Usuario_id AND M.idMateria = E.Materia_idMateria AND G.Grado_idGrado = S.idGrado AND P.idPeriodo = E.Periodo_idPeriodo AND E.Periodo_idPeriodo = P.idPeriodo AND usuCedula = ? ORDER BY perNombre', [cedulaInput], (error, results) =>{
                        const ubica = results[0] 
                        res.render('consuNotas', {notas:results, place:ubica})
                    })
                }
            }
        })
    } catch (error) {
        console.log(error)
    }
}

exports.calcular = (req, res) => {
    const por1 = req.body.por1
    const por2 = req.body.por2
    const por3 = req.body.por3
    const por4 = req.body.por4
    const por5 = req.body.por5
    const por6 = req.body.por6
    const por7 = req.body.por7
    const por8 = req.body.por8
    const por9 = req.body.por9
    const por10 = req.body.por10

    const grado = req.body.grado
    const materia = req.body.materia
    const periodo = req.body.periodo

    conexion.query('SELECT DISTINCT id, usuNombre, usuNombre2, usuApellidoP, usuApellidoM, idMateria, graNombre, idPeriodo, perNombre, eva1, eva2, eva3, eva4, eva5, eva6, eva7, eva8, eva9, eva10 FROM usuario AS U, evaluaciones AS E, materia AS M, periodo AS P, grupo AS G, grado AS S WHERE U.id = E.Estudiante_Usuario_id AND M.idMateria = E.Materia_idMateria AND P.idPeriodo = E.Periodo_idPeriodo AND G.Grado_idGrado = S.idGrado AND M.idMateria = G.Materia_idMateria AND E.Grado_idGrado = G.Grado_idGrado AND idGrado = ? AND idMateria = ? AND Periodo_idPeriodo = ?', [grado, materia, periodo], (error, results) =>{
        //console.log(results)

        for (const result of results) {

            let id = result.id
            let materia = result.idMateria
            let cal1 = result.eva1 * por1
            let cal2 = result.eva2 * por2
            let cal3 = result.eva3 * por3
            let cal4 = result.eva4 * por4
            let cal5 = result.eva5 * por5
            let cal6 = result.eva6 * por6
            let cal7 = result.eva7 * por7
            let cal8 = result.eva8 * por8
            let cal9 = result.eva9 * por9
            let cal10 = result.eva10 * por10

            let total = (cal1+cal2+cal3+cal4+cal5+cal6+cal7+cal8+cal9+cal10)
            let promedio = Math.round((total + Number.EPSILON) * 100) / 100

            //console.log('Usuario id: '+id+' Con la materia: '+materia+' En el periodo '+periodo+ ' Tiene un promedio de: ' +promedio)
            

            conexion.query('UPDATE evaluaciones SET promedio = ? WHERE Materia_idMateria = ? AND Estudiante_Usuario_id = ? AND Periodo_idPeriodo = ?', [promedio, materia, id, periodo], (error, results) =>{
                if (error){console.log(error)}
            })
            
        } res.render('blank', {
            alert:true,
            alertTitle: 'Notas ponderadas',
            alertMessage: 'Las notas han sido ponderadas con éxito',
            alertIcon: 'success',
            showConfirmButton: true,
            timer: false,
            ruta: 'panel'
        })

    })

}

exports.salon = (req, res) => {
    const grado = req.body.grado
    if (!grado){
        res.render('blank', {
            alert:true,
            alertTitle: 'Error',
            alertMessage: 'Por favor seleccione un grado a consultar',
            alertIcon: 'warning',
            showConfirmButton: true,
            timer: false,
            ruta: 'salon'
        })
    }else{
    //console.log(grado)
        conexion.query('SELECT DISTINCT id, usuCedula, usuNombre, usuNombre2, usuApellidoP, usuApellidoM, usuTelefono, graNombre FROM usuario AS U, grupo AS G, grado AS S WHERE U.id = G.Estudiante_Usuario_id AND G.Grado_idGrado = S.idGrado AND idGrado = ?', [grado], (error, results) =>{
            //console.log(results.length)
            if (results.length == 0){
                res.render('blank', {
                    alert:true,
                    alertTitle: 'Error',
                    alertMessage: 'No hay estudiantes matriculados en este grado',
                    alertIcon: 'error',
                    showConfirmButton: true,
                    timer: false,
                    ruta: 'salon'
                })
            }else{
                conexion.query('SELECT DISTINCT id, usuCedula, usuNombre, usuNombre2, usuApellidoP, usuApellidoM, usuTelefono, graNombre FROM usuario AS U, grupo AS G, grado AS S WHERE U.id = G.Estudiante_Usuario_id AND G.Grado_idGrado = S.idGrado AND idGrado = ?', [grado], (error, results)=>{
                    const place = results[0]
                    res.render('grupo', {results:results, place:place})
                })

            }

        })

    }

}

exports.geneMatricula = (req, res) => {
    const cedula = req.body.cedula
    conexion.query('SELECT * FROM usuario WHERE usuCedula = ?', [cedula], (error, results) =>{
        if (results.length == 0){
            res.render('blank', {
                alert:true,
                alertTitle: 'Error',
                alertMessage: 'Usuario no se encuentra registrado',
                alertIcon: 'error',
                showConfirmButton: true,
                timer: false,
                ruta: 'panel '
            })
        }else{
            const id = results[0].id
            conexion.query('SELECT * FROM estudiante WHERE Usuario_id = ?', [id], (error, matricula) =>{
                res.render('matriculaEstudiante', {results:results, matricula:matricula})
            })
        }
    })
}

exports.geneMatricula2 = (req, res) => {
    const cedula = req.body.cedula
    conexion.query('SELECT * FROM usuario WHERE usuCedula = ?', [cedula], (error, results) =>{
        if (results.length == 0){
            res.render('blank', {
                alert:true,
                alertTitle: 'Error',
                alertMessage: 'Usuario no se encuentra registrado',
                alertIcon: 'error',
                showConfirmButton: true,
                timer: false,
                ruta: 'panel '
            })
        }else{
            const id = results[0].id
            conexion.query('SELECT * FROM estudiante WHERE Usuario_id = ?', [id], (error, matricula) =>{
                ejs.renderFile(path.join(__dirname, '../views/', 'matriculaEstudiante.ejs'), {
                    results:results, 
                    matricula:matricula
                }, (error, data) => {
                    if (error){
                        res.send(error)
                    }else{
                        var options = {
                            "format": "Letter"
                        }
                    }
                    pdf.create(data,options).toFile('matricula.pdf', function(error, data){
                        if (error){
                            res.send(error)
                        }else{
                            res.send('Matricula creada con éxito!')
                        }
                    })

                    })
                
            })
        }
    })
}


exports.login = async (req, res) => {

    try {
        const email = req.body.email
        const pass = req.body.password
       if(!email || !pass ){
       res.render('login', {
            alert:true,
            alertTitle: 'Advertencia',
            alertMessage: 'Ingrese Correo y Contraseña',
            alertIcon: 'warning',
            showConfirmButton: true,
            timer: false,
            ruta: 'login'
           })
        }else{
            conexion.query('SELECT * FROM usuario WHERE usuCorreo = ?', [email], async (error, results)=>{
                if (results.length == 0 || ! (await bcryptjs.compare(pass, results[0].usuPassword)) ) {
                    res.render('login', {
                        alert:true,
                        alertTitle: 'Error',
                        alertMessage: 'Correo y/o Contraseña incorrecta',
                        alertIcon: 'error',
                        showConfirmButton: true,
                        timer: false,
                        ruta: 'login'
                    })
                }else{
                    //inicio de sesion OK
                    const cedula = results[0].usuCedula
                    const id = results[0].id
                    const rol = results[0].Rol_idRol
                    const token = jwt.sign({id:id}, process.env.JWT_SECRETO, {
                        expiresIn: process.env.JWT_TIEMPO_EXPIRA
                    })
                    //Se obtiene la IP del cliente
                    var ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress
                    //console.log(ip)

                    const action = "Inicio de sesion Usuario: " +email + " con Cedula " +cedula
                    //Se envia el ingreso a sistema a la base de datos
                    conexion.query('INSERT INTO eventos SET ?', {accion:action}, (error, results)=>{
                        if (error) {console.log(error)}
                    })

                    //console.log("Token: " +token+ " para el usuario: " +email)

                    const cookiesOptions = {
                        expires: new Date(Date.now()+process.env.JWT_COOKIE_EXPIRES * 24 * 60 * 60 * 1000),
                        httpOnly: true
                    }
                    if (rol == 1 || rol == 2 || rol == 3){
                        const tokenCol = jwt.sign({id:id, rol:rol}, process.env.COL_SECRETO, {
                            expiresIn: process.env.JWT_TIEMPO_EXPIRA
                        })

                        res.cookie('jwt', token, cookiesOptions)
                        res.cookie('col', tokenCol, cookiesOptions)
                        res.render('login', {
                            alert:true,
                            alertTitle: 'Conexión exitosa',
                            alertMessage: 'Login validado',
                            alertIcon: 'success',
                            showConfirmButton: false,
                            timer: 800,
                            ruta: 'panel'
                        })
                        
                    }else{
                        res.cookie('jwt', token, cookiesOptions)
                        res.render('login', {
                            alert:true,
                            alertTitle: 'Conexión exitosa',
                            alertMessage: 'Login validado',
                            alertIcon: 'success',
                            showConfirmButton: false,
                            timer: 800,
                            ruta: 'panel'
                        })

                    }
                }
            })
        }

    } catch (error) {
        console.log(error)
    }
}

exports.isAuthenticated = async (req, res, next) => {
    if (req.cookies.jwt) {
        try {
            const decodificada = await (promisify(jwt.verify)(req.cookies.jwt, process.env.JWT_SECRETO))
            conexion.query('SELECT * FROM usuario WHERE id = ?', [decodificada.id], (error, results)=>{
                if(!results){return next()}
                req.email = results[0]
                return next()
            })
        } catch (error) {
            console.log(error)
            return next()
        }
    }else{
        res.redirect('/login')
    }
}

exports.isAdmin = async (req, res, next) =>{
    if (req.cookies.col){
        try {
            const decodificar = await (promisify(jwt.verify)(req.cookies.col, process.env.COL_SECRETO))
            conexion.query('SELECT * FROM usuario WHERE id = ?',  [decodificar.id], (error, results)=>{
                if(!results){return next()}
                req.email = results[0]
                return next()
            })
        } catch (error) {
            console.log(error)
            return next()
            
        }
    }else{
        res.redirect('/panel')
    }
}

exports.logout = (req, res) => {
    res.clearCookie('jwt')
    res.clearCookie('col')
    return res.redirect('/')
}
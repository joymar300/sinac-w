-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-11-2022 a las 05:13:00
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `colsam`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coordinador`
--

CREATE TABLE `coordinador` (
  `Usuario_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente`
--

CREATE TABLE `docente` (
  `Usuario_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `docente`
--

INSERT INTO `docente` (`Usuario_id`) VALUES
(4),
(6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentemateria`
--

CREATE TABLE `docentemateria` (
  `Docente_Usuario_id` int(10) UNSIGNED NOT NULL,
  `Materia_idMateria` int(5) UNSIGNED NOT NULL,
  `Grado_idGrado` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `docentemateria`
--

INSERT INTO `docentemateria` (`Docente_Usuario_id`, `Materia_idMateria`, `Grado_idGrado`) VALUES
(4, 1, 1),
(4, 6, 1),
(6, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `Usuario_id` int(10) UNSIGNED NOT NULL,
  `estPago` varchar(2) NOT NULL,
  `estNacimiento` date NOT NULL,
  `estSexo` varchar(1) DEFAULT NULL,
  `estMatricula` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`Usuario_id`, `estPago`, `estNacimiento`, `estSexo`, `estMatricula`) VALUES
(5, 'Si', '2019-06-14', 'M', '0000-00-00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `Materia_idMateria` int(5) UNSIGNED NOT NULL,
  `Estudiante_Usuario_id` int(10) UNSIGNED NOT NULL,
  `Periodo_idPeriodo` int(10) UNSIGNED NOT NULL,
  `Grado_idGrado` int(10) UNSIGNED NOT NULL,
  `eva1` float DEFAULT NULL,
  `eva2` float DEFAULT NULL,
  `eva3` float DEFAULT NULL,
  `eva4` float DEFAULT NULL,
  `eva5` float DEFAULT NULL,
  `eva6` float DEFAULT NULL,
  `eva7` float DEFAULT NULL,
  `eva8` float DEFAULT NULL,
  `eva9` float DEFAULT NULL,
  `eva10` float DEFAULT NULL,
  `promedio` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `evaluaciones`
--

INSERT INTO `evaluaciones` (`Materia_idMateria`, `Estudiante_Usuario_id`, `Periodo_idPeriodo`, `Grado_idGrado`, `eva1`, `eva2`, `eva3`, `eva4`, `eva5`, `eva6`, `eva7`, `eva8`, `eva9`, `eva10`, `promedio`) VALUES
(1, 5, 1, 1, 4.8, 5, 4.1, 5, 0, 0, 0, 0, 0, 0, 4.72),
(1, 5, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 5, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 5, 1, 1, 5, 4, 3.9, 4.3, 0, 0, 0, 0, 0, 0, NULL),
(2, 5, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 5, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 5, 1, 1, 1.3, 4.1, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(6, 5, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 5, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Disparadores `evaluaciones`
--
DELIMITER $$
CREATE TRIGGER `log_registro_evaluaciones` AFTER UPDATE ON `evaluaciones` FOR EACH ROW BEGIN
	INSERT INTO eventos (accion)
    VALUE (concat('Nuevas notas estudiante id : ',NEW.Estudiante_Usuario_id, ', En materia id : ',NEW.Materia_idMateria, ', y periodo: ',NEW.Periodo_idPeriodo));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `id` int(11) NOT NULL,
  `accion` varchar(90) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `eventos`
--

INSERT INTO `eventos` (`id`, `accion`, `fecha`) VALUES
(1, '\"Se ha registrado el ingreso del usuario prueba con cedula default\"', '2022-09-17 21:43:51'),
(2, 'Se ha iniciado en el sistema el Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-17 21:49:23'),
(3, 'Se ha iniciado en el sistema el Usuario: fran@yahoo.es con Cedula 20468735', '2022-09-17 21:51:09'),
(4, 'Inicio de sesion Usuario: pandemio@gmail.com con Cedula 2020', '2022-09-17 21:52:23'),
(5, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-17 22:03:38'),
(6, 'Inicio de sesion Usuario: pandemio@gmail.com con Cedula 2020', '2022-09-17 22:07:08'),
(7, 'Inicio de sesion Usuario: fran@yahoo.es con Cedula 20468735', '2022-09-17 22:09:25'),
(8, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-18 14:28:43'),
(9, 'El usuario con ID: 4 ha actualizado notas', '2022-09-18 14:47:48'),
(10, 'Nuevas notas estudiante id : 5, En materia id : 6, y periodo: 1', '2022-09-18 14:50:10'),
(11, 'El usuario con ID: 4 ha actualizado notas', '2022-09-18 14:50:10'),
(12, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-18 22:17:43'),
(13, 'Inicio de sesion Usuario: pandemio@gmail.com con Cedula 2020', '2022-09-19 19:05:31'),
(14, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-21 14:32:20'),
(15, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-21 14:32:50'),
(16, 'Inicio de sesion Usuario: pandemio@gmail.com con Cedula 2020', '2022-09-21 19:49:57'),
(17, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-21 19:52:04'),
(18, 'Inicio de sesion Usuario: fran@yahoo.es con Cedula 20468735', '2022-09-21 19:52:38'),
(19, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-21 19:54:35'),
(20, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-28 17:28:37'),
(21, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-09-28 19:16:59'),
(22, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-10-03 17:50:10'),
(23, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-10-29 12:00:01'),
(24, 'Nuevas notas estudiante id : 5, En materia id : 2, y periodo: 1', '2022-10-29 15:22:51'),
(25, 'El usuario con ID: 4 ha actualizado notas', '2022-10-29 15:22:51'),
(26, 'Inicio de sesion Usuario: fran@yahoo.es con Cedula 20468735', '2022-10-29 16:31:16'),
(27, 'Inicio de sesion Usuario: pandemio@gmail.com con Cedula 2020', '2022-10-29 16:32:02'),
(28, 'Inicio de sesion Usuario: luispadron25@gmail.com con Cedula 1126710133', '2022-10-29 16:34:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado`
--

CREATE TABLE `grado` (
  `idGrado` int(10) UNSIGNED NOT NULL,
  `graNombre` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `grado`
--

INSERT INTO `grado` (`idGrado`, `graNombre`) VALUES
(1, '10A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `Grado_idGrado` int(10) UNSIGNED NOT NULL,
  `Materia_idMateria` int(5) UNSIGNED NOT NULL,
  `Estudiante_Usuario_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`Grado_idGrado`, `Materia_idMateria`, `Estudiante_Usuario_id`) VALUES
(1, 1, 5),
(1, 2, 5),
(1, 6, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `idMateria` int(5) UNSIGNED NOT NULL,
  `matNombre` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`idMateria`, `matNombre`) VALUES
(1, 'Ingles'),
(2, 'Python'),
(3, 'Historia'),
(4, 'Naturales'),
(5, 'Matematicas'),
(6, 'Informatica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodo`
--

CREATE TABLE `periodo` (
  `idPeriodo` int(10) UNSIGNED NOT NULL,
  `perNombre` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `periodo`
--

INSERT INTO `periodo` (`idPeriodo`, `perNombre`) VALUES
(1, 'Primer periodo'),
(2, 'Segundo periodo'),
(3, 'Tercer periodo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idRol` int(10) UNSIGNED NOT NULL,
  `roNombre` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idRol`, `roNombre`) VALUES
(1, 'Coordinador'),
(2, 'Secretario'),
(3, 'Docente'),
(4, 'Estudiante');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secretario`
--

CREATE TABLE `secretario` (
  `Usuario_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(10) UNSIGNED NOT NULL,
  `Rol_idRol` int(10) UNSIGNED NOT NULL,
  `usuCedula` int(15) UNSIGNED NOT NULL,
  `usuNombre` varchar(30) NOT NULL,
  `usuNombre2` varchar(45) DEFAULT NULL,
  `usuApellidoP` varchar(20) NOT NULL,
  `usuApellidoM` varchar(20) NOT NULL,
  `usuTelefono` int(10) UNSIGNED NOT NULL,
  `usuDireccion` varchar(50) NOT NULL,
  `usuCorreo` varchar(30) NOT NULL,
  `usuPassword` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `Rol_idRol`, `usuCedula`, `usuNombre`, `usuNombre2`, `usuApellidoP`, `usuApellidoM`, `usuTelefono`, `usuDireccion`, `usuCorreo`, `usuPassword`) VALUES
(4, 1, 1126710133, 'Luis', 'Jose', 'Padron', 'Paredes', 68451844, 'Bogota', 'admin@gmail.com', '$2a$08$U.Pz73xLobIUVeOg6lwZwOcklYG4ek6k4WY72UlmyKhKib.B5EpK6'),
(5, 4, 2020, 'Pandemio', 'Raul', 'Covid', 'Diez', 6584913, 'Cartagena', 'pandemio@gmail.com', '$2a$08$5yzBo8A//D8WLT7GvF3DMugrfuBGrxeNXyw96wrZA4j/Bh.6W/PTm'),
(6, 3, 20468735, 'Francisco', 'Manuel', 'Hernandez', 'Perez', 568794, 'Bogota', 'fran@yahoo.es', '$2a$08$lqd/NBzFC/b1xObZZux30e1as3C0c3ilTc0nTqaxDUKTU8tNEr0Vi');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD PRIMARY KEY (`Usuario_id`);

--
-- Indices de la tabla `docente`
--
ALTER TABLE `docente`
  ADD PRIMARY KEY (`Usuario_id`);

--
-- Indices de la tabla `docentemateria`
--
ALTER TABLE `docentemateria`
  ADD PRIMARY KEY (`Docente_Usuario_id`,`Materia_idMateria`,`Grado_idGrado`),
  ADD KEY `Materia_idMateria` (`Materia_idMateria`),
  ADD KEY `Grado_idGrado` (`Grado_idGrado`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`Usuario_id`);

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`Materia_idMateria`,`Estudiante_Usuario_id`,`Periodo_idPeriodo`,`Grado_idGrado`),
  ADD KEY `Estudiante_Usuario_id` (`Estudiante_Usuario_id`),
  ADD KEY `Periodo_idPeriodo` (`Periodo_idPeriodo`),
  ADD KEY `Grado_idGrado` (`Grado_idGrado`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `grado`
--
ALTER TABLE `grado`
  ADD PRIMARY KEY (`idGrado`);

--
-- Indices de la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD KEY `Estudiante_Usuario_id` (`Estudiante_Usuario_id`),
  ADD KEY `Materia_idMateria` (`Materia_idMateria`),
  ADD KEY `Grado_idGrado` (`Grado_idGrado`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`idMateria`);

--
-- Indices de la tabla `periodo`
--
ALTER TABLE `periodo`
  ADD PRIMARY KEY (`idPeriodo`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `secretario`
--
ALTER TABLE `secretario`
  ADD PRIMARY KEY (`Usuario_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Rol_idRol` (`Rol_idRol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `grado`
--
ALTER TABLE `grado`
  MODIFY `idGrado` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `idMateria` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idRol` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD CONSTRAINT `coordinador_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `docente`
--
ALTER TABLE `docente`
  ADD CONSTRAINT `docente_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `docentemateria`
--
ALTER TABLE `docentemateria`
  ADD CONSTRAINT `docentemateria_ibfk_1` FOREIGN KEY (`Docente_Usuario_id`) REFERENCES `docente` (`Usuario_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `docentemateria_ibfk_2` FOREIGN KEY (`Materia_idMateria`) REFERENCES `materia` (`idMateria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `docentemateria_ibfk_3` FOREIGN KEY (`Grado_idGrado`) REFERENCES `grado` (`idGrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `estudiante_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `evaluaciones_ibfk_1` FOREIGN KEY (`Materia_idMateria`) REFERENCES `materia` (`idMateria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `evaluaciones_ibfk_2` FOREIGN KEY (`Estudiante_Usuario_id`) REFERENCES `estudiante` (`Usuario_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `evaluaciones_ibfk_3` FOREIGN KEY (`Periodo_idPeriodo`) REFERENCES `periodo` (`idPeriodo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `evaluaciones_ibfk_4` FOREIGN KEY (`Grado_idGrado`) REFERENCES `grado` (`idGrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `grupo_ibfk_1` FOREIGN KEY (`Estudiante_Usuario_id`) REFERENCES `estudiante` (`Usuario_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `grupo_ibfk_2` FOREIGN KEY (`Materia_idMateria`) REFERENCES `materia` (`idMateria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `grupo_ibfk_3` FOREIGN KEY (`Grado_idGrado`) REFERENCES `grado` (`idGrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `secretario`
--
ALTER TABLE `secretario`
  ADD CONSTRAINT `secretario_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`Rol_idRol`) REFERENCES `rol` (`idRol`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

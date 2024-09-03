-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-09-2022 a las 23:30:28
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentemateria`
--

CREATE TABLE `docentemateria` (
  `Docente_Usuario_id` int(10) UNSIGNED NOT NULL,
  `Materia_idMateria` int(5) UNSIGNED NOT NULL,
  `Grado_idGrado` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `Usuario_id` int(10) UNSIGNED NOT NULL,
  `estPago` varchar(2) NOT NULL,
  `estNacimiento` date NOT NULL,
  `estSexo` varchar(1) DEFAULT NULL,
  `estMatricula` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `id` int(11) NOT NULL,
  `accion` varchar(90) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado`
--

CREATE TABLE `grado` (
  `idGrado` int(10) UNSIGNED NOT NULL,
  `graNombre` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `Grado_idGrado` int(10) UNSIGNED NOT NULL,
  `Materia_idMateria` int(5) UNSIGNED NOT NULL,
  `Estudiante_Usuario_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `idMateria` int(5) UNSIGNED NOT NULL,
  `matNombre` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodo`
--

CREATE TABLE `periodo` (
  `idPeriodo` int(10) UNSIGNED NOT NULL,
  `perNombre` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `usuCedula` int(15) UNSIGNED NOT NULL,
  `usuNombre` varchar(30) NOT NULL,
  `usuNombre2` varchar(30) NOT NULL,
  `usuApellidoP` varchar(20) NOT NULL,
  `usuApellidoM` varchar(20) NOT NULL,
  `usuTelefono` int(10) UNSIGNED NOT NULL,
  `usuDireccion` varchar(50) NOT NULL,
  `usuCorreo` varchar(30) NOT NULL,
  `usuPassword` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Indices de la tabla `secretario`
--
ALTER TABLE `secretario`
  ADD PRIMARY KEY (`Usuario_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `grado`
--
ALTER TABLE `grado`
  MODIFY `idGrado` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `idMateria` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `periodo`
--
ALTER TABLE `periodo`
  MODIFY `idPeriodo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD CONSTRAINT `coordinador_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `docente`
--
ALTER TABLE `docente`
  ADD CONSTRAINT `docente_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `docentemateria`
--
ALTER TABLE `docentemateria`
  ADD CONSTRAINT `docentemateria_ibfk_1` FOREIGN KEY (`Docente_Usuario_id`) REFERENCES `docente` (`Usuario_id`),
  ADD CONSTRAINT `docentemateria_ibfk_2` FOREIGN KEY (`Materia_idMateria`) REFERENCES `materia` (`idMateria`),
  ADD CONSTRAINT `docentemateria_ibfk_3` FOREIGN KEY (`Grado_idGrado`) REFERENCES `grado` (`idGrado`);

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `estudiante_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `evaluaciones_ibfk_1` FOREIGN KEY (`Materia_idMateria`) REFERENCES `materia` (`idMateria`),
  ADD CONSTRAINT `evaluaciones_ibfk_2` FOREIGN KEY (`Estudiante_Usuario_id`) REFERENCES `estudiante` (`Usuario_id`),
  ADD CONSTRAINT `evaluaciones_ibfk_3` FOREIGN KEY (`Periodo_idPeriodo`) REFERENCES `periodo` (`idPeriodo`),
  ADD CONSTRAINT `evaluaciones_ibfk_4` FOREIGN KEY (`Grado_idGrado`) REFERENCES `grado` (`idGrado`);

--
-- Filtros para la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `grupo_ibfk_1` FOREIGN KEY (`Estudiante_Usuario_id`) REFERENCES `estudiante` (`Usuario_id`),
  ADD CONSTRAINT `grupo_ibfk_2` FOREIGN KEY (`Materia_idMateria`) REFERENCES `materia` (`idMateria`),
  ADD CONSTRAINT `grupo_ibfk_3` FOREIGN KEY (`Grado_idGrado`) REFERENCES `grado` (`idGrado`);

--
-- Filtros para la tabla `secretario`
--
ALTER TABLE `secretario`
  ADD CONSTRAINT `secretario_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

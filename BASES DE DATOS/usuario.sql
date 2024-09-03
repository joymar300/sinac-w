-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-11-2022 a las 05:06:10
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
(4, 1, 1126710133, 'Luis', 'Jose', 'Padron', 'Paredes', 68451844, 'Bogota', 'luispadron25@gmail.com', '$2a$08$U.Pz73xLobIUVeOg6lwZwOcklYG4ek6k4WY72UlmyKhKib.B5EpK6'),
(5, 4, 2020, 'Pandemio', 'Raul', 'Covid', 'Diez', 6584913, 'Cartagena', 'pandemio@gmail.com', '$2a$08$5yzBo8A//D8WLT7GvF3DMugrfuBGrxeNXyw96wrZA4j/Bh.6W/PTm'),
(6, 3, 20468735, 'Francisco', 'Manuel', 'Hernandez', 'Perez', 568794, 'Bogota', 'fran@yahoo.es', '$2a$08$lqd/NBzFC/b1xObZZux30e1as3C0c3ilTc0nTqaxDUKTU8tNEr0Vi');

--
-- Índices para tablas volcadas
--

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
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`Rol_idRol`) REFERENCES `rol` (`idRol`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

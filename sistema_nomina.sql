-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-09-2023 a las 05:39:36
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_nomina`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anticipos`
--

CREATE TABLE `anticipos` (
  `id_anticipo` int(11) NOT NULL,
  `fecha_atencion` date DEFAULT NULL,
  `fecha_pago` date DEFAULT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `monto` decimal(5,2) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bauchers`
--

CREATE TABLE `bauchers` (
  `id_baucher` int(11) NOT NULL,
  `dias_laborados` int(11) DEFAULT NULL,
  `comisiones` decimal(10,2) DEFAULT NULL,
  `pago_realizado` decimal(10,2) DEFAULT NULL,
  `horas_bonificacion` decimal(10,2) DEFAULT NULL,
  `anticipo` decimal(10,2) DEFAULT NULL,
  `descuento_prestamo` decimal(10,2) DEFAULT NULL,
  `descuento_tienda` decimal(10,2) DEFAULT NULL,
  `descuento_igss` decimal(5,2) DEFAULT NULL,
  `descuento_isr` decimal(5,2) DEFAULT NULL,
  `descuento_irtra` decimal(5,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_nomina` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotas_prestamos`
--

CREATE TABLE `cuotas_prestamos` (
  `id_cutota` int(11) NOT NULL,
  `cuota` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `fecha_pagar` date DEFAULT NULL,
  `fecha_pago` date DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `valor_cuota` decimal(3,2) DEFAULT NULL,
  `id_prestamo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id_departamento` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `dpi` varchar(20) DEFAULT NULL,
  `nit` varchar(20) DEFAULT NULL,
  `igss` varchar(20) DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `salario_base` decimal(10,2) DEFAULT NULL,
  `fecha_contrato` datetime DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `genero` int(11) DEFAULT NULL,
  `codigo_empleado` varchar(15) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id_empleado`, `nombre`, `apellido`, `dpi`, `nit`, `igss`, `direccion`, `telefono`, `correo`, `salario_base`, `fecha_contrato`, `edad`, `genero`, `codigo_empleado`, `estado`, `hora_entrada`, `hora_salida`, `id_empresa`, `id_usuario`, `id_departamento`) VALUES
(1, 'Pedro', 'Roche Perez', '2398746523102', '93445678', '235667', 'San Antonio Suchitepequez', '55778899', NULL, 3500.00, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
(2, 'Daniel', 'Hernandez', '2398746523102', '93445678', '235667', 'San Antonio Suchitepequez', '55778899', NULL, 3500.00, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
(3, 'Javier', 'Gonzalez Ramirez', '2398746523102', '93445678', '235667', 'San Antonio Suchitepequez', '55778899', NULL, 3500.00, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id_empresa` int(11) NOT NULL,
  `nombre_empresa` varchar(200) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `fecha_retiro` date DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expedientes`
--

CREATE TABLE `expedientes` (
  `id_expediente` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `tipo_documento` varchar(255) DEFAULT NULL,
  `archivo_ruta` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familiares`
--

CREATE TABLE `familiares` (
  `id_familia` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `parentesco` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_aumentos`
--

CREATE TABLE `historial_aumentos` (
  `id` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `salario_anterior` decimal(10,2) DEFAULT NULL,
  `salario_nuevo` decimal(10,2) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horas_extras`
--

CREATE TABLE `horas_extras` (
  `id_hora` int(11) NOT NULL,
  `hora_diurna` decimal(3,2) DEFAULT NULL,
  `hora_nocturna` decimal(3,2) DEFAULT NULL,
  `id_nomina` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcaciones`
--

CREATE TABLE `marcaciones` (
  `id_marcacion` int(11) NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `hora_registro` date DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nominas`
--

CREATE TABLE `nominas` (
  `id_nomina` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `horas_trabajadas` decimal(5,2) DEFAULT NULL,
  `ausencia_dias` int(11) DEFAULT NULL,
  `horas_extra` decimal(3,2) DEFAULT NULL,
  `comisiones` decimal(5,2) DEFAULT NULL,
  `bonificaciones` decimal(5,2) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nomina_especial`
--

CREATE TABLE `nomina_especial` (
  `id_nomina_especial` int(11) NOT NULL,
  `nombre_nomina` varchar(100) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id_notificacion` int(11) NOT NULL,
  `asunto` varchar(200) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `fecha_envio` date DEFAULT NULL,
  `hora_envio` time DEFAULT NULL,
  `mensaje` varchar(500) DEFAULT NULL,
  `id_usuario_envia` int(11) DEFAULT NULL,
  `id_usuario_recibe` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planillas_especiales`
--

CREATE TABLE `planillas_especiales` (
  `id_planilla` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `id_nomina_especial` int(11) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `polizas_contables`
--

CREATE TABLE `polizas_contables` (
  `id_poliza` int(11) NOT NULL,
  `tipo_poliza` varchar(50) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id_prestamo` int(11) NOT NULL,
  `fecha_atencion` date DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `plazo_meses` int(11) DEFAULT NULL,
  `monto` decimal(5,2) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `id_usuario_solicita` int(11) DEFAULT NULL,
  `id_usuario_atiende` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `retenciones`
--

CREATE TABLE `retenciones` (
  `id_retencion` int(11) NOT NULL,
  `igss` decimal(3,2) DEFAULT NULL,
  `isr` decimal(3,2) DEFAULT NULL,
  `irtra` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`, `estado`) VALUES
(1, 'Administrador', 0),
(2, 'Empresa', 0),
(3, 'Empleado', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud_permisos`
--

CREATE TABLE `solicitud_permisos` (
  `id_solicitud` int(11) NOT NULL,
  `dias_solicitadas` int(11) DEFAULT NULL,
  `inicio_permiso` date DEFAULT NULL,
  `fin_permiso` date DEFAULT NULL,
  `descripcion` date DEFAULT NULL,
  `retorno_laboral` date DEFAULT NULL,
  `id_usuario_atiende` int(11) DEFAULT NULL,
  `id_usuario_solicita` int(11) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tienda_solidarista`
--

CREATE TABLE `tienda_solidarista` (
  `id_tienda` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `monto_compra` decimal(10,2) DEFAULT NULL,
  `fecha_compra` date DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `f_registro` varchar(20) DEFAULT NULL,
  `f_modificacion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `usuario`, `password`, `estado`, `id_rol`, `id_empresa`, `f_registro`, `f_modificacion`) VALUES
(1, 'proche', '1234', 0, 1, 1, '2023-09-10', '2023-09-10'),
(3, 'Jose', '12345', 0, 1, 1, '2023-09-10', '2023-09-10'),
(4, 'mjorge', '1234', 0, 1, 1, '2023-09-10', '2023-09-10'),
(5, 'mvasquez', '12345', 0, 1, 2, '2023-09-10', '2023-09-10'),
(6, 'clopez', '12345', 0, 1, 2, '2023-09-10', '2023-09-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vacaciones`
--

CREATE TABLE `vacaciones` (
  `id_vacaciones` int(11) NOT NULL,
  `dias_adicionales` int(11) DEFAULT NULL,
  `dias_tomados` int(11) DEFAULT NULL,
  `dias_totales` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `anticipos`
--
ALTER TABLE `anticipos`
  ADD PRIMARY KEY (`id_anticipo`),
  ADD KEY `fk_anticip_usuario` (`id_usuario`);

--
-- Indices de la tabla `bauchers`
--
ALTER TABLE `bauchers`
  ADD PRIMARY KEY (`id_baucher`),
  ADD KEY `fk_bauchers_nomina` (`id_nomina`);

--
-- Indices de la tabla `cuotas_prestamos`
--
ALTER TABLE `cuotas_prestamos`
  ADD PRIMARY KEY (`id_cutota`),
  ADD KEY `fk_cuotas_prestamos` (`id_prestamo`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id_departamento`),
  ADD KEY `fk_departamento_usuario` (`id_usuario`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_empleado`),
  ADD KEY `fk_empleados_empresa` (`id_empresa`),
  ADD KEY `fk_empleados_usuarios` (`id_usuario`),
  ADD KEY `fk_empledados_departamento` (`id_departamento`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id_empresa`),
  ADD KEY `fk_empresa_usuario` (`id_usuario`);

--
-- Indices de la tabla `expedientes`
--
ALTER TABLE `expedientes`
  ADD PRIMARY KEY (`id_expediente`),
  ADD KEY `fk_expediente_empleado` (`id_empleado`);

--
-- Indices de la tabla `familiares`
--
ALTER TABLE `familiares`
  ADD PRIMARY KEY (`id_familia`),
  ADD KEY `fk_familiar_empleado` (`id_empleado`);

--
-- Indices de la tabla `historial_aumentos`
--
ALTER TABLE `historial_aumentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historial_empleados` (`id_empleado`);

--
-- Indices de la tabla `horas_extras`
--
ALTER TABLE `horas_extras`
  ADD PRIMARY KEY (`id_hora`),
  ADD KEY `fk_horasExtras_nomina` (`id_nomina`);

--
-- Indices de la tabla `marcaciones`
--
ALTER TABLE `marcaciones`
  ADD PRIMARY KEY (`id_marcacion`),
  ADD KEY `fk_marcaciones_empleado` (`id_empleado`);

--
-- Indices de la tabla `nominas`
--
ALTER TABLE `nominas`
  ADD PRIMARY KEY (`id_nomina`),
  ADD KEY `fk_nominas_empleado` (`id_empleado`);

--
-- Indices de la tabla `nomina_especial`
--
ALTER TABLE `nomina_especial`
  ADD PRIMARY KEY (`id_nomina_especial`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `fk_notificaciones_usuario` (`id_usuario_recibe`);

--
-- Indices de la tabla `planillas_especiales`
--
ALTER TABLE `planillas_especiales`
  ADD PRIMARY KEY (`id_planilla`),
  ADD KEY `fk_planillaEspecial_empleado` (`id_empleado`),
  ADD KEY `fk_planillasEspecial_nominaEspecial` (`id_nomina_especial`);

--
-- Indices de la tabla `polizas_contables`
--
ALTER TABLE `polizas_contables`
  ADD PRIMARY KEY (`id_poliza`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `fk_prestamos_usuarios` (`id_usuario_solicita`);

--
-- Indices de la tabla `retenciones`
--
ALTER TABLE `retenciones`
  ADD PRIMARY KEY (`id_retencion`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `solicitud_permisos`
--
ALTER TABLE `solicitud_permisos`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `fk_solicitud_usuario` (`id_usuario_solicita`);

--
-- Indices de la tabla `tienda_solidarista`
--
ALTER TABLE `tienda_solidarista`
  ADD PRIMARY KEY (`id_tienda`),
  ADD KEY `fk_tienda_empleado` (`id_empleado`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `fk_roles_usuario` (`id_rol`);

--
-- Indices de la tabla `vacaciones`
--
ALTER TABLE `vacaciones`
  ADD PRIMARY KEY (`id_vacaciones`),
  ADD KEY `fk_vacaciones_empleado` (`id_empleado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `anticipos`
--
ALTER TABLE `anticipos`
  MODIFY `id_anticipo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bauchers`
--
ALTER TABLE `bauchers`
  MODIFY `id_baucher` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuotas_prestamos`
--
ALTER TABLE `cuotas_prestamos`
  MODIFY `id_cutota` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id_departamento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `expedientes`
--
ALTER TABLE `expedientes`
  MODIFY `id_expediente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `familiares`
--
ALTER TABLE `familiares`
  MODIFY `id_familia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_aumentos`
--
ALTER TABLE `historial_aumentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `horas_extras`
--
ALTER TABLE `horas_extras`
  MODIFY `id_hora` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `marcaciones`
--
ALTER TABLE `marcaciones`
  MODIFY `id_marcacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `nominas`
--
ALTER TABLE `nominas`
  MODIFY `id_nomina` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `nomina_especial`
--
ALTER TABLE `nomina_especial`
  MODIFY `id_nomina_especial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planillas_especiales`
--
ALTER TABLE `planillas_especiales`
  MODIFY `id_planilla` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `polizas_contables`
--
ALTER TABLE `polizas_contables`
  MODIFY `id_poliza` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id_prestamo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `retenciones`
--
ALTER TABLE `retenciones`
  MODIFY `id_retencion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `solicitud_permisos`
--
ALTER TABLE `solicitud_permisos`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tienda_solidarista`
--
ALTER TABLE `tienda_solidarista`
  MODIFY `id_tienda` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `vacaciones`
--
ALTER TABLE `vacaciones`
  MODIFY `id_vacaciones` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `anticipos`
--
ALTER TABLE `anticipos`
  ADD CONSTRAINT `fk_anticip_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `bauchers`
--
ALTER TABLE `bauchers`
  ADD CONSTRAINT `fk_bauchers_nomina` FOREIGN KEY (`id_nomina`) REFERENCES `nominas` (`id_nomina`);

--
-- Filtros para la tabla `cuotas_prestamos`
--
ALTER TABLE `cuotas_prestamos`
  ADD CONSTRAINT `fk_cuotas_prestamos` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamos` (`id_prestamo`);

--
-- Filtros para la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD CONSTRAINT `fk_departamento_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `fk_empleados_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`),
  ADD CONSTRAINT `fk_empleados_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `fk_empledados_departamento` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`);

--
-- Filtros para la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD CONSTRAINT `fk_empresa_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `expedientes`
--
ALTER TABLE `expedientes`
  ADD CONSTRAINT `fk_expediente_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);

--
-- Filtros para la tabla `familiares`
--
ALTER TABLE `familiares`
  ADD CONSTRAINT `fk_familiar_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);

--
-- Filtros para la tabla `historial_aumentos`
--
ALTER TABLE `historial_aumentos`
  ADD CONSTRAINT `fk_historial_empleados` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);

--
-- Filtros para la tabla `horas_extras`
--
ALTER TABLE `horas_extras`
  ADD CONSTRAINT `fk_horasExtras_nomina` FOREIGN KEY (`id_nomina`) REFERENCES `nominas` (`id_nomina`);

--
-- Filtros para la tabla `marcaciones`
--
ALTER TABLE `marcaciones`
  ADD CONSTRAINT `fk_marcaciones_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);

--
-- Filtros para la tabla `nominas`
--
ALTER TABLE `nominas`
  ADD CONSTRAINT `fk_nominas_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `fk_notificaciones_usuario` FOREIGN KEY (`id_usuario_recibe`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `planillas_especiales`
--
ALTER TABLE `planillas_especiales`
  ADD CONSTRAINT `fk_planillaEspecial_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`),
  ADD CONSTRAINT `fk_planillasEspecial_nominaEspecial` FOREIGN KEY (`id_nomina_especial`) REFERENCES `nomina_especial` (`id_nomina_especial`);

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `fk_prestamos_usuarios` FOREIGN KEY (`id_usuario_solicita`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `solicitud_permisos`
--
ALTER TABLE `solicitud_permisos`
  ADD CONSTRAINT `fk_solicitud_usuario` FOREIGN KEY (`id_usuario_solicita`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `tienda_solidarista`
--
ALTER TABLE `tienda_solidarista`
  ADD CONSTRAINT `fk_tienda_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_roles_usuario` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);

--
-- Filtros para la tabla `vacaciones`
--
ALTER TABLE `vacaciones`
  ADD CONSTRAINT `fk_vacaciones_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

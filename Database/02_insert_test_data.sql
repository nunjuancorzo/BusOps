-- Script de inserción de datos de prueba para BusOps
-- Base de datos: busops
-- Creado: 16 de diciembre de 2025

USE busops;

-- =====================================================
-- Datos de prueba: ConfiguracionEmpresa
-- =====================================================
INSERT INTO ConfiguracionEmpresa (
    NombreEmpresa, NIF, Direccion, Ciudad, CodigoPostal, Provincia,
    Telefono, Email, Web, IBAN, SerieFactura, NumeroFacturaActual,
    LongitudNumeroFactura, IncluirAñoEnSerie, IVAPorDefecto, DiasVencimientoPorDefecto
) VALUES (
    'Transportes BusOps S.L.',
    'B12345678',
    'Calle Principal 123',
    'Madrid',
    '28001',
    'Madrid',
    '+34 911 234 567',
    'info@busops.es',
    'www.busops.es',
    'ES7921000813610123456789',
    'FAC',
    1,
    4,
    TRUE,
    21.00,
    30
);

-- =====================================================
-- Datos de prueba: Autobuses
-- =====================================================
INSERT INTO Autobuses (Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado, FechaUltimaRevision, ProximaRevision) VALUES
('1234ABC', 'Mercedes-Benz', 'Tourismo', 55, 2020, 125000.50, 'Disponible', '2025-10-15 10:00:00', '2026-04-15 10:00:00'),
('5678DEF', 'Volvo', '9700', 50, 2019, 180000.00, 'Disponible', '2025-11-20 09:00:00', '2026-05-20 09:00:00'),
('9012GHI', 'Scania', 'Touring HD', 60, 2021, 85000.75, 'EnServicio', '2025-12-01 08:30:00', '2026-06-01 08:30:00'),
('3456JKL', 'Iveco', 'Magelys Pro', 48, 2018, 220000.00, 'EnMantenimiento', '2025-09-10 11:00:00', '2026-03-10 11:00:00'),
('7890MNO', 'MAN', 'Lion\'s Coach', 52, 2022, 45000.25, 'Disponible', '2025-12-10 07:45:00', '2026-06-10 07:45:00');

-- =====================================================
-- Datos de prueba: Conductores
-- =====================================================
INSERT INTO Conductores (Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, Telefono, Email, FechaContratacion, Estado) VALUES
('Juan', 'García López', '12345678A', 'LIC-001-2020', '2027-06-30 23:59:59', '+34 600 111 222', 'juan.garcia@busops.es', '2020-03-15 09:00:00', 'Activo'),
('María', 'Rodríguez Sánchez', '23456789B', 'LIC-002-2019', '2026-08-15 23:59:59', '+34 600 222 333', 'maria.rodriguez@busops.es', '2019-07-01 09:00:00', 'Activo'),
('Carlos', 'Martínez Pérez', '34567890C', 'LIC-003-2021', '2028-02-28 23:59:59', '+34 600 333 444', 'carlos.martinez@busops.es', '2021-01-10 09:00:00', 'Activo'),
('Ana', 'López Fernández', '45678901D', 'LIC-004-2020', '2027-10-31 23:59:59', '+34 600 444 555', 'ana.lopez@busops.es', '2020-09-01 09:00:00', 'DeVacaciones'),
('Pedro', 'González Ruiz', '56789012E', 'LIC-005-2022', '2029-05-15 23:59:59', '+34 600 555 666', 'pedro.gonzalez@busops.es', '2022-04-01 09:00:00', 'Activo');

-- =====================================================
-- Datos de prueba: Rutas
-- =====================================================
INSERT INTO Rutas (Nombre, Origen, Destino, DistanciaKm, DuracionEstimada, PrecioBase, Activa) VALUES
('Madrid - Barcelona Express', 'Madrid', 'Barcelona', 620.5, '06:30:00', 45.00, TRUE),
('Valencia - Sevilla Directo', 'Valencia', 'Sevilla', 650.0, '07:00:00', 48.50, TRUE),
('Bilbao - Madrid Central', 'Bilbao', 'Madrid', 395.0, '04:30:00', 35.00, TRUE),
('Barcelona - Valencia Costa', 'Barcelona', 'Valencia', 350.0, '04:00:00', 30.00, TRUE),
('Málaga - Granada Turístico', 'Málaga', 'Granada', 125.0, '01:45:00', 18.00, TRUE),
('Zaragoza - Valencia Rápido', 'Zaragoza', 'Valencia', 325.0, '03:30:00', 28.00, FALSE);

-- =====================================================
-- Datos de prueba: Paradas
-- =====================================================
INSERT INTO Paradas (Nombre, Direccion, Ciudad, Latitud, Longitud, Orden, TiempoDesdeInicio, RutaId) VALUES
-- Ruta 1: Madrid - Barcelona
('Estación Sur Madrid', 'Calle Méndez Álvaro 83', 'Madrid', 40.3973, -3.6868, 1, '00:00:00', 1),
('Zaragoza Centro', 'Paseo María Agustín 7', 'Zaragoza', 41.6488, -0.8891, 2, '03:15:00', 1),
('Barcelona Sants', 'Plaza dels Països Catalans', 'Barcelona', 41.3794, 2.1402, 3, '06:30:00', 1),

-- Ruta 2: Valencia - Sevilla
('Estación Valencia', 'Avenida Menéndez Pidal 13', 'Valencia', 39.4668, -0.3774, 1, '00:00:00', 2),
('Albacete Terminal', 'Calle Arquitecto Vandelvira', 'Albacete', 38.9943, -1.8585, 2, '02:30:00', 2),
('Córdoba Plaza', 'Glorieta de las Tres Culturas', 'Córdoba', 37.8845, -4.7796, 3, '05:00:00', 2),
('Sevilla Plaza de Armas', 'Avenida Cristo de la Expiración', 'Sevilla', 37.3890, -5.9967, 4, '07:00:00', 2),

-- Ruta 3: Bilbao - Madrid
('Bilbao Termibus', 'Gurtubay Kalea 1', 'Bilbao', 43.2574, -2.9247, 1, '00:00:00', 3),
('Burgos Estación', 'Calle Miranda 4', 'Burgos', 42.3440, -3.6969, 2, '02:00:00', 3),
('Madrid Intercambiador', 'Calle Méndez Álvaro 83', 'Madrid', 40.3973, -3.6868, 3, '04:30:00', 3);

-- =====================================================
-- Datos de prueba: Viajes
-- =====================================================
INSERT INTO Viajes (FechaHoraSalida, FechaHoraLlegadaEstimada, FechaHoraLlegadaReal, Estado, AsientosDisponibles, PrecioViaje, AutobusId, ConductorId, RutaId) VALUES
-- Viajes programados
('2025-12-20 08:00:00', '2025-12-20 14:30:00', NULL, 'Programado', 45, 45.00, 1, 1, 1),
('2025-12-21 09:00:00', '2025-12-21 16:00:00', NULL, 'Programado', 50, 48.50, 2, 2, 2),
('2025-12-22 07:30:00', '2025-12-22 12:00:00', NULL, 'Programado', 40, 35.00, 5, 3, 3),

-- Viajes en curso
('2025-12-16 10:00:00', '2025-12-16 14:00:00', NULL, 'EnCurso', 20, 30.00, 3, 5, 4),

-- Viajes completados
('2025-12-15 08:00:00', '2025-12-15 09:45:00', '2025-12-15 09:50:00', 'Completado', 0, 18.00, 1, 1, 5),
('2025-12-14 15:00:00', '2025-12-14 21:30:00', '2025-12-14 21:35:00', 'Completado', 0, 45.00, 2, 2, 1),

-- Viajes cancelados
('2025-12-17 06:00:00', '2025-12-17 09:30:00', NULL, 'Cancelado', 48, 28.00, 4, 4, 6);

-- =====================================================
-- Datos de prueba: Pasajeros
-- =====================================================
INSERT INTO Pasajeros (Nombre, Apellidos, DNI, Telefono, Email, FechaNacimiento) VALUES
('Laura', 'Jiménez Moreno', '11111111A', '+34 611 111 111', 'laura.jimenez@email.com', '1985-03-15'),
('Miguel', 'Sánchez Torres', '22222222B', '+34 622 222 222', 'miguel.sanchez@email.com', '1990-07-22'),
('Carmen', 'Ruiz Navarro', '33333333C', '+34 633 333 333', 'carmen.ruiz@email.com', '1978-11-30'),
('David', 'Moreno Castro', '44444444D', '+34 644 444 444', 'david.moreno@email.com', '1995-01-08'),
('Isabel', 'Hernández Gil', '55555555E', '+34 655 555 555', 'isabel.hernandez@email.com', '1988-09-17'),
('Roberto', 'Díaz Ortiz', '66666666F', '+34 666 666 666', 'roberto.diaz@email.com', '1992-05-25'),
('Elena', 'Serrano Vega', '77777777G', '+34 677 777 777', 'elena.serrano@email.com', '1980-12-03'),
('Francisco', 'Vázquez Romero', '88888888H', '+34 688 888 888', 'francisco.vazquez@email.com', '1975-08-14'),
('Cristina', 'Ramos Iglesias', '99999999I', '+34 699 999 999', 'cristina.ramos@email.com', '1993-04-20'),
('Alberto', 'Castro Molina', '10101010J', '+34 610 101 010', 'alberto.castro@email.com', '1987-06-11');

-- =====================================================
-- Datos de prueba: Reservas
-- =====================================================
INSERT INTO Reservas (CodigoReserva, FechaReserva, NumeroAsiento, PrecioPagado, Estado, TipoPago, ViajeId, PasajeroId) VALUES
-- Reservas para viaje 1 (Madrid-Barcelona, 20 dic)
('RES-2025-001', '2025-12-10 10:30:00', 1, 45.00, 'Pagada', 'TarjetaCredito', 1, 1),
('RES-2025-002', '2025-12-10 11:15:00', 2, 45.00, 'Pagada', 'TarjetaDebito', 1, 2),
('RES-2025-003', '2025-12-11 09:00:00', 3, 45.00, 'Confirmada', 'Transferencia', 1, 3),
('RES-2025-004', '2025-12-12 14:20:00', 4, 45.00, 'Pagada', 'PayPal', 1, 4),
('RES-2025-005', '2025-12-13 16:45:00', 5, 45.00, 'Pagada', 'TarjetaCredito', 1, 5),

-- Reservas para viaje 2 (Valencia-Sevilla, 21 dic)
('RES-2025-006', '2025-12-11 08:00:00', 1, 48.50, 'Pagada', 'TarjetaCredito', 2, 6),
('RES-2025-007', '2025-12-11 10:30:00', 2, 48.50, 'Pagada', 'Efectivo', 2, 7),

-- Reservas para viaje 3 (Bilbao-Madrid, 22 dic)
('RES-2025-008', '2025-12-12 12:00:00', 1, 35.00, 'Confirmada', 'TarjetaDebito', 3, 8),
('RES-2025-009', '2025-12-13 15:30:00', 2, 35.00, 'Pagada', 'TarjetaCredito', 3, 9),
('RES-2025-010', '2025-12-14 09:45:00', 3, 35.00, 'Pagada', 'PayPal', 3, 10),

-- Reservas para viaje 4 (Barcelona-Valencia, en curso)
('RES-2025-011', '2025-12-14 11:00:00', 1, 30.00, 'Utilizada', 'TarjetaCredito', 4, 1),
('RES-2025-012', '2025-12-14 12:30:00', 2, 30.00, 'Utilizada', 'Efectivo', 4, 2),

-- Reservas para viaje 5 (Málaga-Granada, completado)
('RES-2025-013', '2025-12-13 10:00:00', 1, 18.00, 'Utilizada', 'TarjetaDebito', 5, 3),
('RES-2025-014', '2025-12-13 11:00:00', 2, 18.00, 'Utilizada', 'TarjetaCredito', 5, 4),

-- Reserva cancelada
('RES-2025-015', '2025-12-10 13:00:00', 1, 28.00, 'Cancelada', 'Transferencia', 7, 5);

-- =====================================================
-- Datos de prueba: MantenimientosAutobus
-- =====================================================
INSERT INTO MantenimientosAutobus (FechaInicio, FechaFin, Tipo, Descripcion, Costo, Taller, KilometrajeMantenimiento, Estado, AutobusId) VALUES
-- Mantenimientos completados
('2025-10-15 09:00:00', '2025-10-15 16:00:00', 'RevisionTecnica', 'Revisión técnica obligatoria anual', 450.00, 'Taller Central S.L.', 125000, 'Completado', 1),
('2025-11-20 08:00:00', '2025-11-20 14:00:00', 'CambioAceite', 'Cambio de aceite y filtros', 280.00, 'Taller Express', 180000, 'Completado', 2),
('2025-12-01 10:00:00', '2025-12-01 17:00:00', 'Preventivo', 'Mantenimiento preventivo trimestral', 520.00, 'Talleres García', 85000, 'Completado', 3),

-- Mantenimiento en proceso
('2025-12-15 08:00:00', NULL, 'Correctivo', 'Reparación de sistema de frenos', 1200.00, 'Taller Especializado Auto', 220000, 'EnProceso', 4),

-- Mantenimientos programados
('2025-12-20 09:00:00', NULL, 'CambioNeumaticos', 'Cambio de neumáticos delanteros', 680.00, 'Neumáticos del Sur', 45000, 'Programado', 5),
('2025-12-25 10:00:00', NULL, 'Preventivo', 'Revisión general de fin de año', 550.00, 'Taller Central S.L.', 125500, 'Programado', 1);

-- =====================================================
-- Datos de prueba: Gastos
-- =====================================================
INSERT INTO Gastos (Fecha, Tipo, Monto, Descripcion, Proveedor, NumeroFactura, AutobusId) VALUES
-- Gastos de combustible
('2025-12-01 10:30:00', 'Combustible', 450.00, 'Repostaje completo diesel', 'Estación Repsol Madrid', 'FACT-2025-001', 1),
('2025-12-02 09:15:00', 'Combustible', 480.00, 'Repostaje completo diesel', 'BP Barcelona', 'FACT-2025-002', 2),
('2025-12-03 14:45:00', 'Combustible', 420.00, 'Repostaje completo diesel', 'Cepsa Valencia', 'FACT-2025-003', 3),

-- Gastos de mantenimiento
('2025-10-15 16:30:00', 'Mantenimiento', 450.00, 'Revisión técnica obligatoria', 'Taller Central S.L.', 'FACT-2025-004', 1),
('2025-11-20 14:15:00', 'Mantenimiento', 280.00, 'Cambio de aceite y filtros', 'Taller Express', 'FACT-2025-005', 2),
('2025-12-15 12:00:00', 'Mantenimiento', 1200.00, 'Reparación sistema de frenos', 'Taller Especializado Auto', 'FACT-2025-006', 4),

-- Gastos de seguros
('2025-01-15 09:00:00', 'Seguros', 2500.00, 'Seguro anual completo', 'Mapfre Seguros', 'POL-2025-001', 1),
('2025-01-15 09:00:00', 'Seguros', 2500.00, 'Seguro anual completo', 'Mapfre Seguros', 'POL-2025-002', 2),
('2025-01-15 09:00:00', 'Seguros', 2500.00, 'Seguro anual completo', 'Mapfre Seguros', 'POL-2025-003', 3),

-- Otros gastos
('2025-12-05 11:00:00', 'Limpieza', 150.00, 'Limpieza profunda interior', 'Limpiezas Profesionales', 'FACT-2025-007', 1),
('2025-12-07 15:30:00', 'Peajes', 85.50, 'Peajes autopista A-2', 'Autopistas España', 'TICKET-2025-001', 2),
('2025-12-10 08:45:00', 'Licencias', 450.00, 'Renovación licencia transporte', 'Ministerio Transportes', 'LIC-2025-001', NULL),
('2025-11-30 10:00:00', 'Salarios', 15000.00, 'Nóminas conductores noviembre', 'BusOps RRHH', 'NOM-2025-11', NULL);

-- =====================================================
-- Datos de prueba: Clientes
-- =====================================================
INSERT INTO Clientes (Nombre, Apellidos, NombreEmpresa, Tipo, NIF, Direccion, Ciudad, CodigoPostal, Telefono, Email, FechaRegistro, Activo) VALUES
-- Clientes particulares
('Javier', 'Fernández López', NULL, 'Particular', '11223344A', 'Calle Mayor 45', 'Madrid', '28013', '+34 611 223 344', 'javier.fernandez@email.com', '2024-03-15 10:00:00', TRUE),
('Sofía', 'García Martín', NULL, 'Particular', '22334455B', 'Avenida Diagonal 234', 'Barcelona', '08013', '+34 622 334 455', 'sofia.garcia@email.com', '2024-06-20 11:30:00', TRUE),

-- Clientes empresa
(NULL, NULL, 'Viajes Globales S.A.', 'Empresa', 'A12345678', 'Polígono Industrial 12', 'Valencia', '46000', '+34 963 123 456', 'info@viajesglobales.com', '2023-01-10 09:00:00', TRUE),
(NULL, NULL, 'Turismo Andaluz S.L.', 'Empresa', 'B23456789', 'Plaza Nueva 8', 'Sevilla', '41001', '+34 954 234 567', 'contacto@turismoandaluz.es', '2023-05-15 14:00:00', TRUE),

-- Clientes agencia
(NULL, NULL, 'Agencia Viajes Estrella', 'Agencia', 'C34567890', 'Gran Vía 78', 'Madrid', '28013', '+34 915 345 678', 'reservas@agenciaestrella.com', '2022-09-01 10:30:00', TRUE),
(NULL, NULL, 'Costa Tours', 'Agencia', 'D45678901', 'Paseo Marítimo 23', 'Málaga', '29001', '+34 952 456 789', 'info@costatours.es', '2023-03-20 15:45:00', TRUE);

-- =====================================================
-- Datos de prueba: Facturas
-- =====================================================
INSERT INTO Facturas (NumeroFactura, FechaEmision, FechaVencimiento, ClienteId, BaseImponible, PorcentajeIVA, ImporteIVA, Total, Estado, Concepto, FormaPago, FechaPago) VALUES
-- Facturas pagadas
('FAC-2025-0001', '2025-11-01 10:00:00', '2025-12-01 23:59:59', 9, 1500.00, 21.00, 315.00, 1815.00, 'Pagada', 'Servicio de transporte grupo empresarial', 'Transferencia', '2025-11-15 09:30:00'),
('FAC-2025-0002', '2025-11-15 11:30:00', '2025-12-15 23:59:59', 11, 2400.00, 21.00, 504.00, 2904.00, 'Pagada', 'Excursión turística Madrid-Barcelona', 'TarjetaCredito', '2025-11-20 14:00:00'),

-- Facturas emitidas pendientes de pago
('FAC-2025-0003', '2025-12-01 09:00:00', '2025-12-31 23:59:59', 10, 3200.00, 21.00, 672.00, 3872.00, 'Emitida', 'Servicios de transporte turístico noviembre', NULL, NULL),
('FAC-2025-0004', '2025-12-10 14:00:00', '2026-01-09 23:59:59', 12, 1800.00, 21.00, 378.00, 2178.00, 'Emitida', 'Transporte grupos turísticos costa', NULL, NULL),

-- Factura borrador
('FAC-2025-0005', '2025-12-15 16:00:00', '2026-01-14 23:59:59', 9, 2100.00, 21.00, 441.00, 2541.00, 'Borrador', 'Servicios transporte diciembre', NULL, NULL);

-- =====================================================
-- Datos de prueba: LineasFactura
-- =====================================================
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, ViajeId) VALUES
-- Líneas factura 11
(11, 'Transporte Madrid-Barcelona grupo 30 personas', 30, 45.00, 1350.00, 1),
(11, 'Servicio adicional coordinación', 1, 150.00, 150.00, NULL),

-- Líneas factura 12
(12, 'Excursión Barcelona-Valencia 40 personas', 40, 30.00, 1200.00, 4),
(12, 'Excursión Málaga-Granada 40 personas', 40, 30.00, 1200.00, 5),

-- Líneas factura 13
(13, 'Transporte Valencia-Sevilla 50 personas', 50, 48.50, 2425.00, 2),
(13, 'Servicios guía turístico', 2, 387.50, 775.00, NULL),

-- Líneas factura 14
(14, 'Transporte Bilbao-Madrid 40 personas', 40, 35.00, 1400.00, 3),
(14, 'Servicio refrigerio', 40, 10.00, 400.00, NULL),

-- Líneas factura 15
(15, 'Transporte Madrid-Barcelona', 40, 45.00, 1800.00, NULL),
(15, 'Seguro viaje incluido', 40, 7.50, 300.00, NULL);

-- =====================================================
-- Finalización del script de datos de prueba
-- =====================================================

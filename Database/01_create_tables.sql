-- Script de creación de base de datos y tablas para BusOps
-- Base de datos: busops
-- Creado: 16 de diciembre de 2025

-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS busops
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE busops;

-- =====================================================
-- Tabla: ConfiguracionEmpresa
-- =====================================================
CREATE TABLE IF NOT EXISTS ConfiguracionEmpresa (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    NombreEmpresa VARCHAR(255) NOT NULL,
    NIF VARCHAR(20) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    CodigoPostal VARCHAR(10) NOT NULL,
    Provincia VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Web VARCHAR(255),
    IBAN VARCHAR(34),
    LogoRuta VARCHAR(500),
    SerieFactura VARCHAR(10) NOT NULL DEFAULT 'FAC',
    NumeroFacturaActual INT NOT NULL DEFAULT 1,
    LongitudNumeroFactura INT NOT NULL DEFAULT 4,
    IncluirAñoEnSerie BOOLEAN NOT NULL DEFAULT TRUE,
    IVAPorDefecto DECIMAL(5,2) NOT NULL DEFAULT 21.00,
    DiasVencimientoPorDefecto INT NOT NULL DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Autobuses
-- =====================================================
CREATE TABLE IF NOT EXISTS Autobuses (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Matricula VARCHAR(20) NOT NULL UNIQUE,
    Marca VARCHAR(100) NOT NULL,
    Modelo VARCHAR(100) NOT NULL,
    CapacidadPasajeros INT NOT NULL,
    AñoFabricacion INT NOT NULL,
    Kilometraje DOUBLE NOT NULL DEFAULT 0,
    Estado ENUM('Disponible', 'EnServicio', 'EnMantenimiento', 'FueraDeServicio') NOT NULL DEFAULT 'Disponible',
    FechaUltimaRevision DATETIME,
    ProximaRevision DATETIME,
    INDEX idx_matricula (Matricula),
    INDEX idx_estado (Estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Conductores
-- =====================================================
CREATE TABLE IF NOT EXISTS Conductores (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    NumeroLicencia VARCHAR(50) NOT NULL UNIQUE,
    FechaVencimientoLicencia DATETIME NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    FechaContratacion DATETIME NOT NULL,
    Estado ENUM('Activo', 'DeVacaciones', 'DeBaja', 'Inactivo') NOT NULL DEFAULT 'Activo',
    INDEX idx_dni (DNI),
    INDEX idx_estado (Estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Rutas
-- =====================================================
CREATE TABLE IF NOT EXISTS Rutas (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Origen VARCHAR(255) NOT NULL,
    Destino VARCHAR(255) NOT NULL,
    DistanciaKm DOUBLE NOT NULL,
    DuracionEstimada TIME NOT NULL,
    PrecioBase DECIMAL(10,2) NOT NULL,
    Activa BOOLEAN NOT NULL DEFAULT TRUE,
    INDEX idx_origen_destino (Origen, Destino),
    INDEX idx_activa (Activa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Paradas
-- =====================================================
CREATE TABLE IF NOT EXISTS Paradas (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    Latitud DOUBLE NOT NULL,
    Longitud DOUBLE NOT NULL,
    Orden INT NOT NULL,
    TiempoDesdeInicio TIME NOT NULL,
    RutaId INT NOT NULL,
    FOREIGN KEY (RutaId) REFERENCES Rutas(Id) ON DELETE CASCADE,
    INDEX idx_ruta (RutaId),
    INDEX idx_orden (RutaId, Orden)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Viajes
-- =====================================================
CREATE TABLE IF NOT EXISTS Viajes (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FechaHoraSalida DATETIME NOT NULL,
    FechaHoraLlegadaEstimada DATETIME NOT NULL,
    FechaHoraLlegadaReal DATETIME,
    Estado ENUM('Programado', 'EnCurso', 'Completado', 'Cancelado', 'Retrasado') NOT NULL DEFAULT 'Programado',
    AsientosDisponibles INT NOT NULL,
    PrecioViaje DECIMAL(10,2) NOT NULL,
    AutobusId INT NOT NULL,
    ConductorId INT NOT NULL,
    RutaId INT NOT NULL,
    FOREIGN KEY (AutobusId) REFERENCES Autobuses(Id) ON DELETE RESTRICT,
    FOREIGN KEY (ConductorId) REFERENCES Conductores(Id) ON DELETE RESTRICT,
    FOREIGN KEY (RutaId) REFERENCES Rutas(Id) ON DELETE RESTRICT,
    INDEX idx_fecha_salida (FechaHoraSalida),
    INDEX idx_estado (Estado),
    INDEX idx_autobus (AutobusId),
    INDEX idx_conductor (ConductorId),
    INDEX idx_ruta (RutaId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Pasajeros
-- =====================================================
CREATE TABLE IF NOT EXISTS Pasajeros (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    INDEX idx_dni (DNI),
    INDEX idx_email (Email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Reservas
-- =====================================================
CREATE TABLE IF NOT EXISTS Reservas (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    CodigoReserva VARCHAR(50) NOT NULL UNIQUE,
    FechaReserva DATETIME NOT NULL,
    NumeroAsiento INT NOT NULL,
    PrecioPagado DECIMAL(10,2) NOT NULL,
    Estado ENUM('Pendiente', 'Confirmada', 'Pagada', 'Cancelada', 'Utilizada') NOT NULL DEFAULT 'Pendiente',
    TipoPago ENUM('Efectivo', 'TarjetaCredito', 'TarjetaDebito', 'Transferencia', 'PayPal') NOT NULL,
    ViajeId INT NOT NULL,
    PasajeroId INT NOT NULL,
    FOREIGN KEY (ViajeId) REFERENCES Viajes(Id) ON DELETE CASCADE,
    FOREIGN KEY (PasajeroId) REFERENCES Pasajeros(Id) ON DELETE RESTRICT,
    INDEX idx_codigo (CodigoReserva),
    INDEX idx_viaje (ViajeId),
    INDEX idx_pasajero (PasajeroId),
    INDEX idx_estado (Estado),
    UNIQUE INDEX idx_viaje_asiento (ViajeId, NumeroAsiento)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: MantenimientosAutobus
-- =====================================================
CREATE TABLE IF NOT EXISTS MantenimientosAutobus (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FechaInicio DATETIME NOT NULL,
    FechaFin DATETIME,
    Tipo ENUM('Preventivo', 'Correctivo', 'RevisionTecnica', 'CambioAceite', 'CambioNeumaticos', 'Reparacion') NOT NULL,
    Descripcion TEXT NOT NULL,
    Costo DECIMAL(10,2) NOT NULL,
    Taller VARCHAR(255) NOT NULL,
    KilometrajeMantenimiento INT NOT NULL,
    Estado ENUM('Programado', 'EnProceso', 'Completado', 'Cancelado') NOT NULL DEFAULT 'Programado',
    AutobusId INT NOT NULL,
    FOREIGN KEY (AutobusId) REFERENCES Autobuses(Id) ON DELETE CASCADE,
    INDEX idx_autobus (AutobusId),
    INDEX idx_fecha_inicio (FechaInicio),
    INDEX idx_estado (Estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Gastos
-- =====================================================
CREATE TABLE IF NOT EXISTS Gastos (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATETIME NOT NULL,
    Tipo ENUM('Combustible', 'Mantenimiento', 'Seguros', 'Salarios', 'Licencias', 'Limpieza', 'Peajes', 'Multas', 'Otros') NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    Descripcion TEXT NOT NULL,
    Proveedor VARCHAR(255) NOT NULL,
    NumeroFactura VARCHAR(100) NOT NULL,
    AutobusId INT,
    FOREIGN KEY (AutobusId) REFERENCES Autobuses(Id) ON DELETE SET NULL,
    INDEX idx_fecha (Fecha),
    INDEX idx_tipo (Tipo),
    INDEX idx_autobus (AutobusId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Clientes
-- =====================================================
CREATE TABLE IF NOT EXISTS Clientes (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellidos VARCHAR(100),
    NombreEmpresa VARCHAR(255),
    Tipo ENUM('Particular', 'Empresa', 'Agencia') NOT NULL,
    NIF VARCHAR(20) NOT NULL UNIQUE,
    Direccion VARCHAR(255),
    Ciudad VARCHAR(100),
    CodigoPostal VARCHAR(10),
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    FechaRegistro DATETIME NOT NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    INDEX idx_nif (NIF),
    INDEX idx_tipo (Tipo),
    INDEX idx_activo (Activo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: Facturas
-- =====================================================
CREATE TABLE IF NOT EXISTS Facturas (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    NumeroFactura VARCHAR(50) NOT NULL UNIQUE,
    FechaEmision DATETIME NOT NULL,
    FechaVencimiento DATETIME,
    ClienteId INT NOT NULL,
    BaseImponible DECIMAL(10,2) NOT NULL,
    PorcentajeIVA DECIMAL(5,2) NOT NULL DEFAULT 21.00,
    ImporteIVA DECIMAL(10,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Estado ENUM('Borrador', 'Emitida', 'Enviada', 'Pagada', 'Vencida', 'Cancelada') NOT NULL DEFAULT 'Borrador',
    Concepto TEXT,
    Observaciones TEXT,
    FechaPago DATETIME,
    FormaPago ENUM('Efectivo', 'TarjetaCredito', 'TarjetaDebito', 'Transferencia', 'PayPal'),
    FOREIGN KEY (ClienteId) REFERENCES Clientes(Id) ON DELETE RESTRICT,
    INDEX idx_numero (NumeroFactura),
    INDEX idx_cliente (ClienteId),
    INDEX idx_fecha_emision (FechaEmision),
    INDEX idx_estado (Estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: LineasFactura
-- =====================================================
CREATE TABLE IF NOT EXISTS LineasFactura (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FacturaId INT NOT NULL,
    Descripcion VARCHAR(500) NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    ViajeId INT,
    FOREIGN KEY (FacturaId) REFERENCES Facturas(Id) ON DELETE CASCADE,
    FOREIGN KEY (ViajeId) REFERENCES Viajes(Id) ON DELETE SET NULL,
    INDEX idx_factura (FacturaId),
    INDEX idx_viaje (ViajeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Finalización del script
-- =====================================================

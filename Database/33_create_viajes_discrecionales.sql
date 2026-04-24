-- =====================================================
-- Script de migración para separar Viajes en dos tipos:
-- - Viajes (mantener para viajes fijos basados en rutas)
-- - ViajesDiscrecionales (nuevos servicios discrecionales)
-- =====================================================

-- =====================================================
-- Tabla: ViajesDiscrecionales
-- =====================================================
CREATE TABLE IF NOT EXISTS ViajesDiscrecionales (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Identificación
    Codigo VARCHAR(50) NOT NULL,
    Referencia VARCHAR(200),
    Expediente VARCHAR(200),
    DescripcionExpediente VARCHAR(500),
    
    -- Fechas y horarios
    FechaSalida DATE,
    HoraPresentacion TIME,
    HoraSalida TIME,
    FechaLlegada DATE,
    HoraLlegada TIME,
    
    -- Horarios de cierre
    HoraPresentacionCierre TIME,
    HoraSalidaCierre TIME,
    HoraLlegadaCierre TIME,
    
    -- Cliente
    CodigoCliente VARCHAR(50),
    NombreCliente VARCHAR(255),
    ClienteId INT,
    
    -- Descripción del servicio
    Descripcion VARCHAR(500),
    Ampliacion VARCHAR(500),
    Plazas INT,
    
    -- Lugares y coordenadas
    LugarSalida VARCHAR(255),
    PoblacionSalida VARCHAR(255),
    CoordXSalida DOUBLE,
    CoordYSalida DOUBLE,
    
    LugarLlegada VARCHAR(255),
    PoblacionLlegada VARCHAR(255),
    CoordXLlegada DOUBLE,
    CoordYLlegada DOUBLE,
    
    Itinerario VARCHAR(1000),
    
    -- Vehículo y conductores
    Vehiculo VARCHAR(255),
    Matricula VARCHAR(20),
    AutobusId INT,
    
    Conductor VARCHAR(255),
    ConductorId INT,
    
    Conductor2 VARCHAR(255),
    Conductor2Id INT,
    
    -- Importes
    TotalImporte DECIMAL(10,2),
    Importe DECIMAL(10,2),
    TotalProveedor DECIMAL(10,2),
    NumeroFactura VARCHAR(50),
    
    -- Kilometraje
    KmsInicio INT,
    KmsFin INT,
    KmsTotales INT,
    
    -- Clasificación
    GrupoClientes VARCHAR(255),
    INE VARCHAR(100),
    INE2 VARCHAR(255),
    
    -- Vehículo
    TipoVehiculoSolicitado VARCHAR(255),
    TipoVehiculoAsignado VARCHAR(255),
    
    -- Gestión
    Responsable VARCHAR(255),
    VueloTren VARCHAR(255),
    NombreGrupo VARCHAR(255),
    
    -- Tipo de servicio
    CodigoTipoServicio VARCHAR(50),
    ServicioTipo VARCHAR(255),
    
    -- Presupuesto
    CodigoPresupuesto VARCHAR(50),
    
    -- Notas
    NotasInternas VARCHAR(1000),
    Notas VARCHAR(1000),
    
    -- Comisionista
    Comisionista VARCHAR(255),
    ImporteComisionista DECIMAL(10,2),
    
    -- Estado
    Anulado BOOLEAN DEFAULT FALSE,
    Estado VARCHAR(50) DEFAULT 'Programado',
    
    -- Multi-tenant
    EmpresaId INT NOT NULL,
    
    -- Índices
    INDEX idx_codigo (Codigo),
    INDEX idx_cliente (ClienteId),
    INDEX idx_autobus (AutobusId),
    INDEX idx_conductor (ConductorId),
    INDEX idx_conductor2 (Conductor2Id),
    INDEX idx_empresa (EmpresaId),
    INDEX idx_fecha_salida (FechaSalida),
    
    -- Foreign Keys
    FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id) ON DELETE CASCADE,
    FOREIGN KEY (ClienteId) REFERENCES Clientes(Id) ON DELETE SET NULL,
    FOREIGN KEY (AutobusId) REFERENCES Autobuses(Id) ON DELETE SET NULL,
    FOREIGN KEY (ConductorId) REFERENCES Conductores(Id) ON DELETE SET NULL,
    FOREIGN KEY (Conductor2Id) REFERENCES Conductores(Id) ON DELETE SET NULL
);

-- =====================================================
-- Actualizar LineasFactura para soportar ambos tipos de viajes
-- =====================================================
DROP PROCEDURE IF EXISTS UpdateLineasFactura;

DELIMITER //
CREATE PROCEDURE UpdateLineasFactura()
BEGIN
    -- Agregar ViajeIdFijo (renombrar ViajeId)
    IF EXISTS (SELECT * FROM information_schema.COLUMNS 
               WHERE TABLE_SCHEMA = DATABASE() 
               AND TABLE_NAME = 'LineasFactura' 
               AND COLUMN_NAME = 'ViajeId') THEN
        ALTER TABLE LineasFactura CHANGE COLUMN ViajeId ViajeIdFijo INT;
    END IF;
    
    -- Agregar ViajeIdDiscrecional
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'LineasFactura' 
                   AND COLUMN_NAME = 'ViajeIdDiscrecional') THEN
        ALTER TABLE LineasFactura ADD COLUMN ViajeIdDiscrecional INT;
        ALTER TABLE LineasFactura ADD FOREIGN KEY (ViajeIdDiscrecional) 
            REFERENCES ViajesDiscrecionales(Id) ON DELETE SET NULL;
    END IF;
END//
DELIMITER ;

CALL UpdateLineasFactura();
DROP PROCEDURE UpdateLineasFactura;

-- =====================================================
-- Actualizar LineasPresupuesto para soportar ambos tipos de viajes
-- =====================================================
DROP PROCEDURE IF EXISTS UpdateLineasPresupuesto;

DELIMITER //
CREATE PROCEDURE UpdateLineasPresupuesto()
BEGIN
    -- Agregar ViajeIdFijo (renombrar ViajeId)
    IF EXISTS (SELECT * FROM information_schema.COLUMNS 
               WHERE TABLE_SCHEMA = DATABASE() 
               AND TABLE_NAME = 'LineasPresupuesto' 
               AND COLUMN_NAME = 'ViajeId') THEN
        ALTER TABLE LineasPresupuesto CHANGE COLUMN ViajeId ViajeIdFijo INT;
    END IF;
    
    -- Agregar ViajeIdDiscrecional
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'LineasPresupuesto' 
                   AND COLUMN_NAME = 'ViajeIdDiscrecional') THEN
        ALTER TABLE LineasPresupuesto ADD COLUMN ViajeIdDiscrecional INT;
        ALTER TABLE LineasPresupuesto ADD FOREIGN KEY (ViajeIdDiscrecional) 
            REFERENCES ViajesDiscrecionales(Id) ON DELETE SET NULL;
    END IF;
END//
DELIMITER ;

CALL UpdateLineasPresupuesto();
DROP PROCEDURE UpdateLineasPresupuesto;

-- =====================================================
-- Mensaje de confirmación
-- =====================================================
SELECT 'Migración completada: Se creó tabla ViajesDiscrecionales y se actualizaron LineasFactura y LineasPresupuesto' AS Resultado;

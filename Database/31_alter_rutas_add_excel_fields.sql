-- =====================================================
-- Script: 31_alter_rutas_add_excel_fields.sql
-- Descripción: Adapta la tabla rutas para incluir todos los campos del Excel Rutas.xlsx
-- Fecha: 2026-04-17
-- =====================================================

USE busops;

-- Verificar que la tabla rutas existe
-- Si no existe, crearla con todos los campos

CREATE TABLE IF NOT EXISTS rutas (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Codigo VARCHAR(50) DEFAULT '',
    Nombre VARCHAR(200) DEFAULT '',
    Descripcion VARCHAR(500) DEFAULT '',
    Origen VARCHAR(200) DEFAULT '',
    Destino VARCHAR(200) DEFAULT '',
    Referencia VARCHAR(100) NULL,
    
    -- Vigencia
    FechaInicio DATE NULL,
    FechaFin DATE NULL,
    
    -- Horarios
    HoraPresentacion TIME NULL,
    HoraSalida TIME NULL,
    HoraLlegada TIME NULL,
    DuracionEstimada TIME DEFAULT '00:00:00',
    
    -- Capacidad y distancia
    Plazas INT NULL,
    DistanciaKm DOUBLE DEFAULT 0,
    Kilometros INT NULL,
    
    -- Días de operación
    Lunes BOOLEAN DEFAULT FALSE,
    Martes BOOLEAN DEFAULT FALSE,
    Miercoles BOOLEAN DEFAULT FALSE,
    Jueves BOOLEAN DEFAULT FALSE,
    Viernes BOOLEAN DEFAULT FALSE,
    Sabado BOOLEAN DEFAULT FALSE,
    Domingo BOOLEAN DEFAULT FALSE,
    
    -- Línea regular y agregación
    CodigoLineaRegular VARCHAR(50) NULL,
    LineaRegular VARCHAR(200) NULL,
    CodigoAgregacion VARCHAR(50) NULL,
    Agregacion VARCHAR(200) NULL,
    
    -- Tipo de servicio
    CodigoTipoServicio VARCHAR(10) NULL,
    TipoServicio VARCHAR(100) NULL,
    
    -- Asistente
    Asistente VARCHAR(200) NULL,
    
    -- Otros
    PrecioBase DECIMAL(10,2) DEFAULT 0,
    Activa BOOLEAN DEFAULT TRUE,
    
    -- Multi-tenant
    EmpresaId INT NOT NULL,
    
    -- Relaciones con Cliente
    CodigoCliente INT NULL,
    ClienteId INT NULL,
    
    -- Relaciones con Vehículo
    VehiculoMatricula VARCHAR(20) NULL,
    AutobusId INT NULL,
    
    -- Relaciones con Conductor
    ConductorNombre VARCHAR(200) NULL,
    ConductorId INT NULL,
    
    -- Índices
    INDEX idx_rutas_empresa (EmpresaId),
    INDEX idx_rutas_cliente (ClienteId),
    INDEX idx_rutas_autobus (AutobusId),
    INDEX idx_rutas_conductor (ConductorId),
    INDEX idx_rutas_codigo (Codigo),
    INDEX idx_rutas_activa (Activa),
    
    -- Claves foráneas
    FOREIGN KEY (EmpresaId) REFERENCES empresas(Id) ON DELETE CASCADE,
    FOREIGN KEY (ClienteId) REFERENCES clientes(Id) ON DELETE SET NULL,
    FOREIGN KEY (AutobusId) REFERENCES autobuses(Id) ON DELETE SET NULL,
    FOREIGN KEY (ConductorId) REFERENCES conductores(Id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Si la tabla ya existe, agregar las columnas que faltan
-- NOTA: Algunas de estas columnas pueden ya existir, por lo que usamos procedimientos

DELIMITER //

DROP PROCEDURE IF EXISTS AddRutasColumns//

CREATE PROCEDURE AddRutasColumns()
BEGIN
    -- Código
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Codigo') THEN
        ALTER TABLE rutas ADD COLUMN Codigo VARCHAR(50) DEFAULT '' AFTER Id;
    END IF;
    
    -- Origen
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Origen') THEN
        ALTER TABLE rutas ADD COLUMN Origen VARCHAR(200) DEFAULT '' AFTER Nombre;
    END IF;
    
    -- Destino
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Destino') THEN
        ALTER TABLE rutas ADD COLUMN Destino VARCHAR(200) DEFAULT '' AFTER Origen;
    END IF;
    
    -- Descripcion
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Descripcion') THEN
        ALTER TABLE rutas ADD COLUMN Descripcion VARCHAR(500) DEFAULT '' AFTER Destino;
    END IF;
    
    -- Referencia
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Referencia') THEN
        ALTER TABLE rutas ADD COLUMN Referencia VARCHAR(100) NULL AFTER Descripcion;
    END IF;
    
    -- FechaInicio
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'FechaInicio') THEN
        ALTER TABLE rutas ADD COLUMN FechaInicio DATE NULL AFTER Referencia;
    END IF;
    
    -- FechaFin
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'FechaFin') THEN
        ALTER TABLE rutas ADD COLUMN FechaFin DATE NULL AFTER FechaInicio;
    END IF;
    
    -- HoraPresentacion
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'HoraPresentacion') THEN
        ALTER TABLE rutas ADD COLUMN HoraPresentacion TIME NULL AFTER FechaFin;
    END IF;
    
    -- HoraSalida
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'HoraSalida') THEN
        ALTER TABLE rutas ADD COLUMN HoraSalida TIME NULL AFTER HoraPresentacion;
    END IF;
    
    -- HoraLlegada
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'HoraLlegada') THEN
        ALTER TABLE rutas ADD COLUMN HoraLlegada TIME NULL AFTER HoraSalida;
    END IF;
    
    -- Plazas
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Plazas') THEN
        ALTER TABLE rutas ADD COLUMN Plazas INT NULL AFTER DuracionEstimada;
    END IF;
    
    -- Kilometros
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Kilometros') THEN
        ALTER TABLE rutas ADD COLUMN Kilometros INT NULL AFTER DistanciaKm;
    END IF;
    
    -- Días de operación
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Lunes') THEN
        ALTER TABLE rutas ADD COLUMN Lunes BOOLEAN DEFAULT FALSE AFTER Kilometros;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Martes') THEN
        ALTER TABLE rutas ADD COLUMN Martes BOOLEAN DEFAULT FALSE AFTER Lunes;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Miercoles') THEN
        ALTER TABLE rutas ADD COLUMN Miercoles BOOLEAN DEFAULT FALSE AFTER Martes;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Jueves') THEN
        ALTER TABLE rutas ADD COLUMN Jueves BOOLEAN DEFAULT FALSE AFTER Miercoles;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Viernes') THEN
        ALTER TABLE rutas ADD COLUMN Viernes BOOLEAN DEFAULT FALSE AFTER Jueves;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Sabado') THEN
        ALTER TABLE rutas ADD COLUMN Sabado BOOLEAN DEFAULT FALSE AFTER Viernes;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Domingo') THEN
        ALTER TABLE rutas ADD COLUMN Domingo BOOLEAN DEFAULT FALSE AFTER Sabado;
    END IF;
    
    -- Línea regular
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'CodigoLineaRegular') THEN
        ALTER TABLE rutas ADD COLUMN CodigoLineaRegular VARCHAR(50) NULL AFTER Domingo;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'LineaRegular') THEN
        ALTER TABLE rutas ADD COLUMN LineaRegular VARCHAR(200) NULL AFTER CodigoLineaRegular;
    END IF;
    
    -- Agregación
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'CodigoAgregacion') THEN
        ALTER TABLE rutas ADD COLUMN CodigoAgregacion VARCHAR(50) NULL AFTER LineaRegular;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Agregacion') THEN
        ALTER TABLE rutas ADD COLUMN Agregacion VARCHAR(200) NULL AFTER CodigoAgregacion;
    END IF;
    
    -- Tipo de servicio
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'CodigoTipoServicio') THEN
        ALTER TABLE rutas ADD COLUMN CodigoTipoServicio VARCHAR(10) NULL AFTER Agregacion;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'TipoServicio') THEN
        ALTER TABLE rutas ADD COLUMN TipoServicio VARCHAR(100) NULL AFTER CodigoTipoServicio;
    END IF;
    
    -- Asistente
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'Asistente') THEN
        ALTER TABLE rutas ADD COLUMN Asistente VARCHAR(200) NULL AFTER TipoServicio;
    END IF;
    
    -- CodigoCliente
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'CodigoCliente') THEN
        ALTER TABLE rutas ADD COLUMN CodigoCliente INT NULL AFTER EmpresaId;
    END IF;
    
    -- ClienteId
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'ClienteId') THEN
        ALTER TABLE rutas ADD COLUMN ClienteId INT NULL AFTER CodigoCliente;
    END IF;
    
    -- VehiculoMatricula
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'VehiculoMatricula') THEN
        ALTER TABLE rutas ADD COLUMN VehiculoMatricula VARCHAR(20) NULL AFTER ClienteId;
    END IF;
    
    -- AutobusId
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'AutobusId') THEN
        ALTER TABLE rutas ADD COLUMN AutobusId INT NULL AFTER VehiculoMatricula;
    END IF;
    
    -- ConductorNombre
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'ConductorNombre') THEN
        ALTER TABLE rutas ADD COLUMN ConductorNombre VARCHAR(200) NULL AFTER AutobusId;
    END IF;
    
    -- ConductorId
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND COLUMN_NAME = 'ConductorId') THEN
        ALTER TABLE rutas ADD COLUMN ConductorId INT NULL AFTER ConductorNombre;
    END IF;
    
END//

DELIMITER ;

-- Ejecutar el procedimiento
CALL AddRutasColumns();

-- Limpiar
DROP PROCEDURE IF EXISTS AddRutasColumns;

-- Crear índices si no existen
-- Nota: MySQL no tiene IF NOT EXISTS para índices en todas las versiones
-- Por eso usamos procedimientos

DELIMITER //

DROP PROCEDURE IF EXISTS AddRutasIndexes//

CREATE PROCEDURE AddRutasIndexes()
BEGIN
    -- Verificar e crear índices
    IF NOT EXISTS (SELECT * FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND INDEX_NAME = 'idx_rutas_cliente') THEN
        ALTER TABLE rutas ADD INDEX idx_rutas_cliente (ClienteId);
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND INDEX_NAME = 'idx_rutas_autobus') THEN
        ALTER TABLE rutas ADD INDEX idx_rutas_autobus (AutobusId);
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND INDEX_NAME = 'idx_rutas_conductor') THEN
        ALTER TABLE rutas ADD INDEX idx_rutas_conductor (ConductorId);
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'rutas' 
                   AND INDEX_NAME = 'idx_rutas_codigo') THEN
        ALTER TABLE rutas ADD INDEX idx_rutas_codigo (Codigo);
    END IF;
END//

DELIMITER ;

-- Ejecutar el procedimiento
CALL AddRutasIndexes();

-- Limpiar
DROP PROCEDURE IF EXISTS AddRutasIndexes;

-- Mensaje de confirmación
SELECT 'Script 31_alter_rutas_add_excel_fields.sql ejecutado correctamente' AS Resultado;
SELECT COUNT(*) AS TotalRutas FROM rutas;

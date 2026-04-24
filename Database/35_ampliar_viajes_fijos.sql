-- =====================================================
-- Ampliación de tabla Viajes (Viajes Fijos)
-- Agrega campos de Viajes Discrecionales manteniendo Rutas
-- =====================================================

USE busops;

-- Procedimiento para agregar columnas si no existen
DELIMITER //

DROP PROCEDURE IF EXISTS AmpliarViajesFijos//

CREATE PROCEDURE AmpliarViajesFijos()
BEGIN
    -- Identificación
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Codigo') THEN
        ALTER TABLE Viajes ADD COLUMN Codigo VARCHAR(50) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Referencia') THEN
        ALTER TABLE Viajes ADD COLUMN Referencia VARCHAR(100) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Expediente') THEN
        ALTER TABLE Viajes ADD COLUMN Expediente VARCHAR(100) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'DescripcionExpediente') THEN
        ALTER TABLE Viajes ADD COLUMN DescripcionExpediente TEXT NULL;
    END IF;
    
    -- Horarios detallados
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'HoraPresentacion') THEN
        ALTER TABLE Viajes ADD COLUMN HoraPresentacion TIME NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'HoraSalida') THEN
        ALTER TABLE Viajes ADD COLUMN HoraSalida TIME NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'HoraLlegada') THEN
        ALTER TABLE Viajes ADD COLUMN HoraLlegada TIME NULL;
    END IF;
    
    -- Horarios de cierre
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'HoraPresentacionCierre') THEN
        ALTER TABLE Viajes ADD COLUMN HoraPresentacionCierre TIME NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'HoraSalidaCierre') THEN
        ALTER TABLE Viajes ADD COLUMN HoraSalidaCierre TIME NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'HoraLlegadaCierre') THEN
        ALTER TABLE Viajes ADD COLUMN HoraLlegadaCierre TIME NULL;
    END IF;
    
    -- Plazas
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Plazas') THEN
        ALTER TABLE Viajes ADD COLUMN Plazas INT NULL;
    END IF;
    
    -- Importes adicionales
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'TotalImporte') THEN
        ALTER TABLE Viajes ADD COLUMN TotalImporte DECIMAL(10,2) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Importe') THEN
        ALTER TABLE Viajes ADD COLUMN Importe DECIMAL(10,2) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'TotalProveedor') THEN
        ALTER TABLE Viajes ADD COLUMN TotalProveedor DECIMAL(10,2) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'NumeroFactura') THEN
        ALTER TABLE Viajes ADD COLUMN NumeroFactura VARCHAR(50) NULL;
    END IF;
    
    -- Cliente
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'CodigoCliente') THEN
        ALTER TABLE Viajes ADD COLUMN CodigoCliente VARCHAR(50) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'NombreCliente') THEN
        ALTER TABLE Viajes ADD COLUMN NombreCliente VARCHAR(255) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'ClienteId') THEN
        ALTER TABLE Viajes ADD COLUMN ClienteId INT NULL;
    END IF;
    
    -- Descripción
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Descripcion') THEN
        ALTER TABLE Viajes ADD COLUMN Descripcion TEXT NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Ampliacion') THEN
        ALTER TABLE Viajes ADD COLUMN Ampliacion TEXT NULL;
    END IF;
    
    -- Lugares y coordenadas
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'LugarSalida') THEN
        ALTER TABLE Viajes ADD COLUMN LugarSalida VARCHAR(255) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'PoblacionSalida') THEN
        ALTER TABLE Viajes ADD COLUMN PoblacionSalida VARCHAR(255) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'CoordXSalida') THEN
        ALTER TABLE Viajes ADD COLUMN CoordXSalida DOUBLE NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'CoordYSalida') THEN
        ALTER TABLE Viajes ADD COLUMN CoordYSalida DOUBLE NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'LugarLlegada') THEN
        ALTER TABLE Viajes ADD COLUMN LugarLlegada VARCHAR(255) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'PoblacionLlegada') THEN
        ALTER TABLE Viajes ADD COLUMN PoblacionLlegada VARCHAR(255) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'CoordXLlegada') THEN
        ALTER TABLE Viajes ADD COLUMN CoordXLlegada DOUBLE NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'CoordYLlegada') THEN
        ALTER TABLE Viajes ADD COLUMN CoordYLlegada DOUBLE NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Itinerario') THEN
        ALTER TABLE Viajes ADD COLUMN Itinerario TEXT NULL;
    END IF;
    
    -- Kilometraje
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'KmsInicio') THEN
        ALTER TABLE Viajes ADD COLUMN KmsInicio INT NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'KmsFin') THEN
        ALTER TABLE Viajes ADD COLUMN KmsFin INT NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'KmsTotales') THEN
        ALTER TABLE Viajes ADD COLUMN KmsTotales INT NULL;
    END IF;
    
    -- Vehículo (texto)
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Vehiculo') THEN
        ALTER TABLE Viajes ADD COLUMN Vehiculo VARCHAR(100) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Matricula') THEN
        ALTER TABLE Viajes ADD COLUMN Matricula VARCHAR(20) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'TipoVehiculoSolicitado') THEN
        ALTER TABLE Viajes ADD COLUMN TipoVehiculoSolicitado VARCHAR(100) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'TipoVehiculoAsignado') THEN
        ALTER TABLE Viajes ADD COLUMN TipoVehiculoAsignado VARCHAR(100) NULL;
    END IF;
    
    -- Conductor 2
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Conductor2') THEN
        ALTER TABLE Viajes ADD COLUMN Conductor2 VARCHAR(255) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Conductor2Id') THEN
        ALTER TABLE Viajes ADD COLUMN Conductor2Id INT NULL;
    END IF;
    
    -- Gestión
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Responsable') THEN
        ALTER TABLE Viajes ADD COLUMN Responsable VARCHAR(255) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'VueloTren') THEN
        ALTER TABLE Viajes ADD COLUMN VueloTren VARCHAR(100) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'NombreGrupo') THEN
        ALTER TABLE Viajes ADD COLUMN NombreGrupo VARCHAR(255) NULL;
    END IF;
    
    -- Clasificación
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'GrupoClientes') THEN
        ALTER TABLE Viajes ADD COLUMN GrupoClientes VARCHAR(100) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'INE') THEN
        ALTER TABLE Viajes ADD COLUMN INE VARCHAR(50) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'INE2') THEN
        ALTER TABLE Viajes ADD COLUMN INE2 VARCHAR(50) NULL;
    END IF;
    
    -- Tipo de servicio
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'CodigoTipoServicio') THEN
        ALTER TABLE Viajes ADD COLUMN CodigoTipoServicio VARCHAR(50) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'ServicioTipo') THEN
        ALTER TABLE Viajes ADD COLUMN ServicioTipo VARCHAR(100) NULL;
    END IF;
    
    -- Presupuesto
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'CodigoPresupuesto') THEN
        ALTER TABLE Viajes ADD COLUMN CodigoPresupuesto VARCHAR(50) NULL;
    END IF;
    
    -- Notas
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'NotasInternas') THEN
        ALTER TABLE Viajes ADD COLUMN NotasInternas TEXT NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Notas') THEN
        ALTER TABLE Viajes ADD COLUMN Notas TEXT NULL;
    END IF;
    
    -- Comisionista
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Comisionista') THEN
        ALTER TABLE Viajes ADD COLUMN Comisionista VARCHAR(255) NULL;
    END IF;
    
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'ImporteComisionista') THEN
        ALTER TABLE Viajes ADD COLUMN ImporteComisionista DECIMAL(10,2) NULL;
    END IF;
    
    -- Estado adicional
    IF NOT EXISTS (SELECT * FROM information_schema.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND COLUMN_NAME = 'Anulado') THEN
        ALTER TABLE Viajes ADD COLUMN Anulado BOOLEAN DEFAULT 0;
    END IF;
END//

DELIMITER ;

-- Ejecutar procedimiento
CALL AmpliarViajesFijos();

-- Eliminar procedimiento
DROP PROCEDURE AmpliarViajesFijos;

-- Procedimiento para agregar índices
DELIMITER //

DROP PROCEDURE IF EXISTS AgregarIndicesViajes//

CREATE PROCEDURE AgregarIndicesViajes()
BEGIN
    -- Verificar y crear índices si no existen
    IF NOT EXISTS (SELECT 1 FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND INDEX_NAME = 'idx_viajes_codigo') THEN
        CREATE INDEX idx_viajes_codigo ON Viajes(Codigo);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND INDEX_NAME = 'idx_viajes_referencia') THEN
        CREATE INDEX idx_viajes_referencia ON Viajes(Referencia);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND INDEX_NAME = 'idx_viajes_clienteid') THEN
        CREATE INDEX idx_viajes_clienteid ON Viajes(ClienteId);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND INDEX_NAME = 'idx_viajes_conductor2id') THEN
        CREATE INDEX idx_viajes_conductor2id ON Viajes(Conductor2Id);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND INDEX_NAME = 'idx_viajes_fechasalida') THEN
        CREATE INDEX idx_viajes_fechasalida ON Viajes(FechaHoraSalida);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.STATISTICS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'Viajes' 
                   AND INDEX_NAME = 'idx_viajes_anulado') THEN
        CREATE INDEX idx_viajes_anulado ON Viajes(Anulado);
    END IF;
END//

DELIMITER ;

-- Ejecutar procedimiento de índices
CALL AgregarIndicesViajes();

-- Eliminar procedimiento
DROP PROCEDURE AgregarIndicesViajes;

-- Agregar claves foráneas si no existen
SET @constraint_exists = (SELECT COUNT(*) 
                          FROM information_schema.TABLE_CONSTRAINTS 
                          WHERE CONSTRAINT_SCHEMA = 'busops' 
                          AND TABLE_NAME = 'Viajes' 
                          AND CONSTRAINT_NAME = 'fk_viajes_cliente');

SET @sql = IF(@constraint_exists = 0,
              'ALTER TABLE Viajes ADD CONSTRAINT fk_viajes_cliente FOREIGN KEY (ClienteId) REFERENCES Clientes(Id) ON DELETE SET NULL',
              'SELECT "FK fk_viajes_cliente ya existe" AS Info');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @constraint_exists = (SELECT COUNT(*) 
                          FROM information_schema.TABLE_CONSTRAINTS 
                          WHERE CONSTRAINT_SCHEMA = 'busops' 
                          AND TABLE_NAME = 'Viajes' 
                          AND CONSTRAINT_NAME = 'fk_viajes_conductor2');

SET @sql = IF(@constraint_exists = 0,
              'ALTER TABLE Viajes ADD CONSTRAINT fk_viajes_conductor2 FOREIGN KEY (Conductor2Id) REFERENCES Conductores(Id) ON DELETE SET NULL',
              'SELECT "FK fk_viajes_conductor2 ya existe" AS Info');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SELECT 'Tabla Viajes ampliada correctamente con campos adicionales.' AS Resultado;

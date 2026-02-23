-- Script de migración: Crear tabla de Centros Administrativos para FacturaE
-- Fecha: 2026-02-11
-- Descripción: Tabla para almacenar centros administrativos de clientes (requerido por FacturaE)

-- Crear tabla CentrosAdministrativos si no existe
CREATE TABLE IF NOT EXISTS `CentrosAdministrativos` (
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `ClienteId` INT NOT NULL,
    `CodigoCentro` VARCHAR(20) NOT NULL COMMENT 'Código del centro administrativo',
    `CodigoRol` VARCHAR(2) NOT NULL COMMENT '01=Oficina contable, 02=Órgano gestor, 03=Unidad tramitadora, 04=Órgano proponente',
    `Nombre` VARCHAR(200) NOT NULL COMMENT 'Nombre del centro',
    `Direccion` VARCHAR(200) NULL,
    `CodigoPostal` VARCHAR(10) NULL,
    `Ciudad` VARCHAR(100) NULL,
    `Provincia` VARCHAR(100) NULL,
    `Pais` VARCHAR(3) NULL DEFAULT 'ESP',
    
    CONSTRAINT `FK_CentrosAdministrativos_Clientes` 
        FOREIGN KEY (`ClienteId`) REFERENCES `Clientes`(`Id`) ON DELETE CASCADE,
    
    INDEX `IX_CentrosAdministrativos_ClienteId` (`ClienteId`),
    INDEX `IX_CentrosAdministrativos_CodigoRol` (`CodigoRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Agregar campos de descuentos y recargos a Facturas si no existen
SET @dbname = DATABASE();
SET @tablename = 'Facturas';
SET @columnname = 'DescuentosGenerales';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE TABLE_SCHEMA = @dbname
   AND TABLE_NAME = @tablename
   AND COLUMN_NAME = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' DECIMAL(10,2) NULL DEFAULT 0.00 COMMENT ''Descuentos generales aplicados''')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

SET @columnname = 'RecargosGenerales';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE TABLE_SCHEMA = @dbname
   AND TABLE_NAME = @tablename
   AND COLUMN_NAME = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' DECIMAL(10,2) NULL DEFAULT 0.00 COMMENT ''Recargos generales aplicados''')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Notas de implementación:
-- RoleTypeCode:
--   01 = Oficina contable (gestor administrativo)
--   02 = Órgano gestor (órgano que gestiona el expediente)
--   03 = Unidad tramitadora (unidad administrativa tramitadora)
--   04 = Órgano proponente (unidad que propone el gasto)

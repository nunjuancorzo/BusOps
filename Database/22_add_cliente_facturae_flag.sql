-- Script de migración: Añadir campo ClienteFacturaE a la tabla Clientes
-- Fecha: 2026-02-13
-- Descripción: Campo para marcar clientes que requieren datos completos de FacturaE (administraciones públicas, etc.)

SET @dbname = DATABASE();
SET @tablename = 'Clientes';
SET @columnname = 'ClienteFacturaE';

SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE TABLE_SCHEMA = @dbname
   AND TABLE_NAME = @tablename
   AND COLUMN_NAME = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' TINYINT(1) NOT NULL DEFAULT 0 COMMENT ''Indica si el cliente requiere facturación electrónica con todos los datos (FacturaE)''')
));

PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Marcar el cliente EPESEC como cliente FacturaE
UPDATE Clientes SET ClienteFacturaE = 1 WHERE NIF = 'S0611001I';

SELECT 'Migración completada: campo ClienteFacturaE añadido' AS Resultado;

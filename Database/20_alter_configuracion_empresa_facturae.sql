-- Script de migración: Agregar campos FacturaE a ConfiguracionEmpresa
-- Fecha: 2026-02-11
-- Descripción: Agregar TipoPersona y TipoResidencia para completar los datos del emisor FacturaE

SET @dbname = DATABASE();
SET @tablename = 'ConfiguracionEmpresa';

-- Agregar TipoPersona (0=Física, 1=Jurídica)
SET @columnname = 'TipoPersona';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE TABLE_SCHEMA = @dbname
   AND TABLE_NAME = @tablename
   AND COLUMN_NAME = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NOT NULL DEFAULT 1 COMMENT ''0=Física, 1=Jurídica''')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Agregar TipoResidencia (0=Residente, 1=No residente)
SET @columnname = 'TipoResidencia';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE TABLE_SCHEMA = @dbname
   AND TABLE_NAME = @tablename
   AND COLUMN_NAME = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NOT NULL DEFAULT 0 COMMENT ''0=Residente, 1=No residente''')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Notas de implementación:
-- TipoPersona:
--   0 = Física (Individual)
--   1 = Jurídica (LegalEntity) - DEFAULT para empresas
--
-- TipoResidencia:
--   0 = Residente en España - DEFAULT
--   1 = No residente (intracomunitario o extranjero)

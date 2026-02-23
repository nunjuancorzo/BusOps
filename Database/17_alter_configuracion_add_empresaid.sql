-- Migración 17: Agregar EmpresaId a ConfiguracionEmpresa para multi-tenancy
-- Fecha: 2026-02-10
-- Descripción: Agrega columna EmpresaId a ConfiguracionEmpresa para separar datos de configuración por empresa

USE BusOps;

-- Deshabilitar safe update mode temporalmente
SET SQL_SAFE_UPDATES = 0;

-- Agregar columna EmpresaId solo si no existe
SET @col_exists = (SELECT COUNT(*) 
                   FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = 'busops' 
                   AND TABLE_NAME = 'ConfiguracionEmpresa' 
                   AND COLUMN_NAME = 'EmpresaId');

SET @sql = IF(@col_exists = 0, 
              'ALTER TABLE ConfiguracionEmpresa ADD COLUMN EmpresaId INT NULL;', 
              'SELECT "Columna EmpresaId ya existe" AS Info;');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Poblar EmpresaId basándonos en la relación inversa desde Empresas
-- Solo actualizar registros donde EmpresaId sea NULL
UPDATE ConfiguracionEmpresa ce
INNER JOIN Empresas e ON e.ConfiguracionEmpresaId = ce.Id
SET ce.EmpresaId = e.Id
WHERE ce.EmpresaId IS NULL;

-- Rehabilitar safe update mode
SET SQL_SAFE_UPDATES = 1;

-- Agregar índice solo si no existe
SET @index_exists = (SELECT COUNT(*) 
                     FROM INFORMATION_SCHEMA.STATISTICS 
                     WHERE TABLE_SCHEMA = 'busops' 
                     AND TABLE_NAME = 'ConfiguracionEmpresa' 
                     AND INDEX_NAME = 'IX_ConfiguracionEmpresa_EmpresaId');

SET @sql = IF(@index_exists = 0, 
              'CREATE INDEX IX_ConfiguracionEmpresa_EmpresaId ON ConfiguracionEmpresa(EmpresaId);', 
              'SELECT "Índice IX_ConfiguracionEmpresa_EmpresaId ya existe" AS Info;');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Agregar foreign key solo si no existe
SET @fk_exists = (SELECT COUNT(*) 
                  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
                  WHERE TABLE_SCHEMA = 'busops' 
                  AND TABLE_NAME = 'ConfiguracionEmpresa' 
                  AND CONSTRAINT_NAME = 'FK_ConfiguracionEmpresa_Empresa');

SET @sql = IF(@fk_exists = 0, 
              'ALTER TABLE ConfiguracionEmpresa ADD CONSTRAINT FK_ConfiguracionEmpresa_Empresa FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id) ON DELETE SET NULL;', 
              'SELECT "Foreign key FK_ConfiguracionEmpresa_Empresa ya existe" AS Info;');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Verificar migración
SELECT 'Migración 17 completada' AS Status;
SELECT ce.Id, ce.NombreEmpresa, ce.EmpresaId, e.NombreComercial
FROM ConfiguracionEmpresa ce
LEFT JOIN Empresas e ON ce.EmpresaId = e.Id;

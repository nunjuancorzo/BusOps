-- Script para modificar la tabla Clientes
-- Permite que los campos Nombre y Apellidos sean NULL
-- Para clientes de tipo Empresa y Agencia

USE busops;

-- Modificar la columna Nombre para permitir NULL
ALTER TABLE Clientes 
MODIFY COLUMN Nombre VARCHAR(100) NULL;

-- La columna Apellidos ya permite NULL, no necesita modificación
-- ALTER TABLE Clientes 
-- MODIFY COLUMN Apellidos VARCHAR(100) NULL;

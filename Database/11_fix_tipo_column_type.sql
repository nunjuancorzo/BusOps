-- Corregir el tipo de dato de la columna Tipo en LineasFactura
-- El campo debe ser INT para que coincida con el enum en el código

-- Eliminar la columna si existe
ALTER TABLE LineasFactura DROP COLUMN Tipo;

-- Agregar la columna con el tipo correcto (INT)
ALTER TABLE LineasFactura ADD COLUMN Tipo INT NOT NULL DEFAULT 0;

-- Actualizar registros existentes (0 = Servicio, 1 = CargoAdicional)
SET SQL_SAFE_UPDATES = 0;
UPDATE LineasFactura SET Tipo = 0;
SET SQL_SAFE_UPDATES = 1;

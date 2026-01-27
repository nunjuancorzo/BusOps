-- Agregar campo Tipo a la tabla LineasFactura

ALTER TABLE LineasFactura ADD COLUMN Tipo INT DEFAULT 0;

-- Deshabilitar temporalmente el modo seguro para actualizar
SET SQL_SAFE_UPDATES = 0;

-- Actualizar registros existentes para que tengan el tipo 'Servicio' (0) por defecto
UPDATE LineasFactura SET Tipo = 0 WHERE Tipo IS NULL;

-- Volver a habilitar el modo seguro
SET SQL_SAFE_UPDATES = 1;

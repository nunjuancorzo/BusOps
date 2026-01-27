-- Agregar campo ImporteConcepto a la tabla Facturas

ALTER TABLE Facturas ADD COLUMN ImporteConcepto DECIMAL(10,2) DEFAULT 0;

-- Deshabilitar temporalmente el modo seguro para actualizar
SET SQL_SAFE_UPDATES = 0;

-- Actualizar registros existentes
UPDATE Facturas SET ImporteConcepto = 0 WHERE ImporteConcepto IS NULL;

-- Volver a habilitar el modo seguro
SET SQL_SAFE_UPDATES = 1;

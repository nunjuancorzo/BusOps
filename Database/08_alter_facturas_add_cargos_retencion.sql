-- Añadir campos de cargos adicionales y retención a la tabla Facturas

ALTER TABLE Facturas ADD COLUMN CargosAdicionales DECIMAL(10,2) DEFAULT 0;
ALTER TABLE Facturas ADD COLUMN ConceptoCargos TEXT;
ALTER TABLE Facturas ADD COLUMN PorcentajeRetencion DECIMAL(5,2) DEFAULT 0;
ALTER TABLE Facturas ADD COLUMN ImporteRetencion DECIMAL(10,2) DEFAULT 0;

-- Deshabilitar temporalmente el modo seguro para actualizar
SET SQL_SAFE_UPDATES = 0;

-- Actualizar el cálculo del total de las facturas existentes
-- El total ahora es: BaseImponible + ImporteIVA + CargosAdicionales - ImporteRetencion
UPDATE Facturas 
SET CargosAdicionales = 0,
    PorcentajeRetencion = 0,
    ImporteRetencion = 0
WHERE CargosAdicionales IS NULL;

-- Volver a habilitar el modo seguro
SET SQL_SAFE_UPDATES = 1;

-- Agregar campo SubserieFactura a la tabla ConfiguracionEmpresa
-- Este campo permite agregar una letra o código adicional después del año
-- Ejemplo: AYE2026A02 donde "A" es la subserie

ALTER TABLE ConfiguracionEmpresa 
ADD COLUMN SubserieFactura VARCHAR(5) NULL 
COMMENT 'Subserie o letra adicional que va después del año (ej: A, B, C)';

-- Actualizar las configuraciones existentes con valor predeterminado 'A'
UPDATE ConfiguracionEmpresa 
SET SubserieFactura = 'A' 
WHERE SubserieFactura IS NULL;

SELECT '✅ Campo SubserieFactura agregado correctamente' AS 'Resultado';

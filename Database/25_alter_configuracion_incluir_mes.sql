-- Agregar campo IncluirMesEnSerie a la tabla ConfiguracionEmpresa
-- Este campo permite incluir el número del mes en la serie de facturas
-- Ejemplo: AYE2026A02-0003 donde 02 es febrero

ALTER TABLE ConfiguracionEmpresa 
ADD COLUMN IncluirMesEnSerie TINYINT(1) DEFAULT 0 
COMMENT 'Incluir número de mes en la serie de facturas (01-12)';

SELECT '✅ Campo IncluirMesEnSerie agregado correctamente' AS 'Resultado';

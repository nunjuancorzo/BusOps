-- Actualizar configuración de Autocares Yegros para usar el nuevo sistema de numeración
-- Serie: AYE2026A02-0014 (donde 02 es el mes de febrero)

UPDATE ConfiguracionEmpresa 
SET 
    SerieFactura = 'AYE',
    SubserieFactura = 'A',
    IncluirMesEnSerie = 1,
    NumeroFacturaActual = 14,  -- Siguiente número a usar después de 0013
    LongitudNumeroFactura = 4  -- 4 dígitos: 0001, 0002, etc.
WHERE EmpresaId = 1;

SELECT '✅ Configuración actualizada para Autocares Yegros' AS 'Resultado';
SELECT 
    CONCAT('Serie: ', SerieFactura) AS 'Configuración',
    CONCAT('Subserie: ', SubserieFactura) AS 'Configuración2',
    CONCAT('Incluir mes: ', IF(IncluirMesEnSerie, 'Sí', 'No')) AS 'Configuración3',
    CONCAT('Número actual: ', NumeroFacturaActual) AS 'Configuración4',
    CONCAT('Ejemplo próxima factura: AYE2026A02-0014') AS 'Vista Previa'
FROM ConfiguracionEmpresa 
WHERE EmpresaId = 1;

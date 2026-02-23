-- =====================================================
-- Resumen Final Completo - Autocares Yegros
-- =====================================================

USE busops;

SELECT '========================================================' AS '';
SELECT 'RESUMEN FINAL COMPLETO - AUTOCARES YEGROS' AS '';
SELECT '========================================================' AS '';
SELECT '' AS '';

-- Clientes
SELECT CONCAT('Clientes: ', COUNT(*)) AS 'Totales' FROM Clientes WHERE EmpresaId = 1;

-- Conductores
SELECT CONCAT('Conductores: ', COUNT(*)) AS 'Totales' FROM Conductores WHERE EmpresaId = 1;

-- Autobuses
SELECT CONCAT('Autobuses: ', COUNT(*), ' (Total plazas: ', SUM(CapacidadPasajeros), ')') AS 'Totales' FROM Autobuses WHERE EmpresaId = 1;

-- Presupuestos
SELECT CONCAT('Presupuestos: ', COUNT(*)) AS 'Totales' FROM Presupuestos WHERE EmpresaId = 1;

-- Facturas
SELECT CONCAT('Facturas: ', COUNT(*), ' (Total facturado: ', FORMAT(SUM(Total), 2), ' EUR)') AS 'Totales' FROM Facturas WHERE EmpresaId = 1;

SELECT '' AS '';
SELECT '========================================================' AS '';
SELECT 'MIGRACIÓN COMPLETADA EXITOSAMENTE' AS '';
SELECT '========================================================' AS '';

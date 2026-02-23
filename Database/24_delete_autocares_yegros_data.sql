-- =====================================================
-- Script: Eliminar datos de Autocares Yegros
-- Versión: 24
-- Fecha: 19/02/2026
-- Descripción: Elimina todos los datos actuales de la empresa
--              Autocares Yegros (EmpresaId = 1) para cargar
--              nuevos datos desde archivos CSV
-- =====================================================

USE busops;

-- =====================================================
-- IMPORTANTE: Este script eliminará TODOS los datos
-- de la empresa Autocares Yegros (EmpresaId = 1)
-- =====================================================

-- Deshabilitar comprobaciones de claves foráneas temporalmente
SET FOREIGN_KEY_CHECKS = 0;

-- =====================================================
-- PASO 1: Eliminar Líneas de Presupuestos
-- =====================================================
-- Primero eliminamos las líneas de presupuestos porque tienen FK a Presupuestos
DELETE FROM LineasPresupuesto 
WHERE PresupuestoId IN (
    SELECT Id FROM Presupuestos WHERE EmpresaId = 1
);

SELECT CONCAT('Líneas de presupuestos eliminadas: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 2: Eliminar Presupuestos
-- =====================================================
DELETE FROM Presupuestos 
WHERE EmpresaId = 1;

SELECT CONCAT('Presupuestos eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 3: Eliminar Líneas de Facturas
-- =====================================================
-- Eliminar líneas de facturas porque tienen FK a Facturas
DELETE FROM LineasFactura 
WHERE FacturaId IN (
    SELECT Id FROM Facturas WHERE EmpresaId = 1
);

SELECT CONCAT('Líneas de facturas eliminadas: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 4: Eliminar Facturas
-- =====================================================
DELETE FROM Facturas 
WHERE EmpresaId = 1;

SELECT CONCAT('Facturas eliminadas: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 5: Eliminar Reservas relacionadas con Viajes
-- =====================================================
-- Eliminar reservas de viajes de la empresa
DELETE FROM Reservas 
WHERE ViajeId IN (
    SELECT Id FROM Viajes WHERE AutobusId IN (
        SELECT Id FROM Autobuses WHERE EmpresaId = 1
    )
);

SELECT CONCAT('Reservas eliminadas: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 6: Eliminar Viajes
-- =====================================================
DELETE FROM Viajes 
WHERE AutobusId IN (
    SELECT Id FROM Autobuses WHERE EmpresaId = 1
);

SELECT CONCAT('Viajes eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 7: Eliminar Mantenimientos de Autobuses
-- =====================================================
DELETE FROM MantenimientosAutobus 
WHERE EmpresaId = 1;

SELECT CONCAT('Mantenimientos eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 8: Eliminar Gastos
-- =====================================================
DELETE FROM Gastos 
WHERE EmpresaId = 1;

SELECT CONCAT('Gastos eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 9: Eliminar Documentos de Clientes
-- =====================================================
DELETE FROM Documentos 
WHERE ClienteId IN (
    SELECT Id FROM Clientes WHERE EmpresaId = 1
);

SELECT CONCAT('Documentos de clientes eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 10: Eliminar Documentos de Proveedores  
-- =====================================================
DELETE FROM Documentos 
WHERE ProveedorId IN (
    SELECT Id FROM Proveedores WHERE EmpresaId = 1
);

SELECT CONCAT('Documentos de proveedores eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 11: Eliminar Documentos de Conductores
-- =====================================================
DELETE FROM Documentos 
WHERE ConductorId IN (
    SELECT Id FROM Conductores WHERE EmpresaId = 1
);

SELECT CONCAT('Documentos de conductores eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 12: Eliminar Documentos restantes
-- =====================================================
DELETE FROM Documentos 
WHERE EmpresaId = 1;

SELECT CONCAT('Documentos restantes eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 13: Eliminar Conductores
-- =====================================================
DELETE FROM Conductores 
WHERE EmpresaId = 1;

SELECT CONCAT('Conductores eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 14: Eliminar Autobuses
-- =====================================================
DELETE FROM Autobuses 
WHERE EmpresaId = 1;

SELECT CONCAT('Autobuses eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 15: Eliminar Clientes
-- =====================================================
DELETE FROM Clientes 
WHERE EmpresaId = 1;

SELECT CONCAT('Clientes eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 16: Eliminar Proveedores
-- =====================================================
DELETE FROM Proveedores 
WHERE EmpresaId = 1;

SELECT CONCAT('Proveedores eliminados: ', ROW_COUNT()) AS resultado;

-- =====================================================
-- PASO 17: Eliminar Rutas (si existen)
-- =====================================================
-- Nota: Revisar si la tabla Rutas tiene EmpresaId
-- DELETE FROM Rutas WHERE EmpresaId = 1;

-- Habilitar comprobaciones de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- RESUMEN
-- =====================================================
SELECT '=============================================' AS '';
SELECT 'ELIMINACIÓN COMPLETADA' AS '';
SELECT '=============================================' AS '';
SELECT 'Todos los datos de Autocares Yegros (EmpresaId = 1) han sido eliminados' AS '';
SELECT 'La base de datos está lista para cargar los nuevos datos' AS '';
SELECT '=============================================' AS '';

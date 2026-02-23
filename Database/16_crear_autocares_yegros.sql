-- =====================================================
-- Script: Crear empresa Autocares Yegros y usuario
-- Versión: 16
-- Fecha: 2026-02-10
-- Descripción: Convierte la empresa por defecto en Autocares Yegros
--              y crea un usuario administrador para esa empresa
-- =====================================================

USE busops;

-- =====================================================
-- PASO 1: Actualizar empresa existente a Autocares Yegros
-- =====================================================

UPDATE Empresas 
SET 
    NombreComercial = 'Autocares Yegros',
    Slug = 'autocares-yegros',
    Activa = TRUE,
    PlanSuscripcion = 'Empresarial'
WHERE Id = 1;

-- =====================================================
-- PASO 2: Actualizar configuración de la empresa
-- =====================================================

UPDATE ConfiguracionEmpresa 
SET 
    NombreEmpresa = 'Autocares Yegros S.L.',
    NIF = 'B12345678', -- Cambiar por el NIF real
    Direccion = 'Calle Principal 123',
    Ciudad = 'Madrid',
    CodigoPostal = '28001',
    Provincia = 'Madrid',
    Telefono = '+34 911 234 567',
    Email = 'info@autocaresyegros.com',
    Web = 'www.autocaresyegros.com'
WHERE Id = 1;

-- =====================================================
-- PASO 3: Crear usuario administrador para Autocares Yegros
-- =====================================================

-- Insertar usuario autocaresyegros
INSERT INTO Usuarios (Username, Password, NombreCompleto, Email, Rol, Activo, EmpresaId, FechaCreacion)
VALUES (
    'autocaresyegros',
    '1234', -- IMPORTANTE: Cambiar esta contraseña en producción
    'Administrador Autocares Yegros',
    'admin@autocaresyegros.com',
    'Administrador',
    1,
    1, -- Asociado a la empresa Autocares Yegros (ID=1)
    NOW()
)
ON DUPLICATE KEY UPDATE
    Password = '1234',
    NombreCompleto = 'Administrador Autocares Yegros',
    Email = 'admin@autocaresyegros.com',
    Rol = 'Administrador',
    Activo = 1,
    EmpresaId = 1;

-- =====================================================
-- PASO 4: Verificar la configuración
-- =====================================================

-- Mostrar empresa
SELECT 
    Id,
    NombreComercial,
    Slug,
    Activa,
    PlanSuscripcion,
    ConfiguracionEmpresaId
FROM Empresas
WHERE Id = 1;

-- Mostrar configuración de la empresa
SELECT 
    Id,
    NombreEmpresa,
    NIF,
    Direccion,
    Ciudad,
    Email,
    Telefono
FROM ConfiguracionEmpresa
WHERE Id = 1;

-- Mostrar usuarios de la empresa
SELECT 
    Id,
    Username,
    NombreCompleto,
    Email,
    Rol,
    EmpresaId,
    Activo
FROM Usuarios
WHERE EmpresaId = 1 OR Username = 'autocaresyegros';

-- Verificar que todos los datos están asociados a la empresa
SELECT 
    'Autobuses' as Entidad, COUNT(*) as Total FROM Autobuses WHERE EmpresaId = 1
UNION ALL
SELECT 'Clientes', COUNT(*) FROM Clientes WHERE EmpresaId = 1
UNION ALL
SELECT 'Conductores', COUNT(*) FROM Conductores WHERE EmpresaId = 1
UNION ALL
SELECT 'Facturas', COUNT(*) FROM Facturas WHERE EmpresaId = 1
UNION ALL
SELECT 'Gastos', COUNT(*) FROM Gastos WHERE EmpresaId = 1
UNION ALL
SELECT 'Presupuestos', COUNT(*) FROM Presupuestos WHERE EmpresaId = 1
UNION ALL
SELECT 'Proveedores', COUNT(*) FROM Proveedores WHERE EmpresaId = 1
UNION ALL
SELECT 'Viajes', COUNT(*) FROM Viajes WHERE EmpresaId = 1
UNION ALL
SELECT 'Reservas', COUNT(*) FROM Reservas WHERE EmpresaId = 1
UNION ALL
SELECT 'Pasajeros', COUNT(*) FROM Pasajeros WHERE EmpresaId = 1;

-- =====================================================
-- NOTAS IMPORTANTES
-- =====================================================

-- 1. Todos los datos existentes (autobuses, clientes, facturas, etc.) 
--    ya están asociados a la empresa con Id=1, por lo que automáticamente
--    pertenecen a Autocares Yegros.

-- 2. Credenciales de acceso:
--    - SuperAdmin: superadmin / 1234 (puede ver todas las empresas)
--    - Admin Autocares Yegros: autocaresyegros / 1234 (solo ve su empresa)

-- 3. SEGURIDAD: Cambiar las contraseñas antes de usar en producción

-- 4. El SuperAdmin puede crear más empresas desde la interfaz de "Empresas"
--    en la aplicación.

-- =====================================================
-- FIN DEL SCRIPT
-- =====================================================

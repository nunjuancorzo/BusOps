-- =====================================================
-- Script para actualizar el usuario superadmin
-- Ejecutar este script si el login con superadmin/1234 no funciona
-- =====================================================

USE busops;

-- Actualizar o crear el usuario superadmin
UPDATE Usuarios 
SET 
    Username = 'superadmin',
    Password = '1234',
    NombreCompleto = 'Super Administrador',
    Email = 'superadmin@busops.com',
    Rol = 'SuperAdministrador',
    EmpresaId = NULL,
    Activo = 1
WHERE Id = 1;

-- Verificar que el usuario se actualizó correctamente
SELECT Id, Username, Password, Rol, EmpresaId, Activo 
FROM Usuarios 
WHERE Id = 1;

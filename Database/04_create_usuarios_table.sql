-- ============================================
-- Script: 04_create_usuarios_table.sql
-- Descripción: Creación de tabla de usuarios con sistema de roles
-- ============================================

-- Crear tabla de usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    NombreCompleto VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Rol VARCHAR(50) NOT NULL DEFAULT 'Usuario',
    Activo TINYINT(1) NOT NULL DEFAULT 1,
    FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Insertar usuario administrador por defecto
INSERT IGNORE INTO Usuarios (Id, Username, Password, NombreCompleto, Email, Rol, Activo, FechaCreacion)
VALUES (1, 'admin', '1234', 'Administrador', 'admin@busops.com', 'Administrador', 1, NOW());

-- Crear índice único en Username (opcional, ya que ya es UNIQUE en la columna)
CREATE UNIQUE INDEX idx_usuarios_username ON Usuarios(Username);

-- Comentarios sobre la estructura:
-- - Id: Identificador único autoincremental
-- - Username: Nombre de usuario único para login
-- - Password: Contraseña (en producción debería estar hasheada)
-- - NombreCompleto: Nombre completo del usuario
-- - Email: Correo electrónico del usuario
-- - Rol: Puede ser 'Administrador' o 'Usuario'
-- - Activo: 1=Activo, 0=Inactivo
-- - FechaCreacion: Fecha y hora de creación del usuario

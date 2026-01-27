-- ============================================
-- Script: 05_alter_conductores_add_autobus.sql
-- Descripción: Agregar relación entre Conductor y Autobús
-- ============================================

-- Agregar columna AutobusId a la tabla Conductores
ALTER TABLE Conductores
ADD COLUMN AutobusId INT NULL;

-- Crear clave foránea hacia Autobuses
ALTER TABLE Conductores
ADD CONSTRAINT FK_Conductores_Autobuses
FOREIGN KEY (AutobusId) REFERENCES Autobuses(Id)
ON DELETE SET NULL;

-- Crear índice para mejorar el rendimiento de las consultas
CREATE INDEX idx_conductores_autobus ON Conductores(AutobusId);

-- Comentarios sobre la estructura:
-- - AutobusId: Referencia al autobús asignado habitualmente al conductor (nullable)
-- - La relación es opcional (NULL permitido) ya que no todos los conductores tienen un autobús asignado
-- - ON DELETE SET NULL asegura que si se elimina el autobús, el conductor no se elimine

-- Crear tabla Proveedores
CREATE TABLE IF NOT EXISTS Proveedores (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(200) NOT NULL,
    NIF VARCHAR(20) NULL,
    Direccion VARCHAR(255) NULL,
    Ciudad VARCHAR(100) NULL,
    CodigoPostal VARCHAR(10) NULL,
    Telefono VARCHAR(20) NULL,
    Email VARCHAR(100) NULL,
    Contacto VARCHAR(100) NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    FechaRegistro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_proveedores_nombre (Nombre),
    INDEX idx_proveedores_activo (Activo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Modificar tabla Gastos para agregar relación con Proveedores
ALTER TABLE Gastos 
    ADD COLUMN ProveedorId INT NULL AFTER Descripcion,
    ADD CONSTRAINT fk_gastos_proveedor 
        FOREIGN KEY (ProveedorId) REFERENCES Proveedores(Id) 
        ON DELETE SET NULL;

-- Eliminar columna antigua Proveedor (texto) - Ejecutar solo si la columna existe
-- ALTER TABLE Gastos DROP COLUMN Proveedor;

-- Insertar algunos proveedores de ejemplo
INSERT INTO Proveedores (Nombre, NIF, Direccion, Ciudad, CodigoPostal, Telefono, Email, Contacto, Activo) VALUES
('Repsol', 'B12345678', 'Calle Méndez Álvaro 44', 'Madrid', '28045', '912345678', 'info@repsol.com', 'Juan Pérez', TRUE),
('Cepsa', 'B87654321', 'Paseo de la Castellana 259A', 'Madrid', '28046', '913456789', 'contacto@cepsa.com', 'María García', TRUE),
('Taller Mecánico Central', 'B11223344', 'Polígono Industrial Sur', 'Barcelona', '08040', '934567890', 'taller@mecanico.com', 'Pedro Sánchez', TRUE),
('Seguros Generales S.A.', 'B55667788', 'Gran Vía 25', 'Madrid', '28013', '915678901', 'seguros@general.com', 'Ana Martínez', TRUE),
('LimpioExpress', 'B99887766', 'Calle Limpieza 15', 'Valencia', '46015', '963789012', 'info@limpioexpress.com', 'Carlos López', TRUE),
('Via-T', 'B44332211', 'Avenida Autopistas 10', 'Madrid', '28050', '916890123', 'viat@autopistas.com', 'Laura Fernández', TRUE);

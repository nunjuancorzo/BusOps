-- =====================================================
-- Script de Migración a Multi-Tenant
-- Versión: 15
-- Fecha: 2026-02-10
-- Descripción: Agrega soporte multi-tenant a la base de datos
-- =====================================================

-- =====================================================
-- PASO 1: Crear tabla Empresas
-- =====================================================

CREATE TABLE IF NOT EXISTS Empresas (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    NombreComercial VARCHAR(255) NOT NULL,
    Slug VARCHAR(100) NOT NULL UNIQUE,
    Activa BOOLEAN NOT NULL DEFAULT TRUE,
    FechaAlta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaBaja DATETIME NULL,
    PlanSuscripcion VARCHAR(50) NOT NULL DEFAULT 'Basico',
    MaxUsuarios INT NULL,
    MaxAutobuses INT NULL,
    MaxConductores INT NULL,
    ConfiguracionEmpresaId INT NOT NULL,
    INDEX idx_empresas_slug (Slug),
    INDEX idx_empresas_activa (Activa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- PASO 2: Agregar columna EmpresaId a Usuarios (nullable para SuperAdmin)
-- =====================================================

ALTER TABLE Usuarios 
ADD COLUMN EmpresaId INT NULL AFTER Rol,
ADD INDEX idx_usuarios_empresaid (EmpresaId);

-- =====================================================
-- PASO 3: Crear Empresa predeterminada con configuración existente
-- =====================================================

-- Insertar empresa predeterminada usando la primera configuración existente
INSERT INTO Empresas (Id, NombreComercial, Slug, Activa, FechaAlta, PlanSuscripcion, MaxUsuarios, MaxAutobuses, MaxConductores, ConfiguracionEmpresaId)
SELECT 
    1,
    IFNULL(NombreEmpresa, 'Mi Empresa'),
    'mi-empresa',
    TRUE,
    NOW(),
    'Empresarial',
    NULL, -- Sin límite
    NULL, -- Sin límite
    NULL, -- Sin límite
    Id
FROM ConfiguracionEmpresa
ORDER BY Id ASC
LIMIT 1;

-- Si no existe configuración, crear una por defecto
INSERT IGNORE INTO ConfiguracionEmpresa (
    Id, NombreEmpresa, NIF, Direccion, Ciudad, CodigoPostal, Provincia, 
    Telefono, Email, SerieFactura, NumeroFacturaActual, LongitudNumeroFactura,
    IncluirAñoEnSerie, SeriePresupuesto, NumeroPresupuestoActual, 
    LongitudNumeroPresupuesto, IVAPorDefecto, DiasVencimientoPorDefecto
)
VALUES (
    1, 'Mi Empresa', '00000000X', 'Dirección', 'Ciudad', '00000', 'Provincia',
    '000000000', 'contacto@empresa.com', 'FAC', 1, 4,
    TRUE, 'PRES', 1, 4, 21.00, 30
);

-- Actualizar Empresas por si no se insertó antes
UPDATE Empresas SET ConfiguracionEmpresaId = 1 WHERE Id = 1 AND ConfiguracionEmpresaId IS NULL;

-- =====================================================
-- PASO 4: Actualizar usuario admin a superadmin
-- =====================================================

UPDATE Usuarios 
SET 
    Username = 'superadmin',
    Password = '1234',
    NombreCompleto = 'Super Administrador',
    Email = 'superadmin@busops.com',
    Rol = 'SuperAdministrador',
    EmpresaId = NULL
WHERE Id = 1;

-- =====================================================
-- PASO 5: Agregar columna EmpresaId a todas las tablas
-- =====================================================

-- Autobuses
ALTER TABLE Autobuses 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER Kilometraje,
ADD INDEX idx_autobuses_empresaid (EmpresaId);

-- Clientes
ALTER TABLE Clientes 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER Contacto,
ADD INDEX idx_clientes_empresaid (EmpresaId);

-- Conductores
ALTER TABLE Conductores 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER PuedeTrabajarFestivos,
ADD INDEX idx_conductores_empresaid (EmpresaId);

-- Facturas
ALTER TABLE Facturas 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER FormaPago,
ADD INDEX idx_facturas_empresaid (EmpresaId);

-- Gastos
ALTER TABLE Gastos 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER AutobusId,
ADD INDEX idx_gastos_empresaid (EmpresaId);

-- MantenimientosAutobus
ALTER TABLE MantenimientosAutobus 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER Estado,
ADD INDEX idx_mantenimientos_empresaid (EmpresaId);

-- Presupuestos
ALTER TABLE Presupuestos 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER FacturaId,
ADD INDEX idx_presupuestos_empresaid (EmpresaId);

-- Proveedores
ALTER TABLE Proveedores 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER DiasPago,
ADD INDEX idx_proveedores_empresaid (EmpresaId);

-- Rutas
ALTER TABLE Rutas 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER Activa,
ADD INDEX idx_rutas_empresaid (EmpresaId);

-- Viajes
ALTER TABLE Viajes 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER RutaId,
ADD INDEX idx_viajes_empresaid (EmpresaId);

-- Reservas
ALTER TABLE Reservas 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER PasajeroId,
ADD INDEX idx_reservas_empresaid (EmpresaId);

-- Pasajeros
ALTER TABLE Pasajeros 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER FechaNacimiento,
ADD INDEX idx_pasajeros_empresaid (EmpresaId);

-- Documentos
ALTER TABLE Documentos 
ADD COLUMN EmpresaId INT NOT NULL DEFAULT 1 AFTER ClienteId,
ADD INDEX idx_documentos_empresaid (EmpresaId);

-- =====================================================
-- PASO 6: Agregar Foreign Keys
-- =====================================================

-- Foreign key de Usuarios a Empresas
ALTER TABLE Usuarios
ADD CONSTRAINT fk_usuarios_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

-- Foreign key de Empresa a ConfiguracionEmpresa
ALTER TABLE Empresas
ADD CONSTRAINT fk_empresas_configuracion
FOREIGN KEY (ConfiguracionEmpresaId) REFERENCES ConfiguracionEmpresa(Id)
ON DELETE CASCADE;

-- Foreign keys de todas las entidades a Empresas
ALTER TABLE Autobuses
ADD CONSTRAINT fk_autobuses_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Clientes
ADD CONSTRAINT fk_clientes_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Conductores
ADD CONSTRAINT fk_conductores_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Facturas
ADD CONSTRAINT fk_facturas_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Gastos
ADD CONSTRAINT fk_gastos_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE MantenimientosAutobus
ADD CONSTRAINT fk_mantenimientos_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Presupuestos
ADD CONSTRAINT fk_presupuestos_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Proveedores
ADD CONSTRAINT fk_proveedores_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Rutas
ADD CONSTRAINT fk_rutas_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Viajes
ADD CONSTRAINT fk_viajes_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Reservas
ADD CONSTRAINT fk_reservas_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Pasajeros
ADD CONSTRAINT fk_pasajeros_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

ALTER TABLE Documentos
ADD CONSTRAINT fk_documentos_empresa
FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
ON DELETE RESTRICT;

-- =====================================================
-- FIN DEL SCRIPT
-- =====================================================

-- Para verificar la migración, ejecuta:
-- SELECT * FROM Empresas;
-- SELECT Id, Username, Rol, EmpresaId FROM Usuarios;
-- SHOW COLUMNS FROM Autobuses LIKE 'EmpresaId';

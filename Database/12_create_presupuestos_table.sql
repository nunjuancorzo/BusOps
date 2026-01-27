-- Crear tabla Presupuestos
CREATE TABLE IF NOT EXISTS Presupuestos (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    NumeroPresupuesto VARCHAR(50) NOT NULL UNIQUE,
    FechaEmision DATETIME NOT NULL,
    FechaValidez DATETIME,
    ClienteId INT NOT NULL,
    BaseImponible DECIMAL(10,2) NOT NULL DEFAULT 0,
    PorcentajeIVA DECIMAL(5,2) NOT NULL DEFAULT 21.00,
    ImporteIVA DECIMAL(10,2) NOT NULL DEFAULT 0,
    CargosAdicionales DECIMAL(10,2) NOT NULL DEFAULT 0,
    PorcentajeRetencion DECIMAL(5,2) NOT NULL DEFAULT 0,
    ImporteRetencion DECIMAL(10,2) NOT NULL DEFAULT 0,
    Total DECIMAL(10,2) NOT NULL DEFAULT 0,
    Estado INT NOT NULL DEFAULT 0,
    Concepto TEXT,
    ImporteConcepto DECIMAL(10,2) NOT NULL DEFAULT 0,
    ConceptoCargos VARCHAR(500),
    Observaciones TEXT,
    FacturaId INT NULL,
    FOREIGN KEY (ClienteId) REFERENCES Clientes(Id) ON DELETE RESTRICT,
    FOREIGN KEY (FacturaId) REFERENCES Facturas(Id) ON DELETE SET NULL,
    INDEX idx_numero_presupuesto (NumeroPresupuesto),
    INDEX idx_cliente (ClienteId),
    INDEX idx_estado (Estado),
    INDEX idx_fecha_emision (FechaEmision)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear tabla LineasPresupuesto
CREATE TABLE IF NOT EXISTS LineasPresupuesto (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    PresupuestoId INT NOT NULL,
    Descripcion VARCHAR(500) NOT NULL,
    Cantidad INT NOT NULL DEFAULT 1,
    PrecioUnitario DECIMAL(10,2) NOT NULL DEFAULT 0,
    Subtotal DECIMAL(10,2) NOT NULL DEFAULT 0,
    Tipo INT NOT NULL DEFAULT 0,
    ViajeId INT NULL,
    FOREIGN KEY (PresupuestoId) REFERENCES Presupuestos(Id) ON DELETE CASCADE,
    FOREIGN KEY (ViajeId) REFERENCES Viajes(Id) ON DELETE SET NULL,
    INDEX idx_presupuesto (PresupuestoId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

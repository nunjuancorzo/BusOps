-- Agregar nuevos campos financieros a Proveedores
ALTER TABLE Proveedores 
ADD COLUMN CuentaBancaria VARCHAR(50) NULL,
ADD COLUMN FormaPago VARCHAR(100) NULL,
ADD COLUMN LimiteCredito DECIMAL(18,2) NULL,
ADD COLUMN DiasPago INT NULL;

-- Agregar relación de Documentos con Proveedores
ALTER TABLE Documentos
ADD COLUMN ProveedorId INT NULL,
ADD FOREIGN KEY (ProveedorId) REFERENCES Proveedores(Id) ON DELETE CASCADE;

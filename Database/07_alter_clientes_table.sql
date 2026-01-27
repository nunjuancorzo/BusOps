-- Agregar nuevos campos financieros a Clientes
ALTER TABLE Clientes 
ADD COLUMN CuentaBancaria VARCHAR(50) NULL,
ADD COLUMN FormaPago VARCHAR(100) NULL,
ADD COLUMN LimiteCredito DECIMAL(18,2) NULL,
ADD COLUMN DiasPago INT NULL,
ADD COLUMN Contacto VARCHAR(255) NULL;

-- Agregar relación de Documentos con Clientes
ALTER TABLE Documentos
ADD COLUMN ClienteId INT NULL,
ADD FOREIGN KEY (ClienteId) REFERENCES Clientes(Id) ON DELETE CASCADE;

-- Agregar nuevos campos a ConfiguracionEmpresa
ALTER TABLE ConfiguracionEmpresa 
ADD COLUMN CuentaBancaria VARCHAR(50) NULL,
ADD COLUMN FormaPago VARCHAR(100) NULL,
ADD COLUMN LimiteCredito DECIMAL(18,2) NULL,
ADD COLUMN DiasPago INT NULL,
ADD COLUMN Contacto VARCHAR(255) NULL;

-- Agregar relación de Documentos con ConfiguracionEmpresa
ALTER TABLE Documentos
ADD COLUMN ConfiguracionEmpresaId INT NULL,
ADD FOREIGN KEY (ConfiguracionEmpresaId) REFERENCES ConfiguracionEmpresa(Id) ON DELETE CASCADE;

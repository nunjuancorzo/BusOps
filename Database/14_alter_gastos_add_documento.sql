-- Añadir campos de documento a la tabla Gastos
ALTER TABLE Gastos 
ADD COLUMN DocumentoNombre VARCHAR(255) NULL,
ADD COLUMN DocumentoContenido LONGBLOB NULL,
ADD COLUMN DocumentoTipo VARCHAR(100) NULL;

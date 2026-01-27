-- ============================================
-- Script: 06_create_documentos_table.sql
-- Descripción: Creación de tabla de documentos para conductores y autobuses
-- ============================================

-- Crear tabla de documentos
CREATE TABLE IF NOT EXISTS Documentos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    NombreArchivo VARCHAR(255) NOT NULL,
    TipoDocumento VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(500),
    RutaArchivo VARCHAR(500) NOT NULL,
    FechaSubida DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaVencimiento DATETIME,
    ConductorId INT,
    AutobusId INT,
    
    CONSTRAINT FK_Documentos_Conductores FOREIGN KEY (ConductorId) 
        REFERENCES Conductores(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Documentos_Autobuses FOREIGN KEY (AutobusId) 
        REFERENCES Autobuses(Id) ON DELETE CASCADE,
    
    -- Asegurar que el documento esté relacionado con conductor O autobús, no ambos
    CONSTRAINT CHK_Documentos_Relacion 
        CHECK ((ConductorId IS NOT NULL AND AutobusId IS NULL) OR 
               (ConductorId IS NULL AND AutobusId IS NOT NULL))
);

-- Crear índices para mejorar el rendimiento
CREATE INDEX idx_documentos_conductor ON Documentos(ConductorId);
CREATE INDEX idx_documentos_autobus ON Documentos(AutobusId);
CREATE INDEX idx_documentos_tipo ON Documentos(TipoDocumento);

-- Comentarios sobre la estructura:
-- - Id: Identificador único autoincremental
-- - NombreArchivo: Nombre original del archivo
-- - TipoDocumento: Tipo de documento (Licencia, Seguro, Ficha Técnica, Contrato, Otro)
-- - Descripcion: Descripción opcional del documento
-- - RutaArchivo: Ruta donde se almacena el archivo en el servidor
-- - FechaSubida: Fecha y hora de carga del documento
-- - FechaVencimiento: Fecha de vencimiento del documento (opcional)
-- - ConductorId: Referencia al conductor (nullable)
-- - AutobusId: Referencia al autobús (nullable)
-- - El constraint CHK_Documentos_Relacion asegura que cada documento pertenezca a conductor O autobús, no ambos

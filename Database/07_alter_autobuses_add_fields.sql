-- Script para agregar nuevos campos a la tabla Autobuses

ALTER TABLE Autobuses
-- Identificación
ADD COLUMN TipoTarjeta VARCHAR(100),
ADD COLUMN NumeroTarjeta VARCHAR(100),
ADD COLUMN NumeroBastidor VARCHAR(100),
ADD COLUMN NumeroObra VARCHAR(100),
ADD COLUMN CodigoSAE VARCHAR(50),
ADD COLUMN Libro VARCHAR(100),

-- Dimensiones
ADD COLUMN Altura INT COMMENT 'Altura en cm',
ADD COLUMN Longitud INT COMMENT 'Longitud en decímetros',

-- Plazas (renombrar y agregar)
ADD COLUMN PlazasSentado INT DEFAULT 0,
ADD COLUMN PlazasDePie INT DEFAULT 0,
ADD COLUMN PlazasAdaptadas INT DEFAULT 0,

-- Fechas y matrículas
ADD COLUMN PrimeraMatriculacion DATE,
ADD COLUMN FechaMatriculacion DATE,

-- Garantías
ADD COLUMN FinGarantiaCarroceria DATE,
ADD COLUMN FinGarantiaChasis DATE,

-- Caducidades
ADD COLUMN CaducidadExtintores DATE,
ADD COLUMN CaducidadEscolar DATE,

-- Tacógrafo
ADD COLUMN Tacografo VARCHAR(100),
ADD COLUMN DescargaTacografo DATE,
ADD COLUMN PeriodoDescargaTacografo VARCHAR(50),

-- ITV
ADD COLUMN UltimaRevisionITV DATE,
ADD COLUMN ProximaRevisionITV DATE;

-- Actualizar CapacidadPasajeros existentes para reflejar PlazasSentado
UPDATE Autobuses 
SET PlazasSentado = CapacidadPasajeros 
WHERE PlazasSentado = 0;

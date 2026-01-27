-- Añadir campos de configuración para serie de presupuestos
ALTER TABLE ConfiguracionEmpresa 
ADD COLUMN SeriePresupuesto VARCHAR(10) NOT NULL DEFAULT 'PRES' AFTER IncluirAñoEnSerie,
ADD COLUMN NumeroPresupuestoActual INT NOT NULL DEFAULT 1 AFTER SeriePresupuesto,
ADD COLUMN LongitudNumeroPresupuesto INT NOT NULL DEFAULT 4 AFTER NumeroPresupuestoActual;

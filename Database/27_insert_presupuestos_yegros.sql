-- =====================================================
-- Script: Insertar Presupuesto de Autocares Yegros
-- Versión: 27
-- Fecha: 19/02/2026
-- Descripción: Inserta el presupuesto desde el CSV
--              de carga para Autocares Yegros (EmpresaId = 1)
-- Origen: Volcano datos/Presupuestos.csv
-- =====================================================

USE busops;

-- =====================================================
-- Obtener el ID del cliente para el presupuesto
-- =====================================================
SET @ClienteId = (SELECT Id FROM Clientes WHERE NombreEmpresa = 'ASOCIACION CULTURAL TERCERA EDAD LUIS CHAMIZO' AND EmpresaId = 1 LIMIT 1);

-- =====================================================
-- Insertar Presupuesto
-- Campos CSV: Código;Estado;Atendido por;Conocido por?;Forma de contacto;Fecha alta;Cliente;Teléfono;Mail;
--             Atención;Referencia;Total;Anotaciones;Fecha de envío
-- =====================================================

-- Presupuesto 1: HOGAR PALAZUELO
-- Estado: V (interpretado como Vendido/Aprobado = Estado 2)
-- Estado 0 = Borrador, 1 = Enviado, 2 = Aprobado, 3 = Rechazado, 4 = Caducado, 5 = Convertido a Factura
INSERT INTO Presupuestos (
    NumeroPresupuesto, 
    FechaEmision, 
    FechaValidez, 
    ClienteId, 
    BaseImponible, 
    PorcentajeIVA, 
    ImporteIVA, 
    CargosAdicionales,
    PorcentajeRetencion,
    ImporteRetencion,
    Total, 
    Estado, 
    Concepto,
    ImporteConcepto,
    Observaciones,
    EmpresaId
)
VALUES (
    'PRES-2026-001',
    STR_TO_DATE('29/01/2026', '%d/%m/%Y'),
    DATE_ADD(STR_TO_DATE('29/01/2026', '%d/%m/%Y'), INTERVAL 30 DAY), -- Validez de 30 días
    @ClienteId,
    8801.65, -- Base imponible calculada: 10650 / 1.21
    21.00,
    1848.35, -- IVA: 8801.65 * 0.21
    0.00,
    0.00,
    0.00,
    10650.00,
    2, -- Estado 2 = Aprobado (V = Vendido)
    'HOGAR PALAZUELO',
    10650.00,
    'Atendido por: PEDRO. Referencia: HOGAR PALAZUELO',
    1
);

-- Obtener el ID del presupuesto recién insertado
SET @PresupuestoId = LAST_INSERT_ID();

-- =====================================================
-- Insertar Línea del Presupuesto
-- =====================================================
-- Como no tenemos el detalle de líneas, insertamos una línea general
INSERT INTO LineasPresupuesto (
    PresupuestoId,
    Descripcion,
    Cantidad,
    PrecioUnitario,
    Subtotal,
    Tipo,
    ViajeId
)
VALUES (
    @PresupuestoId,
    'Servicio de transporte - HOGAR PALAZUELO',
    1,
    8801.65,
    8801.65,
    0, -- Tipo 0 = Servicio general
    NULL
);

-- =====================================================
-- RESUMEN
-- =====================================================
SELECT '=============================================' AS '';
SELECT 'INSERCIÓN DE PRESUPUESTOS COMPLETADA' AS '';
SELECT '=============================================' AS '';
SELECT CONCAT('Total de presupuestos insertados: ', COUNT(*)) AS '' FROM Presupuestos WHERE EmpresaId = 1;
SELECT CONCAT('Total de líneas insertadas: ', COUNT(*)) AS '' FROM LineasPresupuesto WHERE PresupuestoId IN (SELECT Id FROM Presupuestos WHERE EmpresaId = 1);
SELECT '=============================================' AS '';

-- Mostrar información del presupuesto insertado
SELECT 'Detalle del presupuesto insertado:' AS '';
SELECT 
    p.NumeroPresupuesto,
    p.FechaEmision,
    c.NombreEmpresa AS Cliente,
    p.Total,
    CASE p.Estado
        WHEN 0 THEN 'Borrador'
        WHEN 1 THEN 'Enviado'
        WHEN 2 THEN 'Aprobado'
        WHEN 3 THEN 'Rechazado'
        WHEN 4 THEN 'Caducado'
        WHEN 5 THEN 'Convertido a Factura'
        ELSE 'Desconocido'
    END AS Estado,
    p.Concepto
FROM Presupuestos p
INNER JOIN Clientes c ON p.ClienteId = c.Id
WHERE p.EmpresaId = 1;

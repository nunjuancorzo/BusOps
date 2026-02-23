-- =====================================================
-- Script: Insertar Facturas de Autocares Yegros
-- Versión: 28
-- Fecha: 19/02/2026
-- Descripción: Inserta todas las facturas desde el Excel
--              de carga para Autocares Yegros (EmpresaId = 1)
-- Origen: Volcano datos/Facturas_2026_1r trimestre.xlsx
-- =====================================================

USE busops;

-- =====================================================
-- Insertar Facturas del 1er Trimestre 2026
-- Total: 24 facturas
-- =====================================================

-- Factura 1: AYE2026A01-0001 - KAOUTAR NAIMI NIA
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = '55617099V' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0001', '2026-01-13', '2026-01-13', @ClienteId,
    4545.45, 10.00, 454.55, 5000.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId1 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId1, 'AGENCIAS DE VIAJES', 1, 4545.45, 4545.45, 0);

-- Factura 2: AYE2026A01-0002 - TRANSPORTE CHAPIN SL
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'B28577971' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0002', '2026-01-13', '2026-01-13', @ClienteId,
    2500.00, 10.00, 250.00, 2750.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId2 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId2, 'EMPRESAS', 1, 2500.00, 2500.00, 0);

-- Factura 3: AYE2026A01-0003 - I.E.S JOSE MANZANO
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'S0600267-I' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0003', '2026-01-13', '2026-01-13', @ClienteId,
    454.55, 10.00, 45.45, 500.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId3 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId3, 'COLEGIOS', 1, 454.55, 454.55, 0);

-- Factura 4: AYE2026A01-0004 - I.E.S PUERTA LA SERENA (con exento)
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'S-0600040-J' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0004', '2026-01-16', '2026-01-16', @ClienteId,
    2272.73, 10.00, 227.27, 3000.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId4 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId4, 'COLEGIOS', 1, 2272.73, 2272.73, 0);

-- Factura 5: AYE2026A01-0005 - FATI TRAVEL SL
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'J51041911' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0005', '2026-01-19', '2026-01-19', @ClienteId,
    3636.36, 10.00, 363.64, 4000.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId5 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId5, 'AGENCIAS DE VIAJES', 1, 3636.36, 3636.36, 0);

-- Factura 6: AYE2026A01-0006 - FATI TRAVEL SL
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'J51041911' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0006', '2026-01-19', '2026-01-19', @ClienteId,
    4090.91, 10.00, 409.09, 4500.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId6 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId6, 'AGENCIAS DE VIAJES', 1, 4090.91, 4090.91, 0);

-- Factura 7: AYE2026A01-0007 - I.E.S LA MESTA
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'P-0600014-E' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0007', '2026-01-29', '2026-01-29', @ClienteId,
    318.18, 10.00, 31.82, 350.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId7 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId7, 'COLEGIOS', 1, 318.18, 318.18, 0);

-- Factura 8: AYE2026A01-0008 - C.D. SANTA AMALIA
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'G06132013' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0008', '2026-01-29', '2026-01-29', @ClienteId,
    400.00, 10.00, 40.00, 440.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId8 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId8, 'EMPRESAS', 1, 400.00, 400.00, 0);

-- Factura 9: AYE2026A01-0009 - C.D. SANTA AMALIA
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'G06132013' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0009', '2026-01-29', '2026-01-29', @ClienteId,
    350.00, 10.00, 35.00, 385.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId9 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId9, 'EMPRESAS', 1, 350.00, 350.00, 0);

-- Factura 10: AYE2026A01-0010 - FEDERACION EXTREMEÑA DE BALONCESTO
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'G10056406' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0010', '2026-01-29', '2026-01-29', @ClienteId,
    630.00, 10.00, 63.00, 693.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId10 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId10, 'EMPRESAS', 1, 630.00, 630.00, 0);

-- Factura 11: AYE2026A01-0011 - ASOCIACION CLUB DEPORTIVA METELINENSE
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'G06238752' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A01-0011', '2026-01-29', '2026-01-29', @ClienteId,
    1090.91, 10.00, 109.09, 1200.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId11 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId11, 'GRUPOS DEPORTIVOS', 1, 1090.91, 1090.91, 0);

-- Factura 12: AYE2026A02-0001 - ETRANSA
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'G-05287479' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0001', '2026-02-02', '2026-02-02', @ClienteId,
    4909.09, 10.00, 490.91, 5400.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId12 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId12, 'ASOCIACIONES', 1, 4909.09, 4909.09, 0);

-- Factura 13: AYE2026A02-0002 - TRANSPORTE CHAPIN SL
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'B28577971' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0002', '2026-02-05', '2026-02-05', @ClienteId,
    5000.00, 10.00, 500.00, 5500.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId13 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId13, 'EMPRESAS', 1, 5000.00, 5000.00, 0);

-- Factura 14: AYE2026A02-0003 - VIAJES FISTERRA SLU
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'B36050656' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0003', '2026-02-09', '2026-02-09', @ClienteId,
    3454.55, 10.00, 345.45, 3800.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId14 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId14, 'EMPRESAS', 1, 3454.55, 3454.55, 0);

-- Factura 15: AYE2026A02-0004 - SEPAD
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'S0611001-I' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0004', '2026-02-10', '2026-02-10', @ClienteId,
    6448.00, 10.00, 644.80, 7092.80,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId15 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId15, 'EMPRESAS', 1, 6448.00, 6448.00, 0);

-- Factura 16: AYE2026A02-0005 - SEPAD
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'S0611001-I' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0005', '2026-02-10', '2026-02-10', @ClienteId,
    6200.00, 10.00, 620.00, 6820.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId16 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId16, 'EMPRESAS', 1, 6200.00, 6200.00, 0);

-- Factura 17: AYE2026A02-0006 - SEPAD
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'S0611001-I' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0006', '2026-02-10', '2026-02-10', @ClienteId,
    6045.00, 10.00, 604.50, 6649.50,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId17 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId17, 'EMPRESAS', 1, 6045.00, 6045.00, 0);

-- Factura 18: AYE2026A02-0007 - ENTE PUBLICO
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'S0611002-I' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0007', '2026-02-10', '2026-02-10', @ClienteId,
    4691.78, 10.00, 469.18, 5160.96,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId18 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId18, 'COLEGIOS', 1, 4691.78, 4691.78, 0);

-- Factura 19: AYE2026A02-0008 - ENTE PUBLICO
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'S0611002-I' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0008', '2026-02-10', '2026-02-10', @ClienteId,
    5352.37, 10.00, 535.24, 5887.61,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId19 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId19, 'COLEGIOS', 1, 5352.37, 5352.37, 0);

-- Factura 20: AYE2026A02-0009 - ENTE PUBLICO
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'S0611002-I' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0009', '2026-02-10', '2026-02-10', @ClienteId,
    4747.64, 10.00, 474.76, 5222.40,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId20 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId20, 'COLEGIOS', 1, 4747.64, 4747.64, 0);

-- Factura 21: AYE2026A02-0010 - ENTE PUBLICO
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'S0611002-I' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0010', '2026-02-10', '2026-02-10', @ClienteId,
    4748.15, 10.00, 474.81, 5222.96,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId21 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId21, 'COLEGIOS', 1, 4748.15, 4748.15, 0);

-- Factura 22: AYE2026A02-0011 - SOCIEDAD COOPERATIVA RIO BURDALO
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'F06010912' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0011', '2026-02-17', '2026-02-17', @ClienteId,
    450.00, 10.00, 45.00, 495.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId22 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId22, 'EMPRESAS', 1, 450.00, 450.00, 0);

-- Factura 23: AYE2026A02-0012 - SOCIEDAD COOPERATIVA AMALIA DE SAJONIA
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'F06009898' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0012', '2026-02-17', '2026-02-17', @ClienteId,
    450.00, 10.00, 45.00, 495.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId23 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId23, 'EMPRESAS', 1, 450.00, 450.00, 0);

-- Factura 24: AYE2026A02-0013 - VIAJES FISTERRA SLU (con exento)
SET @ClienteId = (SELECT Id FROM Clientes WHERE NIF = 'B36050656' AND EmpresaId = 1 LIMIT 1);
INSERT INTO Facturas (
    NumeroFactura, FechaEmision, FechaVencimiento, ClienteId,
    BaseImponible, PorcentajeIVA, ImporteIVA, Total,
    Estado, FormaPago, EmpresaId
) VALUES (
    'AYE2026A02-0013', '2026-02-17', '2026-02-17', @ClienteId,
    909.09, 10.00, 90.91, 3600.00,
    'Emitida', 'Transferencia', 1
);
SET @FacturaId24 = LAST_INSERT_ID();
INSERT INTO LineasFactura (FacturaId, Descripcion, Cantidad, PrecioUnitario, Subtotal, Tipo)
VALUES (@FacturaId24, 'EMPRESAS', 1, 909.09, 909.09, 0);

-- =====================================================
-- RESUMEN
-- =====================================================
SELECT '=============================================' AS '';
SELECT 'INSERCIÓN DE FACTURAS COMPLETADA' AS '';
SELECT '=============================================' AS '';
SELECT CONCAT('Total de facturas insertadas: ', COUNT(*)) AS '' FROM Facturas WHERE EmpresaId = 1;
SELECT CONCAT('Total de líneas insertadas: ', COUNT(*)) AS '' FROM LineasFactura WHERE FacturaId IN (SELECT Id FROM Facturas WHERE EmpresaId = 1);
SELECT CONCAT('Suma total facturado: ', FORMAT(SUM(Total), 2), ' €') AS '' FROM Facturas WHERE EmpresaId = 1;
SELECT '=============================================' AS '';

-- =====================================================
-- Script: Insertar Autobuses de Autocares Yegros
-- Versión: 29
-- Fecha: 19/02/2026
-- Descripción: Inserta todos los autobuses desde el CSV
--              de carga para Autocares Yegros (EmpresaId = 1)
-- Origen: Volcano datos/Vehiculos.csv
-- =====================================================

USE busops;

-- =====================================================
-- Obtener ID del conductor SIN ASIGNAR
-- =====================================================
SET @ConductorSinAsignar = (SELECT Id FROM Conductores WHERE DNI = '99999999X' AND EmpresaId = 1 LIMIT 1);

-- =====================================================
-- Insertar Autobuses
-- Total: 12 autobuses
-- =====================================================

-- Autobus 1: 4701 FLW - VOLVO B12B TITANIUM
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor, Longitud, Altura,
    EmpresaId
) VALUES (
    '4701 FLW', 'VOLVO B12B', 'TITANIUM', 55, 2000, 0, 'Disponible',
    55, '4701YV3R8G1277A118254', 122, 39,
    1
);

-- Autobus 2: 0708 HJP - VOLVO B13 B TITANIUM
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor, Longitud, Altura,
    EmpresaId
) VALUES (
    '0708 HJP', 'VOLVO B13 B', 'TITANIUM', 55, 2000, 0, 'Disponible',
    55, 'YU3T2P526BA151613', 128, 39,
    1
);

-- Autobus 3: 0577 HJT - MERCEDS OC 500 TATA
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor, Longitud, Altura,
    EmpresaId
) VALUES (
    '0577 HJT', 'MERCEDES OC 500', 'TATA', 61, 2000, 0, 'Disponible',
    61, 'WEB63440111000084', 138, 38,
    1
);

-- Autobus 4: 8127 MGN - IVECO 450 MANYELYS
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor, Longitud, Altura,
    EmpresaId
) VALUES (
    '8127 MGN', 'IVECO 450', 'MANYELYS', 52, 2000, 0, 'Disponible',
    52, 'VNESFR21000000570', 128, 37,
    1
);

-- Autobus 5: 9313 JCY - VOLVO B11 B SC7
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor, Longitud, Altura,
    EmpresaId
) VALUES (
    '9313 JCY', 'VOLVO B11 B', 'SC7', 59, 2000, 0, 'Disponible',
    59, 'YU3T2U821FA171154', 129, 37,
    1
);

-- Autobus 6: 7933 MNX - VDL FUTURA
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, Longitud, Altura,
    EmpresaId
) VALUES (
    '7933 MNX', 'VDL', 'FUTURA', 55, 2000, 0, 'Disponible',
    55, 128, 37,
    1
);

-- Autobus 7: 5512 GST - MERCEDES FAREBUS
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor, Longitud, Altura,
    EmpresaId
) VALUES (
    '5512 GST', 'MERCEDES', 'FAREBUS', 34, 2000, 0, 'Disponible',
    34, 'WDB9702571L448818', 93, 33,
    1
);

-- Autobus 8: 6289 HJS - IVECO 170 WIN
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor, Longitud, Altura,
    EmpresaId
) VALUES (
    '6289 HJS', 'IVECO 170', 'WIN', 24, 2000, 0, 'Disponible',
    24, 'ECFC70C0005896880', 77, 24,
    1
);

-- Autobus 9: 4906 GKS - MERCEDES 515 CDI SPRINTER (MiniBus)
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor,
    EmpresaId
) VALUES (
    '4906 GKS', 'MERCEDES 515 CDI', 'SPRINTER', 17, 2000, 0, 'Disponible',
    17, 'WDB9066571S276413',
    1
);

-- Autobus 10: 0459 GKT - MERCEDES 515 CDI SPRINTER (MiniBus)
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor, PrimeraMatriculacion,
    EmpresaId
) VALUES (
    '0459 GKT', 'MERCEDES 515 CDI', 'SPRINTER', 17, 2009, 0, 'Disponible',
    17, 'WDB9066571S273794', STR_TO_DATE('04/02/2009', '%d/%m/%Y'),
    1
);

-- Autobus 11: 2714 GKV - MERCEDES SPRINTER (MiniBus)
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, ProximaRevisionITV,
    EmpresaId
) VALUES (
    '2714 GKV', 'MERCEDES', 'SPRINTER', 17, 2000, 0, 'Disponible',
    17, STR_TO_DATE('08/05/2026', '%d/%m/%Y'),
    1
);

-- Autobus 12: 1856 MHL - VDL FUTURA FMD2 139/460
INSERT INTO Autobuses (
    Matricula, Marca, Modelo, CapacidadPasajeros, AñoFabricacion, Kilometraje, Estado,
    PlazasSentado, NumeroBastidor, PrimeraMatriculacion, DescargaTacografo,
    EmpresaId
) VALUES (
    '1856 MHL', 'VDL', 'FUTURA FMD2 139/460', 61, 2017, 0, 'Disponible',
    61, 'XNL501R100D005666', STR_TO_DATE('20/09/2017', '%d/%m/%Y'), STR_TO_DATE('08/01/2027', '%d/%m/%Y'),
    1
);

-- =====================================================
-- RESUMEN
-- =====================================================
SELECT '=============================================' AS '';
SELECT 'INSERCIÓN DE AUTOBUSES COMPLETADA' AS '';
SELECT '=============================================' AS '';
SELECT CONCAT('Total de autobuses insertados: ', COUNT(*)) AS '' FROM Autobuses WHERE EmpresaId = 1;
SELECT CONCAT('Total plazas disponibles: ', SUM(CapacidadPasajeros)) AS '' FROM Autobuses WHERE EmpresaId = 1;
SELECT '=============================================' AS '';

-- Mostrar detalle de autobuses insertados
SELECT 'Detalle de autobuses insertados:' AS '';
SELECT 
    Matricula,
    Marca,
    Modelo,
    CapacidadPasajeros AS Plazas,
    Estado
FROM Autobuses 
WHERE EmpresaId = 1
ORDER BY Matricula;

-- =====================================================
-- Script: Insertar Conductores de Autocares Yegros
-- Versión: 26
-- Fecha: 19/02/2026
-- Descripción: Inserta todos los conductores desde el CSV
--              de carga para Autocares Yegros (EmpresaId = 1)
-- Origen: Volcano datos/Conductores.csv
-- =====================================================

USE busops;

-- =====================================================
-- Insertar Conductores
-- Campos CSV: Código;NIF;Caducidad DNI;Tipo;Nombre;Alias;Domicilio;Población;Provincia;Cod.Postal;Pais;Teléfono;E-mail;
--             Fecha de Nacimiento;Clase de permiso;Fecha caducidad permiso;Alta Empresa;Fecha baja empresa;Estado;
--             Fecha revisión médica;Núm. Seguridad Social;Fecha fin contrato;Fecha fin pruebas;Fecha fin CAP;
--             Fecha descarga tacógrafo;Fecha caducidad tacógrafo
-- =====================================================

-- Conductor 1: PEDRO MONTERO ANDUJAR
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'PEDRO', 'MONTERO ANDUJAR', '52353955K', '52353955K', 
    STR_TO_DATE('30/11/2028', '%d/%m/%Y'),
    '627418660', 'pedromontero1973@gmail.com', 
    STR_TO_DATE('13/02/2023', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('13/02/2023', '%d/%m/%Y'), '06-1002643127',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 2: TOMAS JESUS MONTERO ANDUJAR
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'TOMAS JESUS', 'MONTERO ANDUJAR', '33980961W', '33980961W', 
    STR_TO_DATE('26/05/2027', '%d/%m/%Y'),
    '607870022', 'autocaresyegros@gmail.com', 
    NOW(), 'Activo',
    '06-0058083971',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 3: FRANCISCO SANCHEZ GARCIA
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'FRANCISCO', 'SANCHEZ GARCIA', '53577884M', '53577884M', 
    STR_TO_DATE('17/01/2029', '%d/%m/%Y'),
    '633818060', 'agarponis.sanchez@gmail.com', 
    STR_TO_DATE('13/10/2023', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('13/10/2023', '%d/%m/%Y'), '06-1018440181',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 4: MIGUEL ANGEL RAYO ROMERO
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'MIGUEL ANGEL', 'RAYO ROMERO', '79309646B', '79309646B', 
    STR_TO_DATE('19/02/2030', '%d/%m/%Y'),
    '687441859', 'rayovillanueva@hotmail.com', 
    STR_TO_DATE('04/09/2024', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('04/09/2024', '%d/%m/%Y'), '06-1004819866',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 5: MIGUEL SANCHEZ PEREZ
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'MIGUEL', 'SANCHEZ PEREZ', '46940871X', '46940871X', 
    STR_TO_DATE('01/09/2030', '%d/%m/%Y'),
    '681322860', 'miguelsp368@gmail.com', 
    STR_TO_DATE('31/01/2025', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('31/01/2025', '%d/%m/%Y'), '08-1097908613',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 6: MIGUEL A. SANCHEZ PANIAGUA RUIZ
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'MIGUEL A.', 'SANCHEZ PANIAGUA RUIZ', '53261608W', '53261608W', 
    STR_TO_DATE('16/11/2026', '%d/%m/%Y'),
    '633459889', 'masasanchezpaniagua@gmail.com', 
    STR_TO_DATE('10/03/2024', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('10/03/2024', '%d/%m/%Y'), '06-1011248239',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 7: JOSE MANUEL SUAREZ SUAREZ
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'JOSE MANUEL', 'SUAREZ SUAREZ', '05415062B', '05415062B', 
    STR_TO_DATE('16/03/2030', '%d/%m/%Y'),
    '634639788', 'josesuarezsuarez77@gmail.com', 
    STR_TO_DATE('01/10/2025', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('01/10/2025', '%d/%m/%Y'), '06-1004633142',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 8: ANA BELEN FERNANDEZ RODRIGUEZ
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'ANA BELEN', 'FERNANDEZ RODRIGUEZ', '32817589Q', '32817589Q', 
    STR_TO_DATE('06/04/2026', '%d/%m/%Y'),
    '657137756', 'anabelenfer1972@yahoo.es', 
    STR_TO_DATE('18/09/2025', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('18/09/2025', '%d/%m/%Y'), '24-1002628073',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 9: AITOR ACEDO IGLESIAS
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'AITOR', 'ACEDO IGLESIAS', '08364439Y', '08364439Y', 
    STR_TO_DATE('07/02/2027', '%d/%m/%Y'),
    '637508119', 'aitoracedo94@gmail.com', 
    STR_TO_DATE('05/11/2025', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('05/11/2025', '%d/%m/%Y'), '06-1024787722',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 10: FRANCISCO BARRENA GALAN
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'FRANCISCO', 'BARRENA GALAN', '76249265X', '76249265X', 
    STR_TO_DATE('16/08/2027', '%d/%m/%Y'),
    '627033969', 'mnpg80@hotmail.com', 
    STR_TO_DATE('17/09/2025', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('17/09/2025', '%d/%m/%Y'), '06-0067024341',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 11: ENRIQUE MANZANO HEREDIA
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    AltaEmpresa, NumeroSeguridadSocial, 
    CaducidadDNI, RevisionMedica, CAP, DescargaTacografo, CaducidadTacografo,
    EmpresaId
)
VALUES (
    'ENRIQUE', 'MANZANO HEREDIA', '08364049F', '08364049F', 
    STR_TO_DATE('01/01/2030', '%d/%m/%Y'),
    '618146105', 'enriquemanzano1989@gmail.com', 
    STR_TO_DATE('10/10/2025', '%d/%m/%Y'), 'Activo',
    STR_TO_DATE('10/10/2025', '%d/%m/%Y'), '06-1053948451',
    NULL, NULL, NULL, NULL, NULL,
    1
);

-- Conductor 12: SIN ASIGNAR (conductor genérico)
INSERT INTO Conductores (
    Nombre, Apellidos, DNI, NumeroLicencia, FechaVencimientoLicencia, 
    Telefono, Email, FechaContratacion, Estado, 
    EmpresaId
)
VALUES (
    'SIN', 'ASIGNAR', '99999999X', '99999999X', 
    STR_TO_DATE('31/12/2099', '%d/%m/%Y'),
    '000000000', 'sinasignar@autocaresyegros.com', 
    NOW(), 'Activo',
    1
);

-- =====================================================
-- RESUMEN
-- =====================================================
SELECT '=============================================' AS '';
SELECT 'INSERCIÓN DE CONDUCTORES COMPLETADA' AS '';
SELECT '=============================================' AS '';
SELECT CONCAT('Total de conductores insertados: ', COUNT(*)) AS '' FROM Conductores WHERE EmpresaId = 1;
SELECT '=============================================' AS '';

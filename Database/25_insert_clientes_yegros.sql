-- =====================================================
-- Script: Insertar Clientes de Autocares Yegros
-- Versión: 25
-- Fecha: 19/02/2026
-- Descripción: Inserta todos los clientes desde el CSV
--              de carga para Autocares Yegros (EmpresaId = 1)
-- Origen: Volcano datos/Clientes.csv
-- =====================================================

USE busops;

-- =====================================================
-- Insertar Clientes
-- Campos CSV: Código;Nombre;NIF;Domicilio;Cod.Postal;Población;Provincia;Pais;Teléfono;Mail;Código grupo cliente;Grupo cliente
-- =====================================================

-- Cliente 1: VIAJES FISTERRA SLU
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'VIAJES FISTERRA SLU', 'B36050656', 'C/ORENSE 24 EDIFICIO PLAZA', '36960', 'SANXENXO', 'PONTEVEDRA', '619747007', 'info@viajesfisterra.com', NOW(), 1, 1);

-- Cliente 2: (Código 3) FEDERACION EXTREMEÑA DE BALONCESTO
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'FEDERACION EXTREMEÑA DE BALONCESTO', 'G10056406', 'Avda. PIERRE DE CUBERTINI,1 PABELLON MULTIUSO', '10005', 'CACERES', 'CACERES', '607087897', 'judex@fexb.es', NOW(), 1, 1);

-- Cliente 3: (Código 4) C.D. SANTA AMALIA
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'C.D. SANTA AMALIA', 'G06132013', 'Avda.DEL CANAL S/N', '06410', 'STA.AMALIA', 'BADAJOZ', '653799930', 'construccioneshermanosjardineros@hotmail.com', NOW(), 1, 1);

-- Cliente 4: (Código 5) ASOCIACION CLUB DEPORTIVA METELINENSE
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'ASOCIACION CLUB DEPORTIVA METELINENSE', 'G06238752', 'PLAZA HERNAN CORTES,27', '06411', 'MEDELLIN', 'BADAJOZ', '645664306', 'cdmetelinense@gmail.com', NOW(), 1, 1);

-- Cliente 5: (Código 6) ROSA CARMONA HUERTA
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'ROSA CARMONA HUERTA', '52960721-R', 'PLAZUELA 3-A', '06460', 'CAMPANARIO', 'BADAJOZ', '651989497', 'info@viajesalunais.com', NOW(), 1, 1);

-- Cliente 6: (Código 7) AUTOCARES BIBIANO JUANES SL
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'AUTOCARES BIBIANO JUANES SL', 'B-23593189', 'C/SANTIAGO ,4', '23220', 'VILCHES', 'JAEN', '638157819', 'info@bibianoautocares.com', NOW(), 1, 1);

-- Cliente 7: (Código 8) TRANSPORTE DE VIAJEROS LA BARRANQUERA SL
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'TRANSPORTE DE VIAJEROS LA BARRANQUERA SL', 'B06180376', 'C/ FELIX RODRIGUEZ DE LA FUENTE,25', '06460', 'CAMPANARIO', 'BADAJOZ', '650216021', 'viajeslabarranquera@hotmail.com', NOW(), 1, 1);

-- Cliente 8: (Código 9) TRANSPORTE CHAPIN SL
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'TRANSPORTE CHAPIN SL', 'B28577971', 'C/ LAGUNA 3 Y 5 P.I URTINSA', '28923', 'ALCORCON', 'MADRID', '606509235', 'santiago@grupochapin.com', NOW(), 1, 1);

-- Cliente 9: (Código 10) AUTOCARES J MUÑOZ SL
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'AUTOCARES J MUÑOZ SL', 'B06134043', 'C/ ALICANTE ,3', '06800', 'MERIDA', 'BADAJOZ', '660294343', 'info@autocaresmunoz.es', NOW(), 1, 1);

-- Cliente 10: (Código 11) AUTOCARES CORVO SANFELIX SL
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'AUTOCARES CORVO SANFELIX SL', 'B06441414', 'C/ CALVARIO 21 (P.I LAS SIREAS)', '06850', 'ARROYO SAN SERVAN', 'BADAJOZ', '653676596', 'corvo@autocarescorvo.com', NOW(), 1, 1);

-- Cliente 11: (Código 12) MONCATOUR SL
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'MONCATOUR SL', 'B06381594', 'C /ARROYAXO 10 LOCAL 4', '06400', 'DON BENITO', 'BADAJOZ', '627418659', 'moncatour@monteroautocares.es', NOW(), 1, 1);

-- Cliente 12: (Código 13) SERVICIO EXTREMEÑO DE PROMOCION DE LA AUTONOMIA Y ATENCION A LA DEPENDENCIA (SEPAD)
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'SERVICIO EXTREMEÑO DE PROMOCION DE LA AUTONOMIA Y ATENCION A LA DEPENDENCIA (SEPAD)', 'S0611001-I', 'Avda DE LAS AMERICAS ,4', '06800', 'MERIDA', 'BADAJOZ', '665688597', 'info@sepad.es', NOW(), 1, 1);

-- Cliente 13: (Código 14) ENTE PUBLICO EXTREMEÑO DE SERVICIOS EDUCATIVOS COMPLEMENTARIOS
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'ENTE PUBLICO EXTREMEÑO DE SERVICIOS EDUCATIVOS COMPLEMENTARIOS', 'S0611002-I', 'Avda. VALHONDO S/NEDIFICIO MERIDA III MILENIO MODULA 5- 2 PLANTA', '06800', 'MERIDA', 'BADAJOZ', '924000000', 'info@educarex.es', NOW(), 1, 1);

-- Cliente 14: (Código 15) I.E.S PUERTA LA SERENA
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'I.E.S PUERTA LA SERENA', 'S-0600040-J', 'ANTONIO NEBRIJA,8', '06700', 'VILLANUEVA DE LA SERENA', 'BADAJOZ', '924000000', 'ies.puertadelaserena@edu.juntaex.es', NOW(), 1, 1);

-- Cliente 15: (Código 16) KAOUTAR NAIMI NIA
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Agencia', 'KAOUTAR NAIMI NIA', '55617099V', 'CALLE JOSE ADRIO,3 B.IZQUIERDA', '36004', 'PONTEVEDRA', 'PONTEVEDRA', '986000000', 'info@agenciakaoutar.com', NOW(), 1, 1);

-- Cliente 16: (Código 17) I.E.S JOSE MANZANO
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'I.E.S JOSE MANZANO', 'S0600267-I', 'FUENTE LOS BARROS S/N', '06400', 'DON BENITO', 'BADAJOZ', '924000000', 'ies.josemanzano@edu.juntaex.es', NOW(), 1, 1);

-- Cliente 17: (Código 18) IGNACIO MUÑOZ MEJIAS
INSERT INTO Clientes (Tipo, Nombre, Apellidos, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Particular', 'IGNACIO', 'MUÑOZ MEJIAS', '53260245-L', 'CALLE JOAQUIN SOROLLA,33', '06700', 'VILLANUEVA DE LA SERENA', 'BADAJOZ', '651835173', 'ignaciomunoz@gmail.com', NOW(), 1, 1);

-- Cliente 18: (Código 19) I.E.S SAN JOSE
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'I.E.S SAN JOSE', 'S0600346-A', 'ANTONIO NEBRIJA,6', '06700', 'VILLANUEVA DE LA SERENA', 'BADAJOZ', '924000000', 'ies.sanjose@edu.juntaex.es', NOW(), 1, 1);

-- Cliente 19: (Código 20) COLEGIO SAGRADO CORAZON DON BENITO
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'COLEGIO SAGRADO CORAZON DON BENITO', 'B06729297', 'C/ MADRE MATILDE,2', '06400', 'DON BENITO', 'BADAJOZ', '924000000', 'info@sagradocorazon.es', NOW(), 1, 1);

-- Cliente 20: (Código 21) ETRANSA
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'ETRANSA', 'G-05287479', 'CAMINO SAN MARCOS, S/N', '10300', 'NAVALMORAL DE LA MATA', 'CACERES', '644817247', 'OFICINAETRANSA@GMAIL.COM', NOW(), 1, 1);

-- Cliente 21: (Código 22) CEIP 12 OCTUBRE
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'CEIP 12 OCTUBRE', 'S0600167-A', 'CALLE SONORA', '06412', 'HERNAN CORTES', 'BADAJOZ', '924000000', 'ceip.12octubre@edu.juntaex.es', NOW(), 1, 1);

-- Cliente 22: (Código 23) FATI TRAVEL SL
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Agencia', 'FATI TRAVEL SL', 'J51041911', 'LOS ROSALES', '51002', 'CEUTA', 'CEUTA', '697851976', 'IBTISSAN@fatitravel.com', NOW(), 1, 1);

-- Cliente 23: (Código 24) I.E.S LA MESTA
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'I.E.S LA MESTA', 'P-0600014-E', 'C/ ORDIZIA,1', '06410', 'SANTA AMALIA', 'BADAJOZ', '649063486', 'ies.lamesta@edu.juntaex.es', NOW(), 1, 1);

-- Cliente 24: (Código 25) ASOCIACION CULTURAL TERCERA EDAD LUIS CHAMIZO
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'ASOCIACION CULTURAL TERCERA EDAD LUIS CHAMIZO', 'G06144026', 'PLAZA DE MAYO ,5', '06717', 'PALAZUELO', 'BADAJOZ', '605689099', 'PEDROVICCAB@GMAIL.COM', NOW(), 1, 1);

-- Cliente 25: (Código 26) IES GONZALO TORRENTE BALLESTER
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'IES GONZALO TORRENTE BALLESTER', 'S1018019H', 'Ctra.MADRID-LISBOA KM 292', '10100', 'MIAJADAS', 'CACERES', '927160014', 'ies.gonzalotorrenteballester@edu.juntaex.es', NOW(), 1, 1);

-- Cliente 26: (Código 27) ANTONIO BALSERA
INSERT INTO Clientes (Tipo, Nombre, Apellidos, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Particular', 'ANTONIO', 'BALSERA', '53739123-Z', 'AAAAA', '06400', 'DON BENITO', 'BADAJOZ', '687691685', 'antoniobalsera@gmail.com', NOW(), 1, 1);

-- Cliente 27: (Código 28) DANIEL HERNANDEZ DOMINGUEZ
INSERT INTO Clientes (Tipo, Nombre, Apellidos, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Particular', 'DANIEL', 'HERNANDEZ DOMINGUEZ', '75898481E', 'AAAA', '06700', 'VILLANUEVA DE LA SERENA', 'BADAJOZ', '680518566', 'danielhernandez@gmail.com', NOW(), 1, 1);

-- Cliente 28: (Código 29) I.E.S PEDRO DE VALDIVIA
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'I.E.S PEDRO DE VALDIVIA', 'S0600087A', 'Avda.CHILE 23', '06700', 'VILLANUEVA DE LA SERENA', 'BADAJOZ', '924021600', 'ies.pedrodevaldivia@edu.juntaex.es', NOW(), 1, 1);

-- Cliente 29: (Código 30) SOCIEDAD COOPERATIVA RIO BURDALO
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'SOCIEDAD COOPERATIVA RIO BURDALO', 'F06010912', 'Ctra.DE YELBES S/N', '06410', 'SANTA AMALIA', 'BADAJOZ', '600658962', 'info@rioburdalo.com', NOW(), 1, 1);

-- Cliente 30: (Código 31) SOCIEDAD COOPERATIVA AMALIA DE SAJONIA
INSERT INTO Clientes (Tipo, NombreEmpresa, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Empresa', 'SOCIEDAD COOPERATIVA AMALIA DE SAJONIA', 'F06009898', 'Ctra.VALDEHORNIULLOS S/N', '06410', 'SANTA AMALIA', 'BADAJOZ', '678504325', 'info@amaliadesajonia.com', NOW(), 1, 1);

-- Cliente 31: (Código 32) MARTA RIVERO RUBIO
INSERT INTO Clientes (Tipo, Nombre, Apellidos, NIF, Direccion, CodigoPostal, Ciudad, Provincia, Telefono, Email, FechaRegistro, Activo, EmpresaId)
VALUES ('Particular', 'MARTA', 'RIVERO RUBIO', '00000000X', 'CALLE PRINCIPAL S/N', '06200', 'ALMENDRALEJO', 'BADAJOZ', '637820370', 'martarivero@gmail.com', NOW(), 1, 1);

-- =====================================================
-- RESUMEN
-- =====================================================
SELECT '=============================================' AS '';
SELECT 'INSERCIÓN DE CLIENTES COMPLETADA' AS '';
SELECT '=============================================' AS '';
SELECT CONCAT('Total de clientes insertados: ', COUNT(*)) AS '' FROM Clientes WHERE EmpresaId = 1;
SELECT '=============================================' AS '';

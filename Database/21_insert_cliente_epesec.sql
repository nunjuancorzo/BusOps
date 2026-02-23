-- Script para insertar cliente EPESEC con datos de facturaautocares.xml
-- Fecha: 2026-02-13
-- Descripción: Cliente de administración pública con centros administrativos para pruebas de FacturaE

-- Verificar que EmpresaId = 1 existe (ajustar si es necesario)
SET @empresaId = 1;

-- Insertar cliente EPESEC
INSERT INTO Clientes (
    EmpresaId,
    Tipo,
    NIF,
    NombreEmpresa,
    Nombre,
    Direccion,
    CodigoPostal,
    Ciudad,
    Provincia,
    Pais,
    Telefono,
    Email,
    Activo,
    TipoPersona,
    TipoResidencia,
    CodigoINE,
    FechaRegistro
) VALUES (
    @empresaId,
    1, -- TipoCliente.Empresa
    'S0611001I',
    'ENTE PÚBLICO EXTREMEÑO DE SERVICIOS EDUCATIVOS COMPLEMENTARIOS',
    'EPESEC',
    'Avda Valhondo S/N. Edificio Mérida III Milenio - Módulo 5 - 2ª Planta',
    '06800',
    'Mérida',
    'Badajoz',
    'ESP',
    '924000000',
    'epesec@extremadura.es',
    1, -- Activo
    1, -- TipoPersona.Juridica
    0, -- TipoResidencia.Residente
    'S0611001I', -- Código INE (mismo que NIF para administraciones)
    NOW()
);

-- Obtener el ID del cliente recién insertado
SET @clienteId = LAST_INSERT_ID();

-- Insertar centros administrativos
-- Centro 1: EPESEC - Órgano gestor (RoleTypeCode 02)
INSERT INTO CentrosAdministrativos (
    ClienteId,
    CodigoCentro,
    CodigoRol,
    Nombre,
    Direccion,
    CodigoPostal,
    Ciudad,
    Provincia,
    Pais
) VALUES (
    @clienteId,
    'A11003800',
    '02', -- Órgano gestor
    'EPESEC',
    'Avda Valhondo S/N. Edificio Mérida III Milenio - Módulo 5 - 2ª Planta',
    '06800',
    'Mérida',
    'Badajoz',
    'ESP'
);

-- Centro 2: EPESEC - Unidad tramitadora (RoleTypeCode 03)
INSERT INTO CentrosAdministrativos (
    ClienteId,
    CodigoCentro,
    CodigoRol,
    Nombre,
    Direccion,
    CodigoPostal,
    Ciudad,
    Provincia,
    Pais
) VALUES (
    @clienteId,
    'A11003800',
    '03', -- Unidad tramitadora
    'EPESEC',
    'Avda Valhondo S/N. Edificio Mérida III Milenio - Módulo 5 - 2ª Planta',
    '06800',
    'Mérida',
    'Badajoz',
    'ESP'
);

-- Centro 3: INTERVENCIÓN - Oficina contable (RoleTypeCode 01)
INSERT INTO CentrosAdministrativos (
    ClienteId,
    CodigoCentro,
    CodigoRol,
    Nombre,
    Direccion,
    CodigoPostal,
    Ciudad,
    Provincia,
    Pais
) VALUES (
    @clienteId,
    'A11046195',
    '01', -- Oficina contable
    'INTERVENCIÓN',
    'Avda Valhondo S/N. Edificio Mérida III Milenio - Módulo 5 - 2ª Planta',
    '06800',
    'Mérida',
    'Badajoz',
    'ESP'
);

-- Mostrar resultado
SELECT 'Cliente EPESEC creado con éxito. ID:' AS Mensaje, @clienteId AS ClienteId;
SELECT * FROM Clientes WHERE Id = @clienteId;
SELECT * FROM CentrosAdministrativos WHERE ClienteId = @clienteId;

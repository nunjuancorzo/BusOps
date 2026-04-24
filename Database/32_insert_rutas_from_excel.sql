-- =====================================================
-- Script de inserción de rutas desde Excel
-- Generado automáticamente el 2026-04-17 12:44:37
-- Archivo fuente: Rutas.xlsx
-- Total de registros: 7
-- =====================================================

-- Insertar rutas en la tabla rutas
-- EmpresaId = 1 por defecto
-- Activa = TRUE por defecto

-- Ruta 1: 7 - RUTA BA-391
INSERT INTO rutas (
    EmpresaId,
    Codigo,
    Nombre,
    Origen,
    Destino,
    Descripcion,
    CodigoCliente,
    ClienteId,
    Referencia,
    FechaInicio,
    FechaFin,
    HoraPresentacion,
    HoraSalida,
    HoraLlegada,
    DuracionEstimada,
    Plazas,
    DistanciaKm,
    Kilometros,
    Lunes,
    Martes,
    Miercoles,
    Jueves,
    Viernes,
    Sabado,
    Domingo,
    CodigoLineaRegular,
    LineaRegular,
    CodigoAgregacion,
    Agregacion,
    VehiculoMatricula,
    ConductorNombre,
    Asistente,
    CodigoTipoServicio,
    TipoServicio,
    PrecioBase,
    Activa
) VALUES (
    1, -- EmpresaId
    7, -- Codigo
    'RUTA BA-391', -- Nombre
    '', -- Origen
    '', -- Destino
    'RUTA BA-391', -- Descripcion
    14, -- CodigoCliente
    NULL, -- ClienteId (pendiente de mapeo)
    NULL, -- Referencia
    '2026-01-02 00:00:00', -- FechaInicio
    '2026-06-22 00:00:00', -- FechaFin
    '07:20', -- HoraPresentacion
    '07:30', -- HoraSalida
    '15:30', -- HoraLlegada
    '00:00:00', -- DuracionEstimada
    30, -- Plazas
    0, -- DistanciaKm
    0, -- Kilometros
    TRUE, -- Lunes
    TRUE, -- Martes
    TRUE, -- Miercoles
    TRUE, -- Jueves
    TRUE, -- Viernes
    FALSE, -- Sabado
    FALSE, -- Domingo
    NULL, -- CodigoLineaRegular
    NULL, -- LineaRegular
    NULL, -- CodigoAgregacion
    NULL, -- Agregacion
    '5512GST', -- VehiculoMatricula
    'SIN ASIGNAR', -- ConductorNombre
    NULL, -- Asistente
    'TE', -- CodigoTipoServicio
    'TRANSPORTE ESCOLAR', -- TipoServicio
    0, -- PrecioBase
    TRUE -- Activa
);

-- Ruta 2: 6 - RUTA BA-332
INSERT INTO rutas (
    EmpresaId,
    Codigo,
    Nombre,
    Origen,
    Destino,
    Descripcion,
    CodigoCliente,
    ClienteId,
    Referencia,
    FechaInicio,
    FechaFin,
    HoraPresentacion,
    HoraSalida,
    HoraLlegada,
    DuracionEstimada,
    Plazas,
    DistanciaKm,
    Kilometros,
    Lunes,
    Martes,
    Miercoles,
    Jueves,
    Viernes,
    Sabado,
    Domingo,
    CodigoLineaRegular,
    LineaRegular,
    CodigoAgregacion,
    Agregacion,
    VehiculoMatricula,
    ConductorNombre,
    Asistente,
    CodigoTipoServicio,
    TipoServicio,
    PrecioBase,
    Activa
) VALUES (
    1, -- EmpresaId
    6, -- Codigo
    'RUTA BA-332', -- Nombre
    '', -- Origen
    '', -- Destino
    'RUTA BA-332', -- Descripcion
    14, -- CodigoCliente
    NULL, -- ClienteId (pendiente de mapeo)
    NULL, -- Referencia
    '2026-01-02 00:00:00', -- FechaInicio
    '2026-06-22 00:00:00', -- FechaFin
    '00:00', -- HoraPresentacion
    '00:00', -- HoraSalida
    '00:00', -- HoraLlegada
    '00:00:00', -- DuracionEstimada
    40, -- Plazas
    0, -- DistanciaKm
    0, -- Kilometros
    TRUE, -- Lunes
    TRUE, -- Martes
    TRUE, -- Miercoles
    TRUE, -- Jueves
    TRUE, -- Viernes
    FALSE, -- Sabado
    FALSE, -- Domingo
    NULL, -- CodigoLineaRegular
    NULL, -- LineaRegular
    NULL, -- CodigoAgregacion
    NULL, -- Agregacion
    '4701 FLW', -- VehiculoMatricula
    'SIN ASIGNAR', -- ConductorNombre
    NULL, -- Asistente
    'TE', -- CodigoTipoServicio
    'TRANSPORTE ESCOLAR', -- TipoServicio
    0, -- PrecioBase
    TRUE -- Activa
);

-- Ruta 3: 5 - RUTA  BA-171
INSERT INTO rutas (
    EmpresaId,
    Codigo,
    Nombre,
    Origen,
    Destino,
    Descripcion,
    CodigoCliente,
    ClienteId,
    Referencia,
    FechaInicio,
    FechaFin,
    HoraPresentacion,
    HoraSalida,
    HoraLlegada,
    DuracionEstimada,
    Plazas,
    DistanciaKm,
    Kilometros,
    Lunes,
    Martes,
    Miercoles,
    Jueves,
    Viernes,
    Sabado,
    Domingo,
    CodigoLineaRegular,
    LineaRegular,
    CodigoAgregacion,
    Agregacion,
    VehiculoMatricula,
    ConductorNombre,
    Asistente,
    CodigoTipoServicio,
    TipoServicio,
    PrecioBase,
    Activa
) VALUES (
    1, -- EmpresaId
    5, -- Codigo
    'RUTA  BA-171', -- Nombre
    '', -- Origen
    '', -- Destino
    'RUTA  BA-171', -- Descripcion
    14, -- CodigoCliente
    NULL, -- ClienteId (pendiente de mapeo)
    NULL, -- Referencia
    '2026-01-02 00:00:00', -- FechaInicio
    '2026-06-22 00:00:00', -- FechaFin
    '07:50', -- HoraPresentacion
    '08:00', -- HoraSalida
    '15:15', -- HoraLlegada
    '00:00:00', -- DuracionEstimada
    35, -- Plazas
    0, -- DistanciaKm
    0, -- Kilometros
    TRUE, -- Lunes
    TRUE, -- Martes
    TRUE, -- Miercoles
    TRUE, -- Jueves
    TRUE, -- Viernes
    TRUE, -- Sabado
    TRUE, -- Domingo
    NULL, -- CodigoLineaRegular
    NULL, -- LineaRegular
    NULL, -- CodigoAgregacion
    NULL, -- Agregacion
    '8127 MGN', -- VehiculoMatricula
    'SIN ASIGNAR', -- ConductorNombre
    NULL, -- Asistente
    'TE', -- CodigoTipoServicio
    'TRANSPORTE ESCOLAR', -- TipoServicio
    0, -- PrecioBase
    TRUE -- Activa
);

-- Ruta 4: 4 - RUTA BA -075
INSERT INTO rutas (
    EmpresaId,
    Codigo,
    Nombre,
    Origen,
    Destino,
    Descripcion,
    CodigoCliente,
    ClienteId,
    Referencia,
    FechaInicio,
    FechaFin,
    HoraPresentacion,
    HoraSalida,
    HoraLlegada,
    DuracionEstimada,
    Plazas,
    DistanciaKm,
    Kilometros,
    Lunes,
    Martes,
    Miercoles,
    Jueves,
    Viernes,
    Sabado,
    Domingo,
    CodigoLineaRegular,
    LineaRegular,
    CodigoAgregacion,
    Agregacion,
    VehiculoMatricula,
    ConductorNombre,
    Asistente,
    CodigoTipoServicio,
    TipoServicio,
    PrecioBase,
    Activa
) VALUES (
    1, -- EmpresaId
    4, -- Codigo
    'RUTA BA -075', -- Nombre
    '', -- Origen
    '', -- Destino
    'RUTA BA -075', -- Descripcion
    14, -- CodigoCliente
    NULL, -- ClienteId (pendiente de mapeo)
    NULL, -- Referencia
    '2026-01-02 00:00:00', -- FechaInicio
    '2026-06-22 00:00:00', -- FechaFin
    '07:50', -- HoraPresentacion
    '08:00', -- HoraSalida
    '15:15', -- HoraLlegada
    '00:00:00', -- DuracionEstimada
    35, -- Plazas
    0, -- DistanciaKm
    0, -- Kilometros
    TRUE, -- Lunes
    TRUE, -- Martes
    TRUE, -- Miercoles
    TRUE, -- Jueves
    TRUE, -- Viernes
    FALSE, -- Sabado
    FALSE, -- Domingo
    NULL, -- CodigoLineaRegular
    NULL, -- LineaRegular
    NULL, -- CodigoAgregacion
    NULL, -- Agregacion
    '0577 HJT', -- VehiculoMatricula
    'TOMAS JESUS MONTERO ANDUJAR', -- ConductorNombre
    NULL, -- Asistente
    'TE', -- CodigoTipoServicio
    'TRANSPORTE ESCOLAR', -- TipoServicio
    0, -- PrecioBase
    TRUE -- Activa
);

-- Ruta 5: 3 - CENTRO DE DIA LOTE 7
INSERT INTO rutas (
    EmpresaId,
    Codigo,
    Nombre,
    Origen,
    Destino,
    Descripcion,
    CodigoCliente,
    ClienteId,
    Referencia,
    FechaInicio,
    FechaFin,
    HoraPresentacion,
    HoraSalida,
    HoraLlegada,
    DuracionEstimada,
    Plazas,
    DistanciaKm,
    Kilometros,
    Lunes,
    Martes,
    Miercoles,
    Jueves,
    Viernes,
    Sabado,
    Domingo,
    CodigoLineaRegular,
    LineaRegular,
    CodigoAgregacion,
    Agregacion,
    VehiculoMatricula,
    ConductorNombre,
    Asistente,
    CodigoTipoServicio,
    TipoServicio,
    PrecioBase,
    Activa
) VALUES (
    1, -- EmpresaId
    3, -- Codigo
    'CENTRO DE DIA LOTE 7', -- Nombre
    '', -- Origen
    '', -- Destino
    'CENTRO DE DIA LOTE 7', -- Descripcion
    13, -- CodigoCliente
    NULL, -- ClienteId (pendiente de mapeo)
    NULL, -- Referencia
    '2026-01-01 00:00:00', -- FechaInicio
    '2026-12-31 00:00:00', -- FechaFin
    '07:50', -- HoraPresentacion
    '08:00', -- HoraSalida
    '17:00', -- HoraLlegada
    '00:00:00', -- DuracionEstimada
    9, -- Plazas
    0, -- DistanciaKm
    0, -- Kilometros
    TRUE, -- Lunes
    TRUE, -- Martes
    TRUE, -- Miercoles
    TRUE, -- Jueves
    TRUE, -- Viernes
    FALSE, -- Sabado
    FALSE, -- Domingo
    NULL, -- CodigoLineaRegular
    NULL, -- LineaRegular
    NULL, -- CodigoAgregacion
    NULL, -- Agregacion
    '4906 GKS', -- VehiculoMatricula
    'SIN ASIGNAR', -- ConductorNombre
    NULL, -- Asistente
    'O', -- CodigoTipoServicio
    'OTROS', -- TipoServicio
    0, -- PrecioBase
    TRUE -- Activa
);

-- Ruta 6: 2 - CENTRO DE DIA LOTE 5
INSERT INTO rutas (
    EmpresaId,
    Codigo,
    Nombre,
    Origen,
    Destino,
    Descripcion,
    CodigoCliente,
    ClienteId,
    Referencia,
    FechaInicio,
    FechaFin,
    HoraPresentacion,
    HoraSalida,
    HoraLlegada,
    DuracionEstimada,
    Plazas,
    DistanciaKm,
    Kilometros,
    Lunes,
    Martes,
    Miercoles,
    Jueves,
    Viernes,
    Sabado,
    Domingo,
    CodigoLineaRegular,
    LineaRegular,
    CodigoAgregacion,
    Agregacion,
    VehiculoMatricula,
    ConductorNombre,
    Asistente,
    CodigoTipoServicio,
    TipoServicio,
    PrecioBase,
    Activa
) VALUES (
    1, -- EmpresaId
    2, -- Codigo
    'CENTRO DE DIA LOTE 5', -- Nombre
    '', -- Origen
    '', -- Destino
    'CENTRO DE DIA LOTE 5', -- Descripcion
    13, -- CodigoCliente
    NULL, -- ClienteId (pendiente de mapeo)
    NULL, -- Referencia
    '2026-01-02 00:00:00', -- FechaInicio
    '2026-12-31 00:00:00', -- FechaFin
    '00:00', -- HoraPresentacion
    '00:00', -- HoraSalida
    '00:00', -- HoraLlegada
    '00:00:00', -- DuracionEstimada
    8, -- Plazas
    0, -- DistanciaKm
    50, -- Kilometros
    TRUE, -- Lunes
    TRUE, -- Martes
    TRUE, -- Miercoles
    TRUE, -- Jueves
    TRUE, -- Viernes
    FALSE, -- Sabado
    FALSE, -- Domingo
    NULL, -- CodigoLineaRegular
    NULL, -- LineaRegular
    NULL, -- CodigoAgregacion
    NULL, -- Agregacion
    '2714 GKV', -- VehiculoMatricula
    'SIN ASIGNAR', -- ConductorNombre
    NULL, -- Asistente
    'O', -- CodigoTipoServicio
    'OTROS', -- TipoServicio
    0, -- PrecioBase
    TRUE -- Activa
);

-- Ruta 7: 1 - CENTRO DE DIA LOTE 4
INSERT INTO rutas (
    EmpresaId,
    Codigo,
    Nombre,
    Origen,
    Destino,
    Descripcion,
    CodigoCliente,
    ClienteId,
    Referencia,
    FechaInicio,
    FechaFin,
    HoraPresentacion,
    HoraSalida,
    HoraLlegada,
    DuracionEstimada,
    Plazas,
    DistanciaKm,
    Kilometros,
    Lunes,
    Martes,
    Miercoles,
    Jueves,
    Viernes,
    Sabado,
    Domingo,
    CodigoLineaRegular,
    LineaRegular,
    CodigoAgregacion,
    Agregacion,
    VehiculoMatricula,
    ConductorNombre,
    Asistente,
    CodigoTipoServicio,
    TipoServicio,
    PrecioBase,
    Activa
) VALUES (
    1, -- EmpresaId
    1, -- Codigo
    'CENTRO DE DIA LOTE 4', -- Nombre
    '', -- Origen
    '', -- Destino
    'CENTRO DE DIA LOTE 4', -- Descripcion
    13, -- CodigoCliente
    NULL, -- ClienteId (pendiente de mapeo)
    NULL, -- Referencia
    '2026-01-02 00:00:00', -- FechaInicio
    '2026-12-31 00:00:00', -- FechaFin
    '07:50', -- HoraPresentacion
    '08:00', -- HoraSalida
    '17:00', -- HoraLlegada
    '00:00:00', -- DuracionEstimada
    10, -- Plazas
    0, -- DistanciaKm
    90, -- Kilometros
    TRUE, -- Lunes
    TRUE, -- Martes
    TRUE, -- Miercoles
    TRUE, -- Jueves
    TRUE, -- Viernes
    FALSE, -- Sabado
    FALSE, -- Domingo
    NULL, -- CodigoLineaRegular
    NULL, -- LineaRegular
    NULL, -- CodigoAgregacion
    NULL, -- Agregacion
    '0459 GKT', -- VehiculoMatricula
    'SIN ASIGNAR', -- ConductorNombre
    NULL, -- Asistente
    'O', -- CodigoTipoServicio
    'OTROS', -- TipoServicio
    0, -- PrecioBase
    TRUE -- Activa
);

-- =====================================================
-- Fin del script - 7 registros insertados
-- =====================================================

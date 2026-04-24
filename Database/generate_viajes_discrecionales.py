#!/usr/bin/env python3
"""
Script para generar INSERTs de viajes discrecionales desde Excel
"""
import pandas as pd
import sys

def escape_sql(val):
    """Escapa valores para SQL"""
    if pd.isna(val):
        return 'NULL'
    if isinstance(val, (int, float)) and pd.notna(val):
        if isinstance(val, float) and val.is_integer():
            return str(int(val))
        return str(val)
    if isinstance(val, bool):
        return 'TRUE' if val else 'FALSE'
    # Para strings, escapar comillas
    return f"'{str(val).replace(chr(39), chr(39)+chr(39))}'"

def time_to_sql(time_val):
    """Convierte hora a formato SQL"""
    if pd.isna(time_val):
        return 'NULL'
    if isinstance(time_val, str):
        if time_val == '00:00' or not time_val.strip():
            return 'NULL'
        return f"'{time_val}'"
    # Si es un objeto de tiempo de pandas
    try:
        return f"'{time_val.strftime('%H:%M:%S')}'"
    except:
        return 'NULL'

def date_to_sql(date_val):
    """Convierte fecha a formato SQL"""
    if pd.isna(date_val):
        return 'NULL'
    try:
        if isinstance(date_val, str):
            return f"'{date_val}'"
        return f"'{date_val.strftime('%Y-%m-%d')}'"
    except:
        return 'NULL'

try:
    # Leer Excel (archivo está en el directorio padre)
    df = pd.read_excel('../Servicios Discrecionales.xlsx')
    
    print("-- =====================================================")
    print("-- Importación de Viajes Discrecionales desde Excel")
    print(f"-- Total de registros: {len(df)}")
    print("-- =====================================================\n")
    
    # Generar INSERTs
    for idx, row in df.iterrows():
        # Preparar valores
        codigo = escape_sql(row['Código'])
        fecha_salida = date_to_sql(row['Fecha Salida'])
        hora_presentacion = time_to_sql(row['Hora Presentación'])
        hora_salida = time_to_sql(row['Hora Salida'])
        fecha_llegada = date_to_sql(row['Fecha Llegada'])
        hora_llegada = time_to_sql(row['Hora Llegada'])
        
        codigo_cliente = escape_sql(row['Código cliente'])
        nombre_cliente = escape_sql(row['Cliente'])
        plazas = escape_sql(row['Plazas'])
        descripcion = escape_sql(row['Descripción'])
        ampliacion = escape_sql(row['Ampliación'])
        
        lugar_salida = escape_sql(row['Lugar de salida'])
        poblacion_salida = escape_sql(row['Población salida'])
        coord_x_salida = escape_sql(row['Coord. X Salida'])
        coord_y_salida = escape_sql(row['Coord. Y Salida'])
        
        lugar_llegada = escape_sql(row['Lugar de llegada'])
        poblacion_llegada = escape_sql(row['Población llegada'])
        coord_x_llegada = escape_sql(row['Coord. X Llegada'])
        coord_y_llegada = escape_sql(row['Coord. Y Llegada'])
        
        itinerario = escape_sql(row['Itinerario'])
        referencia = escape_sql(row['Referencia'])
        expediente = escape_sql(row['Expediente'])
        descripcion_expediente = escape_sql(row['Descripción Expediente'])
        
        vehiculo = escape_sql(row['Vehículo'])
        matricula = escape_sql(row['Matrícula'])
        conductor = escape_sql(row['Conductor'])
        conductor2 = escape_sql(row['Conductor 2'])
        
        total = escape_sql(row['Total'])
        importe = escape_sql(row['Importe'])
        total_proveedor = escape_sql(row['Total proveedor'])
        num_factura = escape_sql(row['Núm. Factura'])
        
        hora_presentacion_cierre = time_to_sql(row['Hora presentación (cierre de servicio)'])
        hora_salida_cierre = time_to_sql(row['Hora salida (cierre de servicio)'])
        hora_llegada_cierre = time_to_sql(row['Hora llegada (cierre de servicio)'])
        
        kms_inicio = escape_sql(row['Kms. Inicio'])
        kms_fin = escape_sql(row['Kms. Fin'])
        kms_totales = escape_sql(row['Kms Totales'])
        
        grupo_clientes = escape_sql(row['Grupo de clientes'])
        ine = escape_sql(row['INE'])
        ine2 = escape_sql(row['INE.1'])
        
        tipo_vehiculo_solicitado = escape_sql(row['Tipo vehículo solicitado'])
        tipo_vehiculo_asignado = escape_sql(row['Tipo vehículo asignado'])
        
        responsable = escape_sql(row['Responsable'])
        vuelo_tren = escape_sql(row['Vuelo / tren'])
        nombre_grupo = escape_sql(row['Nombre de grupo'])
        
        codigo_tipo_servicio = escape_sql(row['Código tipo servicio'])
        servicio_tipo = escape_sql(row['Servicio tipo'])
        codigo_presupuesto = escape_sql(row['Código presupuesto'])
        
        notas_internas = escape_sql(row['Notas internas'])
        notas = escape_sql(row['Notas'])
        
        comisionista = escape_sql(row['Comisionista'])
        importe_comisionista = escape_sql(row['Importe comisionista'])
        anulado = 'TRUE' if row['Anulado'] else 'FALSE'
        
        # Generar INSERT
        print(f"""INSERT INTO ViajesDiscrecionales (
    Codigo, FechaSalida, HoraPresentacion, HoraSalida, FechaLlegada, HoraLlegada,
    CodigoCliente, NombreCliente, Plazas, Descripcion, Ampliacion,
    LugarSalida, PoblacionSalida, CoordXSalida, CoordYSalida,
    LugarLlegada, PoblacionLlegada, CoordXLlegada, CoordYLlegada,
    Itinerario, Referencia, Expediente, DescripcionExpediente,
    Vehiculo, Matricula, Conductor, Conductor2,
    TotalImporte, Importe, TotalProveedor, NumeroFactura,
    HoraPresentacionCierre, HoraSalidaCierre, HoraLlegadaCierre,
    KmsInicio, KmsFin, KmsTotales,
    GrupoClientes, INE, INE2,
    TipoVehiculoSolicitado, TipoVehiculoAsignado,
    Responsable, VueloTren, NombreGrupo,
    CodigoTipoServicio, ServicioTipo, CodigoPresupuesto,
    NotasInternas, Notas,
    Comisionista, ImporteComisionista, Anulado,
    Estado, EmpresaId
) VALUES (
    {codigo}, {fecha_salida}, {hora_presentacion}, {hora_salida}, {fecha_llegada}, {hora_llegada},
    {codigo_cliente}, {nombre_cliente}, {plazas}, {descripcion}, {ampliacion},
    {lugar_salida}, {poblacion_salida}, {coord_x_salida}, {coord_y_salida},
    {lugar_llegada}, {poblacion_llegada}, {coord_x_llegada}, {coord_y_llegada},
    {itinerario}, {referencia}, {expediente}, {descripcion_expediente},
    {vehiculo}, {matricula}, {conductor}, {conductor2},
    {total}, {importe}, {total_proveedor}, {num_factura},
    {hora_presentacion_cierre}, {hora_salida_cierre}, {hora_llegada_cierre},
    {kms_inicio}, {kms_fin}, {kms_totales},
    {grupo_clientes}, {ine}, {ine2},
    {tipo_vehiculo_solicitado}, {tipo_vehiculo_asignado},
    {responsable}, {vuelo_tren}, {nombre_grupo},
    {codigo_tipo_servicio}, {servicio_tipo}, {codigo_presupuesto},
    {notas_internas}, {notas},
    {comisionista}, {importe_comisionista}, {anulado},
    'Programado', 1
);\n""")
    
    print("\n-- Fin de la importación")
    print(f"-- Total de registros insertados: {len(df)}")
    
except Exception as e:
    print(f"ERROR: {str(e)}", file=sys.stderr)
    sys.exit(1)

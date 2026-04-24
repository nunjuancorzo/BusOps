using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

/// <summary>
/// Viaje discrecional/servicio no regular
/// </summary>
public class ViajeDiscrecional
{
    public int Id { get; set; }
    
    // Identificación
    public string Codigo { get; set; } = string.Empty;
    public string? Referencia { get; set; }
    public string? Expediente { get; set; }
    public string? DescripcionExpediente { get; set; }
    
    // Fechas y horarios
    public DateTime? FechaSalida { get; set; }
    public TimeSpan? HoraPresentacion { get; set; }
    public TimeSpan? HoraSalida { get; set; }
    public DateTime? FechaLlegada { get; set; }
    public TimeSpan? HoraLlegada { get; set; }
    
    // Horarios de cierre de servicio
    public TimeSpan? HoraPresentacionCierre { get; set; }
    public TimeSpan? HoraSalidaCierre { get; set; }
    public TimeSpan? HoraLlegadaCierre { get; set; }
    
    // Cliente
    public string? CodigoCliente { get; set; }
    public string? NombreCliente { get; set; }
    public int? ClienteId { get; set; }
    public Cliente? Cliente { get; set; }
    
    // Descripción del servicio
    public string? Descripcion { get; set; }
    public string? Ampliacion { get; set; }
    public int? Plazas { get; set; }
    
    // Lugares y coordenadas
    public string? LugarSalida { get; set; }
    public string? PoblacionSalida { get; set; }
    public double? CoordXSalida { get; set; }
    public double? CoordYSalida { get; set; }
    
    public string? LugarLlegada { get; set; }
    public string? PoblacionLlegada { get; set; }
    public double? CoordXLlegada { get; set; }
    public double? CoordYLlegada { get; set; }
    
    public string? Itinerario { get; set; }
    
    // Vehículo y conductores
    public string? Vehiculo { get; set; }
    public string? Matricula { get; set; }
    public int? AutobusId { get; set; }
    public Autobus? Autobus { get; set; }
    
    public string? Conductor { get; set; }
    public int? ConductorId { get; set; }
    public Conductor? Conductor1 { get; set; }
    
    public string? Conductor2 { get; set; }
    public int? Conductor2Id { get; set; }
    public Conductor? Conductor2Nav { get; set; }
    
    // Importes
    public decimal? TotalImporte { get; set; }
    public decimal? Importe { get; set; }
    public decimal? TotalProveedor { get; set; }
    public string? NumeroFactura { get; set; }
    
    // Kilometraje
    public int? KmsInicio { get; set; }
    public int? KmsFin { get; set; }
    public int? KmsTotales { get; set; }
    
    // Clasificación
    public string? GrupoClientes { get; set; }
    public string? INE { get; set; }
    public string? INE2 { get; set; }
    
    // Vehículo
    public string? TipoVehiculoSolicitado { get; set; }
    public string? TipoVehiculoAsignado { get; set; }
    
    // Gestión
    public string? Responsable { get; set; }
    public string? VueloTren { get; set; }
    public string? NombreGrupo { get; set; }
    
    // Tipo de servicio
    public string? CodigoTipoServicio { get; set; }
    public string? ServicioTipo { get; set; }
    
    // Presupuesto
    public string? CodigoPresupuesto { get; set; }
    
    // Notas
    public string? NotasInternas { get; set; }
    public string? Notas { get; set; }
    
    // Comisionista
    public string? Comisionista { get; set; }
    public decimal? ImporteComisionista { get; set; }
    
    // Estado
    public bool Anulado { get; set; }
    public EstadoViaje Estado { get; set; } = EstadoViaje.Programado;
    
    // Multi-tenant
    public int EmpresaId { get; set; }
    public Empresa Empresa { get; set; } = null!;
}

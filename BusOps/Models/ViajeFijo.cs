using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

/// <summary>
/// Viaje fijo basado en una ruta predefinida
/// </summary>
public class ViajeFijo
{
    public int Id { get; set; }
    
    // Identificación
    public string? Codigo { get; set; }
    public string? Referencia { get; set; }
    public string? Expediente { get; set; }
    public string? DescripcionExpediente { get; set; }
    
    // Fechas y horarios principales (mantiene compatibilidad con sistema original)
    public DateTime FechaHoraSalida { get; set; }
    public DateTime FechaHoraLlegadaEstimada { get; set; }
    public DateTime? FechaHoraLlegadaReal { get; set; }
    
    // Horarios detallados
    public TimeSpan? HoraPresentacion { get; set; }
    public TimeSpan? HoraSalida { get; set; }
    public TimeSpan? HoraLlegada { get; set; }
    
    // Horarios de cierre de servicio
    public TimeSpan? HoraPresentacionCierre { get; set; }
    public TimeSpan? HoraSalidaCierre { get; set; }
    public TimeSpan? HoraLlegadaCierre { get; set; }
    
    // Estado y capacidad
    public EstadoViaje Estado { get; set; }
    public int AsientosDisponibles { get; set; }
    public int? Plazas { get; set; }
    
    // Precios e importes
    public decimal PrecioViaje { get; set; }
    public decimal? TotalImporte { get; set; }
    public decimal? Importe { get; set; }
    public decimal? TotalProveedor { get; set; }
    public string? NumeroFactura { get; set; }
    
    // Cliente
    public string? CodigoCliente { get; set; }
    public string? NombreCliente { get; set; }
    public int? ClienteId { get; set; }
    public Cliente? Cliente { get; set; }
    
    // Descripción del servicio
    public string? Descripcion { get; set; }
    public string? Ampliacion { get; set; }
    
    // Lugares y coordenadas (complementa información de la ruta)
    public string? LugarSalida { get; set; }
    public string? PoblacionSalida { get; set; }
    public double? CoordXSalida { get; set; }
    public double? CoordYSalida { get; set; }
    
    public string? LugarLlegada { get; set; }
    public string? PoblacionLlegada { get; set; }
    public double? CoordXLlegada { get; set; }
    public double? CoordYLlegada { get; set; }
    
    public string? Itinerario { get; set; }
    
    // Kilometraje
    public int? KmsInicio { get; set; }
    public int? KmsFin { get; set; }
    public int? KmsTotales { get; set; }
    
    // Vehículo (además de la relación)
    public string? Vehiculo { get; set; }
    public string? Matricula { get; set; }
    public string? TipoVehiculoSolicitado { get; set; }
    public string? TipoVehiculoAsignado { get; set; }
    
    // Conductor 2 (además del principal)
    public string? Conductor2 { get; set; }
    public int? Conductor2Id { get; set; }
    public Conductor? Conductor2Nav { get; set; }
    
    // Gestión
    public string? Responsable { get; set; }
    public string? VueloTren { get; set; }
    public string? NombreGrupo { get; set; }
    
    // Clasificación
    public string? GrupoClientes { get; set; }
    public string? INE { get; set; }
    public string? INE2 { get; set; }
    
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
    
    // Estado adicional
    public bool Anulado { get; set; }
    
    // Relaciones (MANTIENE LA RUTA)
    public int AutobusId { get; set; }
    public Autobus Autobus { get; set; } = null!;
    
    public int ConductorId { get; set; }
    public Conductor Conductor { get; set; } = null!;
    
    public int RutaId { get; set; }
    public Ruta Ruta { get; set; } = null!;
    
    // Multi-tenant
    public int EmpresaId { get; set; }
    public Empresa Empresa { get; set; } = null!;
    
    public ICollection<Reserva> Reservas { get; set; } = new List<Reserva>();
}

public enum EstadoViaje
{
    Programado,
    [Display(Name = "En Curso")]
    EnCurso,
    Completado,
    Cancelado,
    Retrasado
}

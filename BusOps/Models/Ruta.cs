namespace BusOps.Models;

public class Ruta
{
    public int Id { get; set; }
    
    // Información básica
    public string Codigo { get; set; } = string.Empty;
    public string Nombre { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public string Origen { get; set; } = string.Empty;
    public string Destino { get; set; } = string.Empty;
    public string? Referencia { get; set; }
    
    // Vigencia
    public DateTime? FechaInicio { get; set; }
    public DateTime? FechaFin { get; set; }
    
    // Horarios
    public TimeSpan? HoraPresentacion { get; set; }
    public TimeSpan? HoraSalida { get; set; }
    public TimeSpan? HoraLlegada { get; set; }
    public TimeSpan DuracionEstimada { get; set; }
    
    // Capacidad y distancia
    public int? Plazas { get; set; }
    public double DistanciaKm { get; set; }
    public int? Kilometros { get; set; }
    
    // Días de operación
    public bool Lunes { get; set; }
    public bool Martes { get; set; }
    public bool Miercoles { get; set; }
    public bool Jueves { get; set; }
    public bool Viernes { get; set; }
    public bool Sabado { get; set; }
    public bool Domingo { get; set; }
    
    // Línea regular y agregación
    public string? CodigoLineaRegular { get; set; }
    public string? LineaRegular { get; set; }
    public string? CodigoAgregacion { get; set; }
    public string? Agregacion { get; set; }
    
    // Tipo de servicio
    public string? CodigoTipoServicio { get; set; }
    public string? TipoServicio { get; set; }
    
    // Asistente
    public string? Asistente { get; set; }
    
    // Otros
    public decimal PrecioBase { get; set; }
    public bool Activa { get; set; }
    
    // Multi-tenant
    public int EmpresaId { get; set; }
    public Empresa Empresa { get; set; } = null!;
    
    // Relaciones con Cliente
    public int? CodigoCliente { get; set; }
    public int? ClienteId { get; set; }
    public Cliente? Cliente { get; set; }
    
    // Relaciones con Vehículo
    public string? VehiculoMatricula { get; set; }
    public int? AutobusId { get; set; }
    public Autobus? Autobus { get; set; }
    
    // Relaciones con Conductor
    public string? ConductorNombre { get; set; }
    public int? ConductorId { get; set; }
    public Conductor? Conductor { get; set; }
    
    // Relaciones
    public ICollection<Parada> Paradas { get; set; } = new List<Parada>();
    public ICollection<ViajeFijo> ViajesFijos { get; set; } = new List<ViajeFijo>();
}

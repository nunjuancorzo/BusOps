namespace BusOps.Models;

public class Ruta
{
    public int Id { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Origen { get; set; } = string.Empty;
    public string Destino { get; set; } = string.Empty;
    public double DistanciaKm { get; set; }
    public TimeSpan DuracionEstimada { get; set; }
    public decimal PrecioBase { get; set; }
    public bool Activa { get; set; }
    
    // Multi-tenant
    public int EmpresaId { get; set; }
    public Empresa Empresa { get; set; } = null!;
    
    // Relaciones
    public ICollection<Parada> Paradas { get; set; } = new List<Parada>();
    public ICollection<Viaje> Viajes { get; set; } = new List<Viaje>();
}

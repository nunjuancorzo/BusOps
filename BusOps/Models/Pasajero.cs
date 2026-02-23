namespace BusOps.Models;

public class Pasajero
{
    public int Id { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Apellidos { get; set; } = string.Empty;
    public string DNI { get; set; } = string.Empty;
    public string Telefono { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public DateTime FechaNacimiento { get; set; }
    
    // Multi-tenant
    public int EmpresaId { get; set; }
    public Empresa Empresa { get; set; } = null!;
    
    // Relaciones
    public ICollection<Reserva> Reservas { get; set; } = new List<Reserva>();
}

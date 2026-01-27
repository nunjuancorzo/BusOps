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
    
    // Relaciones
    public ICollection<Reserva> Reservas { get; set; } = new List<Reserva>();
}

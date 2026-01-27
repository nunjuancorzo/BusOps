namespace BusOps.Models;

public class Parada
{
    public int Id { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Direccion { get; set; } = string.Empty;
    public string Ciudad { get; set; } = string.Empty;
    public double Latitud { get; set; }
    public double Longitud { get; set; }
    public int Orden { get; set; }
    public TimeSpan TiempoDesdeInicio { get; set; }
    
    // Relaciones
    public int RutaId { get; set; }
    public Ruta Ruta { get; set; } = null!;
}

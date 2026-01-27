using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

public class Viaje
{
    public int Id { get; set; }
    public DateTime FechaHoraSalida { get; set; }
    public DateTime FechaHoraLlegadaEstimada { get; set; }
    public DateTime? FechaHoraLlegadaReal { get; set; }
    public EstadoViaje Estado { get; set; }
    public int AsientosDisponibles { get; set; }
    public decimal PrecioViaje { get; set; }
    
    // Relaciones
    public int AutobusId { get; set; }
    public Autobus Autobus { get; set; } = null!;
    
    public int ConductorId { get; set; }
    public Conductor Conductor { get; set; } = null!;
    
    public int RutaId { get; set; }
    public Ruta Ruta { get; set; } = null!;
    
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

namespace BusOps.Models;

using System.ComponentModel.DataAnnotations;

public class MantenimientoAutobus
{
    public int Id { get; set; }
    public DateTime FechaInicio { get; set; }
    public DateTime? FechaFin { get; set; }
    public TipoMantenimiento Tipo { get; set; }
    public string Descripcion { get; set; } = string.Empty;
    public decimal Costo { get; set; }
    public string Taller { get; set; } = string.Empty;
    public int KilometrajeMantenimiento { get; set; }
    public EstadoMantenimiento Estado { get; set; }
    
    // Relaciones
    public int AutobusId { get; set; }
    public Autobus Autobus { get; set; } = null!;
}

public enum TipoMantenimiento
{
    Preventivo,
    Correctivo,
    [Display(Name = "Revisión Técnica")]
    RevisionTecnica,
    [Display(Name = "Cambio Aceite")]
    CambioAceite,
    [Display(Name = "Cambio Neumáticos")]
    CambioNeumaticos,
    [Display(Name = "Reparación")]
    Reparacion
}

public enum EstadoMantenimiento
{
    Programado,
    [Display(Name = "En Proceso")]
    EnProceso,
    Completado,
    Cancelado
}

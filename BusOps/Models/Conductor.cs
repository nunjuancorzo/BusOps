using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

public class Conductor
{
    public int Id { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Apellidos { get; set; } = string.Empty;
    public string DNI { get; set; } = string.Empty;
    public string NumeroLicencia { get; set; } = string.Empty;
    public DateTime FechaVencimientoLicencia { get; set; }
    public string Telefono { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public DateTime FechaContratacion { get; set; }
    public EstadoConductor Estado { get; set; }
    
    // Fechas de caducidad y revisiones
    public DateTime? AltaEmpresa { get; set; }
    public DateTime? BajaEmpresa { get; set; }
    public DateTime? RevisionMedica { get; set; }
    public DateTime? CaducidadTacografo { get; set; }
    public DateTime? CaducidadDNI { get; set; }
    public DateTime? Pasaporte { get; set; }
    public DateTime? DescargaTacografo { get; set; }
    public DateTime? FinalizacionContrato { get; set; }
    public DateTime? PeriodoPruebas { get; set; }
    public DateTime? CAP { get; set; }
    public DateTime? CaducidadPenales { get; set; }
    public DateTime? CertificadoExtracomunitario { get; set; }
    public DateTime? TarjetaSanitaria { get; set; }
    
    // Datos adicionales
    public string? NumeroSeguridadSocial { get; set; }
    public string? CuentaBancaria { get; set; }
    public string? Notas { get; set; }
    
    // Características
    public bool Conduce15Metros { get; set; }
    public bool DisponibilidadCircuitoInternacional { get; set; }
    public bool HablaIngles { get; set; }
    public bool PuedeTrabajarFestivos { get; set; }
    
    // Conductor ocasional
    public bool EsConductorOcasional { get; set; }
    public DateTime? FechaInicioConductorOcasional { get; set; }
    public DateTime? FechaFinConductorOcasional { get; set; }
    public TimeSpan? HoraInicioConductorOcasional { get; set; }
    public TimeSpan? HoraFinConductorOcasional { get; set; }
    
    // Relación con Autobús
    public int? AutobusId { get; set; }
    public Autobus? Autobus { get; set; }
    
    // Relaciones
    public ICollection<Viaje> Viajes { get; set; } = new List<Viaje>();
    public ICollection<Documento> Documentos { get; set; } = new List<Documento>();
}

public enum EstadoConductor
{
    Activo,
    [Display(Name = "De Vacaciones")]
    DeVacaciones,
    [Display(Name = "De Baja")]
    DeBaja,
    Inactivo
}

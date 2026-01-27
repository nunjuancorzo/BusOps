using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

public class Autobus
{
    public int Id { get; set; }
    
    // Datos básicos
    public string Matricula { get; set; } = string.Empty;
    public string Marca { get; set; } = string.Empty;
    public string Modelo { get; set; } = string.Empty;
    public int AñoFabricacion { get; set; }
    public EstadoAutobus Estado { get; set; }
    
    // Identificación
    public string? TipoTarjeta { get; set; }
    public string? NumeroTarjeta { get; set; }
    public string? NumeroBastidor { get; set; }
    public string? NumeroObra { get; set; }
    public string? CodigoSAE { get; set; }
    public string? Libro { get; set; }
    
    // Dimensiones
    public int? Altura { get; set; } // en cm
    public int? Longitud { get; set; } // en decímetros
    
    // Plazas
    public int CapacidadPasajeros { get; set; } // Total
    public int PlazasSentado { get; set; }
    public int PlazasDePie { get; set; }
    public int PlazasAdaptadas { get; set; }
    
    // Fechas y matrículas
    public DateTime? PrimeraMatriculacion { get; set; }
    public DateTime? FechaMatriculacion { get; set; }
    
    // Garantías
    public DateTime? FinGarantiaCarroceria { get; set; }
    public DateTime? FinGarantiaChasis { get; set; }
    
    // Caducidades
    public DateTime? CaducidadExtintores { get; set; }
    public DateTime? CaducidadEscolar { get; set; }
    
    // Tacógrafo
    public string? Tacografo { get; set; }
    public DateTime? DescargaTacografo { get; set; }
    public string? PeriodoDescargaTacografo { get; set; }
    
    // ITV y Revisiones
    public DateTime? UltimaRevisionITV { get; set; }
    public DateTime? ProximaRevisionITV { get; set; }
    public DateTime? FechaUltimaRevision { get; set; }
    public DateTime? ProximaRevision { get; set; }
    
    // Kilometraje
    public double Kilometraje { get; set; }
    
    // Relaciones
    public ICollection<Viaje> Viajes { get; set; } = new List<Viaje>();
    public ICollection<MantenimientoAutobus> Mantenimientos { get; set; } = new List<MantenimientoAutobus>();
    public ICollection<Documento> Documentos { get; set; } = new List<Documento>();
}

public enum EstadoAutobus
{
    Disponible,
    [Display(Name = "En Servicio")]
    EnServicio,
    [Display(Name = "En Mantenimiento")]
    EnMantenimiento,
    [Display(Name = "Fuera de Servicio")]
    FueraDeServicio
}

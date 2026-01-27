namespace BusOps.Models;

public class ConfiguracionEmpresa
{
    public int Id { get; set; }
    public string NombreEmpresa { get; set; } = string.Empty;
    public string NIF { get; set; } = string.Empty;
    public string Direccion { get; set; } = string.Empty;
    public string Ciudad { get; set; } = string.Empty;
    public string CodigoPostal { get; set; } = string.Empty;
    public string Provincia { get; set; } = string.Empty;
    public string Telefono { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? Web { get; set; }
    public string? IBAN { get; set; }
    public string? LogoRuta { get; set; }
    
    // Datos financieros
    public string? CuentaBancaria { get; set; }
    public string? FormaPago { get; set; }
    public decimal? LimiteCredito { get; set; }
    public int? DiasPago { get; set; }
    public string? Contacto { get; set; }
    
    // Configuración de facturación
    public string SerieFactura { get; set; } = "FAC";
    public int NumeroFacturaActual { get; set; } = 1;
    public int LongitudNumeroFactura { get; set; } = 4;
    public bool IncluirAñoEnSerie { get; set; } = true;
    public string SeriePresupuesto { get; set; } = "PRES";
    public int NumeroPresupuestoActual { get; set; } = 1;
    public int LongitudNumeroPresupuesto { get; set; } = 4;
    public decimal IVAPorDefecto { get; set; } = 21m;
    public int DiasVencimientoPorDefecto { get; set; } = 30;
    
    // Relaciones
    public ICollection<Documento> Documentos { get; set; } = new List<Documento>();
}

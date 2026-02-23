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
    public string Pais { get; set; } = "ESP";
    public string Telefono { get; set; } = string.Empty;
    public string? Fax { get; set; }
    public string Email { get; set; } = string.Empty;
    public string? Web { get; set; }
    public string? IBAN { get; set; }
    public string? LogoRuta { get; set; }
    
    // Datos FacturaE
    public TipoPersona TipoPersona { get; set; } = TipoPersona.Juridica;
    public TipoResidencia TipoResidencia { get; set; } = TipoResidencia.Residente;
    public string? NombreComercial { get; set; }
    public string? PersonaContacto { get; set; }
    public string? CodigoINE { get; set; }
    public string? CNAE { get; set; }
    public string? LibroRegistro { get; set; }
    public string? RegistroMercantil { get; set; }
    public string? HojaRegistro { get; set; }
    public string? FolioRegistro { get; set; }
    public string? SeccionRegistro { get; set; }
    public string? TomoRegistro { get; set; }
    public string? DatosRegistroAdicionales { get; set; }
    
    // Datos financieros
    public string? CuentaBancaria { get; set; }
    public string? FormaPago { get; set; }
    public decimal? LimiteCredito { get; set; }
    public int? DiasPago { get; set; }
    public string? Contacto { get; set; }
    
    // Configuración de facturación
    public string SerieFactura { get; set; } = "FAC";
    public string? SubserieFactura { get; set; } = "A"; // Letra o código adicional que va después del año (ej: A, B, C)
    public bool IncluirMesEnSerie { get; set; } = false; // Incluir número de mes (01-12) después de la subserie
    public int NumeroFacturaActual { get; set; } = 1;
    public int LongitudNumeroFactura { get; set; } = 4;
    public bool IncluirAñoEnSerie { get; set; } = true;
    public string SeriePresupuesto { get; set; } = "PRES";
    public int NumeroPresupuestoActual { get; set; } = 1;
    public int LongitudNumeroPresupuesto { get; set; } = 4;
    public decimal IVAPorDefecto { get; set; } = 21m;
    public int DiasVencimientoPorDefecto { get; set; } = 30;
    
    // Certificado digital para firma electrónica
    public string? CertificadoRuta { get; set; }
    public string? CertificadoPassword { get; set; }
    
    // Multi-tenant: cada empresa tiene su propia configuración
    public int? EmpresaId { get; set; }
    
    // Relación con Empresa (uno a uno)
    public Empresa? Empresa { get; set; }
    
    // Relaciones
    public ICollection<Documento> Documentos { get; set; } = new List<Documento>();
}

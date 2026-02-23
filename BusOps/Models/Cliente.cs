using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

public class Cliente
{
    public int Id { get; set; }
    public string? Nombre { get; set; }
    public string? Apellidos { get; set; }
    public string? NombreEmpresa { get; set; }
    public TipoCliente Tipo { get; set; }
    public string NIF { get; set; } = string.Empty;
    public string? Direccion { get; set; }
    public string? Ciudad { get; set; }
    public string? CodigoPostal { get; set; }
    public string? Provincia { get; set; }
    public string Pais { get; set; } = "ESP";
    public string Telefono { get; set; } = string.Empty;
    public string? Fax { get; set; }
    public string Email { get; set; } = string.Empty;
    public DateTime FechaRegistro { get; set; }
    public bool Activo { get; set; } = true;
    
    // Datos FacturaE
    public bool ClienteFacturaE { get; set; } = false;
    public TipoPersona TipoPersona { get; set; } = TipoPersona.Juridica;
    public TipoResidencia TipoResidencia { get; set; } = TipoResidencia.Residente;
    public string? PersonaContacto { get; set; }
    public string? CodigoINE { get; set; }
    
    // Datos Financieros
    public string? CuentaBancaria { get; set; }
    public string? FormaPago { get; set; }
    public decimal? LimiteCredito { get; set; }
    public int? DiasPago { get; set; }
    public string? Contacto { get; set; }
    
    // Multi-tenant
    public int EmpresaId { get; set; }
    public Empresa Empresa { get; set; } = null!;
    
    // Navegación
    public ICollection<Factura> Facturas { get; set; } = new List<Factura>();
    public ICollection<Documento> Documentos { get; set; } = new List<Documento>();
    public ICollection<CentroAdministrativo> CentrosAdministrativos { get; set; } = new List<CentroAdministrativo>();
}

public enum TipoCliente
{
    Particular,
    Empresa,
    Agencia
}

public enum TipoPersona
{
    [Display(Name = "Física")]
    Fisica,
    [Display(Name = "Jurídica")]
    Juridica
}

public enum TipoResidencia
{
    [Display(Name = "Residente")]
    Residente,
    [Display(Name = "Unión Europea")]
    UnionEuropea,
    [Display(Name = "Extranjero")]
    Extranjero
}

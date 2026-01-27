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
    public string Telefono { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public DateTime FechaRegistro { get; set; }
    public bool Activo { get; set; } = true;
    
    // Datos Financieros
    public string? CuentaBancaria { get; set; }
    public string? FormaPago { get; set; }
    public decimal? LimiteCredito { get; set; }
    public int? DiasPago { get; set; }
    public string? Contacto { get; set; }
    
    // Navegación
    public ICollection<Factura> Facturas { get; set; } = new List<Factura>();
    public ICollection<Documento> Documentos { get; set; } = new List<Documento>();
}

public enum TipoCliente
{
    Particular,
    Empresa,
    Agencia
}

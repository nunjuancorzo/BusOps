namespace BusOps.Models;

public class Proveedor
{
    public int Id { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string? NIF { get; set; }
    public string? Direccion { get; set; }
    public string? Ciudad { get; set; }
    public string? CodigoPostal { get; set; }
    public string? Telefono { get; set; }
    public string? Email { get; set; }
    public string? Contacto { get; set; }
    public bool Activo { get; set; } = true;
    public DateTime FechaRegistro { get; set; } = DateTime.Now;

    // Datos Financieros
    public string? CuentaBancaria { get; set; }
    public string? FormaPago { get; set; }
    public decimal? LimiteCredito { get; set; }
    public int? DiasPago { get; set; }

    // Relaciones
    public ICollection<Documento> Documentos { get; set; } = new List<Documento>();
}

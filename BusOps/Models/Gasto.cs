using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

public class Gasto
{
    public int Id { get; set; }
    public DateTime Fecha { get; set; }
    public TipoGasto Tipo { get; set; }
    public decimal Monto { get; set; }
    public string Descripcion { get; set; } = string.Empty;
    public string NumeroFactura { get; set; } = string.Empty;
    
    // Relación con proveedor
    public int? ProveedorId { get; set; }
    public Proveedor? Proveedor { get; set; }
    
    // Relación opcional con autobús
    public int? AutobusId { get; set; }
    public Autobus? Autobus { get; set; }
    
    // Multi-tenant
    public int EmpresaId { get; set; }
    public Empresa Empresa { get; set; } = null!;
    
    // Documento adjunto
    public string? DocumentoNombre { get; set; }
    public byte[]? DocumentoContenido { get; set; }
    public string? DocumentoTipo { get; set; } // MIME type
}

public enum TipoGasto
{
    Combustible,
    Mantenimiento,
    Seguros,
    Salarios,
    Licencias,
    Limpieza,
    Peajes,
    Multas,
    Otros
}

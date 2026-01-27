using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

public class Documento
{
    public int Id { get; set; }
    public string NombreArchivo { get; set; } = string.Empty;
    public string TipoDocumento { get; set; } = string.Empty; // "Licencia", "Seguro", "Ficha Técnica", "Contrato", "Otro"
    public string? Descripcion { get; set; }
    public string RutaArchivo { get; set; } = string.Empty;
    public DateTime FechaSubida { get; set; }
    public DateTime? FechaVencimiento { get; set; }
    
    // Relación con Conductor (nullable)
    public int? ConductorId { get; set; }
    public Conductor? Conductor { get; set; }
    
    // Relación con Autobús (nullable)
    public int? AutobusId { get; set; }
    public Autobus? Autobus { get; set; }
    
    // Relación con ConfiguracionEmpresa (nullable)
    public int? ConfiguracionEmpresaId { get; set; }
    public ConfiguracionEmpresa? ConfiguracionEmpresa { get; set; }

    public int? ProveedorId { get; set; }
    public Proveedor? Proveedor { get; set; }

    public int? ClienteId { get; set; }
    public Cliente? Cliente { get; set; }
}

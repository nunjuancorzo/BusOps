using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

public class Presupuesto
{
    public int Id { get; set; }
    public string NumeroPresupuesto { get; set; } = string.Empty;
    public DateTime FechaEmision { get; set; }
    public DateTime? FechaValidez { get; set; }
    public int ClienteId { get; set; }
    public Cliente? Cliente { get; set; }
    public decimal BaseImponible { get; set; }
    public decimal PorcentajeIVA { get; set; } = 21m;
    public decimal ImporteIVA { get; set; }
    public decimal CargosAdicionales { get; set; } = 0m;
    public decimal PorcentajeRetencion { get; set; } = 0m;
    public decimal ImporteRetencion { get; set; } = 0m;
    public decimal Total { get; set; }
    public EstadoPresupuesto Estado { get; set; }
    public string? Concepto { get; set; }
    public decimal ImporteConcepto { get; set; } = 0m;
    public string? ConceptoCargos { get; set; }
    public string? Observaciones { get; set; }
    public int? FacturaId { get; set; }
    public Factura? Factura { get; set; }
    
    // Navegación
    public ICollection<LineaPresupuesto> Lineas { get; set; } = new List<LineaPresupuesto>();
}

public class LineaPresupuesto
{
    public int Id { get; set; }
    public int PresupuestoId { get; set; }
    public Presupuesto? Presupuesto { get; set; }
    public string Descripcion { get; set; } = string.Empty;
    public int Cantidad { get; set; }
    public decimal PrecioUnitario { get; set; }
    public decimal Subtotal { get; set; }
    public TipoLineaPresupuesto Tipo { get; set; } = TipoLineaPresupuesto.Servicio;
    public int? ViajeId { get; set; }
    public Viaje? Viaje { get; set; }
}

public enum TipoLineaPresupuesto
{
    Servicio,
    CargoAdicional
}

public enum EstadoPresupuesto
{
    Borrador,
    Enviado,
    Aceptado,
    Rechazado,
    Facturado,
    Caducado
}

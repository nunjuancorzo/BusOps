using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

public class Factura
{
    public int Id { get; set; }
    public string NumeroFactura { get; set; } = string.Empty;
    public DateTime FechaEmision { get; set; }
    public DateTime? FechaVencimiento { get; set; }
    public int ClienteId { get; set; }
    public Cliente? Cliente { get; set; }
    public decimal BaseImponible { get; set; }
    public decimal PorcentajeIVA { get; set; } = 21m;
    public decimal ImporteIVA { get; set; }
    public decimal CargosAdicionales { get; set; } = 0m;
    public decimal PorcentajeRetencion { get; set; } = 0m;
    public decimal ImporteRetencion { get; set; } = 0m;
    public decimal Total { get; set; }
    public EstadoFactura Estado { get; set; }
    public string? Concepto { get; set; }
    public decimal ImporteConcepto { get; set; } = 0m;
    public string? ConceptoCargos { get; set; }
    public string? Observaciones { get; set; }
    public DateTime? FechaPago { get; set; }
    public FormaPago? FormaPago { get; set; }
    
    // Navegación
    public ICollection<LineaFactura> Lineas { get; set; } = new List<LineaFactura>();
}

public class LineaFactura
{
    public int Id { get; set; }
    public int FacturaId { get; set; }
    public Factura? Factura { get; set; }
    public string Descripcion { get; set; } = string.Empty;
    public int Cantidad { get; set; }
    public decimal PrecioUnitario { get; set; }
    public decimal Subtotal { get; set; }
    public TipoLineaFactura Tipo { get; set; } = TipoLineaFactura.Servicio;
    public int? ViajeId { get; set; }
    public Viaje? Viaje { get; set; }
}

public enum TipoLineaFactura
{
    Servicio,
    CargoAdicional
}

public enum EstadoFactura
{
    Borrador,
    Emitida,
    Enviada,
    Pagada,
    Vencida,
    Cancelada
}

public enum FormaPago
{
    Efectivo,
    Transferencia,
    [Display(Name = "Tarjeta Crédito")]
    TarjetaCredito,
    [Display(Name = "Tarjeta Débito")]
    TarjetaDebito,
    Bizum,
    [Display(Name = "Domiciliación")]
    Domiciliacion
}

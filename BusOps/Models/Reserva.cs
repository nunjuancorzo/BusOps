using System.ComponentModel.DataAnnotations;

namespace BusOps.Models;

public class Reserva
{
    public int Id { get; set; }
    public string CodigoReserva { get; set; } = string.Empty;
    public DateTime FechaReserva { get; set; }
    public int NumeroAsiento { get; set; }
    public decimal PrecioPagado { get; set; }
    public EstadoReserva Estado { get; set; }
    public TipoPago TipoPago { get; set; }
    
    // Relaciones
    public int ViajeId { get; set; }
    public Viaje Viaje { get; set; } = null!;
    
    public int PasajeroId { get; set; }
    public Pasajero Pasajero { get; set; } = null!;
}

public enum EstadoReserva
{
    Pendiente,
    Confirmada,
    Pagada,
    Cancelada,
    Utilizada
}

public enum TipoPago
{
    Efectivo,
    [Display(Name = "Tarjeta Crédito")]
    TarjetaCredito,
    [Display(Name = "Tarjeta Débito")]
    TarjetaDebito,
    Transferencia,
    PayPal
}

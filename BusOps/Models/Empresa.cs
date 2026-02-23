namespace BusOps.Models;

public class Empresa
{
    public int Id { get; set; }
    
    // Datos básicos
    public string NombreComercial { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty; // URL amigable: busops.com/mi-empresa
    
    // Estado
    public bool Activa { get; set; } = true;
    public DateTime FechaAlta { get; set; } = DateTime.Now;
    public DateTime? FechaBaja { get; set; }
    
    // Plan/Suscripción (para control de límites)
    public string PlanSuscripcion { get; set; } = "Basico"; // Basico, Profesional, Empresarial
    public int? MaxUsuarios { get; set; } = 5;
    public int? MaxAutobuses { get; set; } = 10;
    public int? MaxConductores { get; set; } = 20;
    
    // Relaciones
    public int ConfiguracionEmpresaId { get; set; }
    public ConfiguracionEmpresa ConfiguracionEmpresa { get; set; } = null!;
    
    public ICollection<Usuario> Usuarios { get; set; } = new List<Usuario>();
    public ICollection<Autobus> Autobuses { get; set; } = new List<Autobus>();
    public ICollection<Cliente> Clientes { get; set; } = new List<Cliente>();
    public ICollection<Conductor> Conductores { get; set; } = new List<Conductor>();
    public ICollection<Factura> Facturas { get; set; } = new List<Factura>();
    public ICollection<Gasto> Gastos { get; set; } = new List<Gasto>();
    public ICollection<MantenimientoAutobus> Mantenimientos { get; set; } = new List<MantenimientoAutobus>();
    public ICollection<Presupuesto> Presupuestos { get; set; } = new List<Presupuesto>();
    public ICollection<Proveedor> Proveedores { get; set; } = new List<Proveedor>();
    public ICollection<Ruta> Rutas { get; set; } = new List<Ruta>();
    public ICollection<Viaje> Viajes { get; set; } = new List<Viaje>();
    public ICollection<Reserva> Reservas { get; set; } = new List<Reserva>();
}

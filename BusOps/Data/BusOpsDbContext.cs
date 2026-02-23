using Microsoft.EntityFrameworkCore;
using BusOps.Models;

namespace BusOps.Data;

public class BusOpsDbContext : DbContext
{
    public BusOpsDbContext(DbContextOptions<BusOpsDbContext> options) : base(options)
    {
    }

    // Propiedad para multi-tenancy
    public int? CurrentEmpresaId { get; set; }
    public bool IsSuperAdmin { get; set; }

    // DbSets
    public DbSet<Empresa> Empresas { get; set; }
    public DbSet<Usuario> Usuarios { get; set; }
    public DbSet<ConfiguracionEmpresa> ConfiguracionEmpresa { get; set; }
    public DbSet<Autobus> Autobuses { get; set; }
    public DbSet<Conductor> Conductores { get; set; }
    public DbSet<Ruta> Rutas { get; set; }
    public DbSet<Parada> Paradas { get; set; }
    public DbSet<Viaje> Viajes { get; set; }
    public DbSet<Pasajero> Pasajeros { get; set; }
    public DbSet<Reserva> Reservas { get; set; }
    public DbSet<MantenimientoAutobus> MantenimientosAutobus { get; set; }
    public DbSet<Gasto> Gastos { get; set; }
    public DbSet<Proveedor> Proveedores { get; set; }
    public DbSet<Cliente> Clientes { get; set; }
    public DbSet<CentroAdministrativo> CentrosAdministrativos { get; set; }
    public DbSet<Factura> Facturas { get; set; }
    public DbSet<LineaFactura> LineasFactura { get; set; }
    public DbSet<Presupuesto> Presupuestos { get; set; }
    public DbSet<LineaPresupuesto> LineasPresupuesto { get; set; }
    public DbSet<Documento> Documentos { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // =====================================================
        // Configuración: Empresa
        // =====================================================
        modelBuilder.Entity<Empresa>(entity =>
        {
            entity.ToTable("Empresas");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.NombreComercial).IsRequired().HasMaxLength(255);
            entity.Property(e => e.Slug).IsRequired().HasMaxLength(100);
            entity.HasIndex(e => e.Slug).IsUnique();
            entity.Property(e => e.Activa).IsRequired();
            entity.Property(e => e.FechaAlta).IsRequired();
            entity.Property(e => e.PlanSuscripcion).IsRequired().HasMaxLength(50);
            
            // Relación uno a uno con ConfiguracionEmpresa
            entity.HasOne(e => e.ConfiguracionEmpresa)
                .WithOne(c => c.Empresa)
                .HasForeignKey<Empresa>(e => e.ConfiguracionEmpresaId)
                .OnDelete(DeleteBehavior.Cascade);
                
            // Relaciones uno a muchos
            entity.HasMany(e => e.Usuarios)
                .WithOne(u => u.Empresa)
                .HasForeignKey(u => u.EmpresaId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        // =====================================================
        // Configuración: Usuario
        // =====================================================
        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.ToTable("Usuarios");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Username).IsRequired().HasMaxLength(50);
            entity.Property(e => e.Password).IsRequired().HasMaxLength(255);
            entity.Property(e => e.NombreCompleto).IsRequired().HasMaxLength(255);
            entity.Property(e => e.Email).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Rol).IsRequired().HasMaxLength(50);
            entity.Property(e => e.Activo).IsRequired();
            entity.Property(e => e.FechaCreacion).IsRequired();
            
            entity.HasIndex(e => e.Username).IsUnique();
            
            // Seed del super administrador por defecto
            entity.HasData(
                new Usuario
                {
                    Id = 1,
                    Username = "superadmin",
                    Password = "1234",
                    NombreCompleto = "Super Administrador",
                    Email = "superadmin@busops.com",
                    Rol = Roles.SuperAdministrador,
                    Activo = true,
                    FechaCreacion = new DateTime(2026, 1, 1),
                    EmpresaId = null // SuperAdmin no pertenece a ninguna empresa
                }
            );
        });

        // =====================================================
        // Configuración: ConfiguracionEmpresa
        // =====================================================
        modelBuilder.Entity<ConfiguracionEmpresa>(entity =>
        {
            entity.ToTable("ConfiguracionEmpresa");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.NombreEmpresa).IsRequired().HasMaxLength(255);
            entity.Property(e => e.NIF).IsRequired().HasMaxLength(20);
            entity.Property(e => e.Direccion).IsRequired().HasMaxLength(255);
            entity.Property(e => e.Ciudad).IsRequired().HasMaxLength(100);
            entity.Property(e => e.CodigoPostal).IsRequired().HasMaxLength(10);
            entity.Property(e => e.Provincia).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Pais).HasMaxLength(3).HasDefaultValue("ESP");
            entity.Property(e => e.Telefono).IsRequired().HasMaxLength(20);
            entity.Property(e => e.Fax).HasMaxLength(20);
            entity.Property(e => e.Email).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Web).HasMaxLength(255);
            entity.Property(e => e.IBAN).HasMaxLength(34);
            entity.Property(e => e.LogoRuta).HasMaxLength(500);
            entity.Property(e => e.NombreComercial).HasMaxLength(200);
            entity.Property(e => e.PersonaContacto).HasMaxLength(200);
            entity.Property(e => e.CodigoINE).HasMaxLength(50);
            entity.Property(e => e.CNAE).HasMaxLength(20);
            entity.Property(e => e.LibroRegistro).HasMaxLength(50);
            entity.Property(e => e.RegistroMercantil).HasMaxLength(100);
            entity.Property(e => e.HojaRegistro).HasMaxLength(50);
            entity.Property(e => e.FolioRegistro).HasMaxLength(50);
            entity.Property(e => e.SeccionRegistro).HasMaxLength(50);
            entity.Property(e => e.TomoRegistro).HasMaxLength(50);
            entity.Property(e => e.TipoPersona).HasDefaultValue(TipoPersona.Juridica);
            entity.Property(e => e.TipoResidencia).HasDefaultValue(TipoResidencia.Residente);
            entity.Property(e => e.SerieFactura).IsRequired().HasMaxLength(10);
            entity.Property(e => e.IVAPorDefecto).HasColumnType("decimal(5,2)");
            
            // EmpresaId es opcional - para multi-tenancy y query filters
            entity.Property(e => e.EmpresaId).IsRequired(false);
        });

        // =====================================================
        // Configuración: Autobus
        // =====================================================
        modelBuilder.Entity<Autobus>(entity =>
        {
            entity.ToTable("Autobuses");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Matricula).IsRequired().HasMaxLength(20);
            entity.HasIndex(e => e.Matricula).IsUnique();
            entity.Property(e => e.Marca).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Modelo).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Estado).IsRequired()
                .HasConversion<string>();
            entity.HasMany(e => e.Viajes)
                .WithOne(v => v.Autobus)
                .HasForeignKey(v => v.AutobusId)
                .OnDelete(DeleteBehavior.Restrict);
            entity.HasMany(e => e.Mantenimientos)
                .WithOne(m => m.Autobus)
                .HasForeignKey(m => m.AutobusId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        // =====================================================
        // Configuración: Conductor
        // =====================================================
        modelBuilder.Entity<Conductor>(entity =>
        {
            entity.ToTable("Conductores");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Nombre).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Apellidos).IsRequired().HasMaxLength(100);
            entity.Property(e => e.DNI).IsRequired().HasMaxLength(20);
            entity.HasIndex(e => e.DNI).IsUnique();
            entity.Property(e => e.NumeroLicencia).IsRequired().HasMaxLength(50);
            entity.HasIndex(e => e.NumeroLicencia).IsUnique();
            entity.Property(e => e.Telefono).IsRequired().HasMaxLength(20);
            entity.Property(e => e.Email).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Estado).IsRequired()
                .HasConversion<string>();
            entity.HasOne(e => e.Autobus)
                .WithMany()
                .HasForeignKey(e => e.AutobusId)
                .OnDelete(DeleteBehavior.SetNull);
            entity.HasMany(e => e.Viajes)
                .WithOne(v => v.Conductor)
                .HasForeignKey(v => v.ConductorId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        // =====================================================
        // Configuración: Ruta
        // =====================================================
        modelBuilder.Entity<Ruta>(entity =>
        {
            entity.ToTable("Rutas");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Nombre).IsRequired().HasMaxLength(255);
            entity.Property(e => e.Origen).IsRequired().HasMaxLength(255);
            entity.Property(e => e.Destino).IsRequired().HasMaxLength(255);
            entity.Property(e => e.PrecioBase).HasColumnType("decimal(10,2)");
            entity.HasMany(e => e.Paradas)
                .WithOne(p => p.Ruta)
                .HasForeignKey(p => p.RutaId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasMany(e => e.Viajes)
                .WithOne(v => v.Ruta)
                .HasForeignKey(v => v.RutaId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        // =====================================================
        // Configuración: Parada
        // =====================================================
        modelBuilder.Entity<Parada>(entity =>
        {
            entity.ToTable("Paradas");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Nombre).IsRequired().HasMaxLength(255);
            entity.Property(e => e.Direccion).IsRequired().HasMaxLength(255);
            entity.Property(e => e.Ciudad).IsRequired().HasMaxLength(100);
        });

        // =====================================================
        // Configuración: Viaje
        // =====================================================
        modelBuilder.Entity<Viaje>(entity =>
        {
            entity.ToTable("Viajes");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Estado).IsRequired()
                .HasConversion<string>();
            entity.Property(e => e.PrecioViaje).HasColumnType("decimal(10,2)");
            entity.HasMany(e => e.Reservas)
                .WithOne(r => r.Viaje)
                .HasForeignKey(r => r.ViajeId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        // =====================================================
        // Configuración: Pasajero
        // =====================================================
        modelBuilder.Entity<Pasajero>(entity =>
        {
            entity.ToTable("Pasajeros");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Nombre).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Apellidos).IsRequired().HasMaxLength(100);
            entity.Property(e => e.DNI).IsRequired().HasMaxLength(20);
            entity.HasIndex(e => e.DNI).IsUnique();
            entity.Property(e => e.Telefono).IsRequired().HasMaxLength(20);
            entity.Property(e => e.Email).IsRequired().HasMaxLength(100);
            entity.HasMany(e => e.Reservas)
                .WithOne(r => r.Pasajero)
                .HasForeignKey(r => r.PasajeroId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        // =====================================================
        // Configuración: Reserva
        // =====================================================
        modelBuilder.Entity<Reserva>(entity =>
        {
            entity.ToTable("Reservas");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.CodigoReserva).IsRequired().HasMaxLength(50);
            entity.HasIndex(e => e.CodigoReserva).IsUnique();
            entity.Property(e => e.PrecioPagado).HasColumnType("decimal(10,2)");
            entity.Property(e => e.Estado).IsRequired()
                .HasConversion<string>();
            entity.Property(e => e.TipoPago).IsRequired()
                .HasConversion<string>();
            entity.HasIndex(e => new { e.ViajeId, e.NumeroAsiento }).IsUnique();
        });

        // =====================================================
        // Configuración: MantenimientoAutobus
        // =====================================================
        modelBuilder.Entity<MantenimientoAutobus>(entity =>
        {
            entity.ToTable("MantenimientosAutobus");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Tipo).IsRequired()
                .HasConversion<string>();
            entity.Property(e => e.Descripcion).IsRequired();
            entity.Property(e => e.Costo).HasColumnType("decimal(10,2)");
            entity.Property(e => e.Taller).IsRequired().HasMaxLength(255);
            entity.Property(e => e.Estado).IsRequired()
                .HasConversion<string>();
        });

        // =====================================================
        // Configuración: Gasto
        // =====================================================
        modelBuilder.Entity<Gasto>(entity =>
        {
            entity.ToTable("Gastos");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Tipo).IsRequired()
                .HasConversion<string>();
            entity.Property(e => e.Monto).HasColumnType("decimal(10,2)");
            entity.Property(e => e.Descripcion).IsRequired();
            entity.Property(e => e.NumeroFactura).IsRequired().HasMaxLength(100);
            entity.HasOne(e => e.Proveedor)
                .WithMany()
                .HasForeignKey(e => e.ProveedorId)
                .OnDelete(DeleteBehavior.SetNull);
            entity.HasOne(e => e.Autobus)
                .WithMany()
                .HasForeignKey(e => e.AutobusId)
                .OnDelete(DeleteBehavior.SetNull);
        });

        // =====================================================
        // Configuración: Proveedor
        // =====================================================
        modelBuilder.Entity<Proveedor>(entity =>
        {
            entity.ToTable("Proveedores");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Nombre).IsRequired().HasMaxLength(200);
            entity.Property(e => e.NIF).HasMaxLength(20);
            entity.Property(e => e.Direccion).HasMaxLength(255);
            entity.Property(e => e.Ciudad).HasMaxLength(100);
            entity.Property(e => e.CodigoPostal).HasMaxLength(10);
            entity.Property(e => e.Telefono).HasMaxLength(20);
            entity.Property(e => e.Email).HasMaxLength(100);
            entity.Property(e => e.Contacto).HasMaxLength(100);
            entity.Property(e => e.Activo).IsRequired();
            entity.Property(e => e.FechaRegistro).IsRequired();
        });

        // =====================================================
        // Configuración: Cliente
        // =====================================================
        modelBuilder.Entity<Cliente>(entity =>
        {
            entity.ToTable("Clientes");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Nombre).HasMaxLength(100);
            entity.Property(e => e.Apellidos).HasMaxLength(100);
            entity.Property(e => e.NombreEmpresa).HasMaxLength(255);
            entity.Property(e => e.Tipo).IsRequired()
                .HasConversion<string>();
            entity.Property(e => e.NIF).IsRequired().HasMaxLength(20);
            entity.HasIndex(e => e.NIF).IsUnique();
            entity.Property(e => e.Direccion).HasMaxLength(255);
            entity.Property(e => e.Ciudad).HasMaxLength(100);
            entity.Property(e => e.CodigoPostal).HasMaxLength(10);
            entity.Property(e => e.Provincia).HasMaxLength(100);
            entity.Property(e => e.Pais).HasMaxLength(3).HasDefaultValue("ESP");
            entity.Property(e => e.Telefono).IsRequired().HasMaxLength(20);
            entity.Property(e => e.Fax).HasMaxLength(20);
            entity.Property(e => e.Email).IsRequired().HasMaxLength(100);
            entity.Property(e => e.TipoPersona).HasConversion<string>().HasDefaultValue(TipoPersona.Juridica);
            entity.Property(e => e.TipoResidencia).HasConversion<string>().HasDefaultValue(TipoResidencia.Residente);
            entity.Property(e => e.PersonaContacto).HasMaxLength(200);
            entity.Property(e => e.CodigoINE).HasMaxLength(50);
            entity.HasMany(e => e.Facturas)
                .WithOne(f => f.Cliente)
                .HasForeignKey(f => f.ClienteId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        // =====================================================
        // Configuración: Factura
        // =====================================================
        modelBuilder.Entity<Factura>(entity =>
        {
            entity.ToTable("Facturas");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.NumeroFactura).IsRequired().HasMaxLength(50);
            entity.HasIndex(e => e.NumeroFactura).IsUnique();
            entity.Property(e => e.BaseImponible).HasColumnType("decimal(10,2)");
            entity.Property(e => e.PorcentajeIVA).HasColumnType("decimal(5,2)");
            entity.Property(e => e.ImporteIVA).HasColumnType("decimal(10,2)");
            entity.Property(e => e.CargosAdicionales).HasColumnType("decimal(10,2)");
            entity.Property(e => e.PorcentajeRetencion).HasColumnType("decimal(5,2)");
            entity.Property(e => e.ImporteRetencion).HasColumnType("decimal(10,2)");
            entity.Property(e => e.Total).HasColumnType("decimal(10,2)");
            entity.Property(e => e.Estado).IsRequired()
                .HasConversion<string>();
            entity.Property(e => e.FormaPago)
                .HasConversion<string>();
            entity.Property(e => e.LugarExpedicion).HasMaxLength(200);
            entity.Property(e => e.CodigoPostalExpedicion).HasMaxLength(10);
            entity.Property(e => e.ClaseFactura).HasConversion<string>().HasDefaultValue(ClaseFactura.Original);
            entity.Property(e => e.TipoFactura).HasConversion<string>().HasDefaultValue(TipoFactura.Completa);
            entity.Property(e => e.DescuentosGenerales).HasColumnType("decimal(10,2)").HasDefaultValue(0m);
            entity.Property(e => e.RecargosGenerales).HasColumnType("decimal(10,2)").HasDefaultValue(0m);
            entity.HasMany(e => e.Lineas)
                .WithOne(l => l.Factura)
                .HasForeignKey(l => l.FacturaId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        // =====================================================
        // Configuración: CentroAdministrativo
        // =====================================================
        modelBuilder.Entity<CentroAdministrativo>(entity =>
        {
            entity.ToTable("CentrosAdministrativos");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.CodigoCentro).IsRequired().HasMaxLength(20);
            entity.Property(e => e.CodigoRol).IsRequired().HasMaxLength(2);
            entity.Property(e => e.Nombre).IsRequired().HasMaxLength(200);
            entity.Property(e => e.Direccion).HasMaxLength(200);
            entity.Property(e => e.CodigoPostal).HasMaxLength(10);
            entity.Property(e => e.Ciudad).HasMaxLength(100);
            entity.Property(e => e.Provincia).HasMaxLength(100);
            entity.Property(e => e.Pais).HasMaxLength(3).HasDefaultValue("ESP");
            entity.HasOne(e => e.Cliente)
                .WithMany(c => c.CentrosAdministrativos)
                .HasForeignKey(e => e.ClienteId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        // =====================================================
        // Configuración: LineaFactura
        // =====================================================
        modelBuilder.Entity<LineaFactura>(entity =>
        {
            entity.ToTable("LineasFactura");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Descripcion).IsRequired().HasMaxLength(500);
            entity.Property(e => e.PrecioUnitario).HasColumnType("decimal(10,2)");
            entity.Property(e => e.Subtotal).HasColumnType("decimal(10,2)");
            entity.HasOne(e => e.Viaje)
                .WithMany()
                .HasForeignKey(e => e.ViajeId)
                .OnDelete(DeleteBehavior.SetNull);
        });

        // =====================================================
        // Configuración: Documento
        // =====================================================
        modelBuilder.Entity<Documento>(entity =>
        {
            entity.ToTable("Documentos");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.NombreArchivo).IsRequired().HasMaxLength(255);
            entity.Property(e => e.TipoDocumento).IsRequired().HasMaxLength(50);
            entity.Property(e => e.Descripcion).HasMaxLength(500);
            entity.Property(e => e.RutaArchivo).IsRequired().HasMaxLength(500);
            entity.Property(e => e.FechaSubida).IsRequired();
            entity.HasOne(e => e.Conductor)
                .WithMany(c => c.Documentos)
                .HasForeignKey(e => e.ConductorId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(e => e.Autobus)
                .WithMany(a => a.Documentos)
                .HasForeignKey(e => e.AutobusId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(e => e.ConfiguracionEmpresa)
                .WithMany(ce => ce.Documentos)
                .HasForeignKey(e => e.ConfiguracionEmpresaId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(e => e.Proveedor)
                .WithMany(p => p.Documentos)
                .HasForeignKey(e => e.ProveedorId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(e => e.Cliente)
                .WithMany(c => c.Documentos)
                .HasForeignKey(e => e.ClienteId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        // =====================================================
        // Configuración: Presupuesto
        // =====================================================
        modelBuilder.Entity<Presupuesto>(entity =>
        {
            entity.ToTable("Presupuestos");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.NumeroPresupuesto).IsRequired().HasMaxLength(50);
            entity.HasIndex(e => e.NumeroPresupuesto).IsUnique();
            entity.Property(e => e.BaseImponible).HasColumnType("decimal(10,2)");
            entity.Property(e => e.PorcentajeIVA).HasColumnType("decimal(5,2)");
            entity.Property(e => e.ImporteIVA).HasColumnType("decimal(10,2)");
            entity.Property(e => e.CargosAdicionales).HasColumnType("decimal(10,2)");
            entity.Property(e => e.PorcentajeRetencion).HasColumnType("decimal(5,2)");
            entity.Property(e => e.ImporteRetencion).HasColumnType("decimal(10,2)");
            entity.Property(e => e.Total).HasColumnType("decimal(10,2)");
            entity.Property(e => e.Estado).IsRequired();
            entity.HasOne(e => e.Cliente)
                .WithMany()
                .HasForeignKey(e => e.ClienteId)
                .OnDelete(DeleteBehavior.Restrict);
            entity.HasOne(e => e.Factura)
                .WithMany()
                .HasForeignKey(e => e.FacturaId)
                .OnDelete(DeleteBehavior.SetNull);
            entity.HasMany(e => e.Lineas)
                .WithOne(l => l.Presupuesto)
                .HasForeignKey(l => l.PresupuestoId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        // =====================================================
        // Configuración: LineaPresupuesto
        // =====================================================
        modelBuilder.Entity<LineaPresupuesto>(entity =>
        {
            entity.ToTable("LineasPresupuesto");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Descripcion).IsRequired().HasMaxLength(500);
            entity.Property(e => e.PrecioUnitario).HasColumnType("decimal(10,2)");
            entity.Property(e => e.Subtotal).HasColumnType("decimal(10,2)");
            entity.HasOne(e => e.Viaje)
                .WithMany()
                .HasForeignKey(e => e.ViajeId)
                .OnDelete(DeleteBehavior.SetNull);
        });

        // =====================================================
        // QUERY FILTERS para Multi-Tenancy
        // =====================================================
        // Solo aplicar filtros si NO es SuperAdmin y hay EmpresaId
        // Usar comparación directa con nullable para evitar errores cuando CurrentEmpresaId es null
        
        modelBuilder.Entity<Autobus>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Cliente>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Conductor>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Factura>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Gasto>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<MantenimientoAutobus>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Presupuesto>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Proveedor>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Ruta>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Viaje>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Reserva>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Pasajero>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<Documento>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        modelBuilder.Entity<ConfiguracionEmpresa>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
        
        // Usuario: solo SuperAdmin puede ver todos, otros ven solo su empresa
        modelBuilder.Entity<Usuario>().HasQueryFilter(e => 
            IsSuperAdmin || e.EmpresaId == CurrentEmpresaId);
    }
}

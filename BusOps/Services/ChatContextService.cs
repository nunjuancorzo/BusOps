using BusOps.Data;
using BusOps.Models;
using Microsoft.EntityFrameworkCore;

namespace BusOps.Services;

public interface IChatContextService
{
    Task<string> ObtenerContextoEmpresaAsync();
}

public class ChatContextService : IChatContextService
{
    private readonly IDbContextFactory<BusOpsDbContext> _dbFactory;
    private readonly ITenantService _tenantService;

    public ChatContextService(
        IDbContextFactory<BusOpsDbContext> dbFactory,
        ITenantService tenantService)
    {
        _dbFactory = dbFactory;
        _tenantService = tenantService;
    }

    public async Task<string> ObtenerContextoEmpresaAsync()
    {
        try
        {
            var empresaId = await _tenantService.GetEmpresaIdAsync();
            if (!empresaId.HasValue)
            {
                return "No hay empresa seleccionada actualmente.";
            }

            using var context = await _dbFactory.CreateDbContextAsync();
            context.CurrentEmpresaId = empresaId;

            // Obtener datos de la empresa
            var autobuses = await context.Autobuses
                .Where(a => a.EmpresaId == empresaId.Value)
                .ToListAsync();

            var conductores = await context.Conductores
                .Where(c => c.EmpresaId == empresaId.Value)
                .ToListAsync();

            var viajes = await context.ViajesFijos
                .Where(v => v.EmpresaId == empresaId.Value)
                .ToListAsync();

            var reservas = await context.Reservas
                .Where(r => r.EmpresaId == empresaId.Value)
                .ToListAsync();

            var gastos = await context.Gastos
                .Where(g => g.EmpresaId == empresaId.Value)
                .ToListAsync();

            var mantenimientos = await context.MantenimientosAutobus
                .Where(m => m.EmpresaId == empresaId.Value)
                .ToListAsync();

            var clientes = await context.Clientes
                .Where(c => c.EmpresaId == empresaId.Value)
                .ToListAsync();

            var facturas = await context.Facturas
                .Where(f => f.EmpresaId == empresaId.Value)
                .ToListAsync();

            var rutas = await context.Rutas
                .Where(r => r.EmpresaId == empresaId.Value)
                .ToListAsync();

            // Calcular estadísticas
            var totalAutobuses = autobuses.Count;
            var autobusesActivos = autobuses.Count(a => a.Estado == EstadoAutobus.Disponible || a.Estado == EstadoAutobus.EnServicio);
            var autobusesMantenimiento = autobuses.Count(a => a.Estado == EstadoAutobus.EnMantenimiento);

            var totalConductores = conductores.Count;
            var conductoresActivos = conductores.Count(c => c.Estado == EstadoConductor.Activo);

            var totalViajes = viajes.Count;
            var viajesPendientes = viajes.Count(v => v.Estado == EstadoViaje.Programado);
            var viajesEnCurso = viajes.Count(v => v.Estado == EstadoViaje.EnCurso);
            var viajesCompletados = viajes.Count(v => v.Estado == EstadoViaje.Completado);
            var viajesCancelados = viajes.Count(v => v.Estado == EstadoViaje.Cancelado);

            var totalReservas = reservas.Count;
            var reservasConfirmadas = reservas.Count(r => r.Estado == EstadoReserva.Confirmada);
            var reservasPendientes = reservas.Count(r => r.Estado == EstadoReserva.Pendiente);

            var totalClientes = clientes.Count;
            var clientesActivos = clientes.Count(c => c.Activo);

            var totalFacturas = facturas.Count;
            var facturasEmitidas = facturas.Count(f => f.Estado == EstadoFactura.Emitida);
            var facturasPagadas = facturas.Count(f => f.Estado == EstadoFactura.Pagada);

            var totalRutas = rutas.Count;
            var rutasActivas = rutas.Count(r => r.Activa);

            // Cálculos financieros
            var totalIngresos = facturas
                .Where(f => f.Estado == EstadoFactura.Pagada)
                .Sum(f => f.Total);

            var totalGastos = gastos.Sum(g => g.Monto);

            var gastosMantenimiento = mantenimientos.Sum(m => m.Costo);

            var pendienteCobro = facturas
                .Where(f => f.Estado == EstadoFactura.Emitida)
                .Sum(f => f.Total);

            // Top 5 autobuses por viajes
            var topAutobuses = viajes
                .GroupBy(v => v.Autobus?.Matricula ?? "Desconocido")
                .Select(g => new { Autobus = g.Key, Viajes = g.Count() })
                .OrderByDescending(x => x.Viajes)
                .Take(5)
                .ToList();

            // Top 5 conductores por viajes
            var topConductores = viajes
                .GroupBy(v => v.Conductor?.Nombre ?? "Desconocido")
                .Select(g => new { Conductor = g.Key, Viajes = g.Count() })
                .OrderByDescending(x => x.Viajes)
                .Take(5)
                .ToList();

            // Top 5 rutas
            var topRutas = viajes
                .GroupBy(v => v.Ruta?.Nombre ?? "Desconocida")
                .Select(g => new { Ruta = g.Key, Viajes = g.Count() })
                .OrderByDescending(x => x.Viajes)
                .Take(5)
                .ToList();

            // Construir contexto
            var contexto = $@"
DATOS ACTUALES DE LA EMPRESA DE TRANSPORTE:

FLOTA DE AUTOBUSES:
- Total de autobuses: {totalAutobuses}
- Autobuses activos: {autobusesActivos}
- Autobuses en mantenimiento: {autobusesMantenimiento}

CONDUCTORES:
- Total de conductores: {totalConductores}
- Conductores activos: {conductoresActivos}

VIAJES:
- Total de viajes: {totalViajes}
- Viajes programados: {viajesPendientes}
- Viajes en curso: {viajesEnCurso}
- Viajes completados: {viajesCompletados}
- Viajes cancelados: {viajesCancelados}

RESERVAS:
- Total de reservas: {totalReservas}
- Reservas confirmadas: {reservasConfirmadas}
- Reservas pendientes: {reservasPendientes}

RUTAS:
- Total de rutas: {totalRutas}
- Rutas activas: {rutasActivas}

CLIENTES:
- Total de clientes: {totalClientes}
- Clientes activos: {clientesActivos}

FACTURACIÓN:
- Total de facturas: {totalFacturas}
- Facturas emitidas: {facturasEmitidas}
- Facturas pagadas: {facturasPagadas}

FINANZAS:
- Total ingresos (facturas pagadas): {totalIngresos:C2}
- Total gastos operativos: {totalGastos:C2}
- Gastos de mantenimiento: {gastosMantenimiento:C2}
- Pendiente de cobro: {pendienteCobro:C2}
- Balance: {(totalIngresos - totalGastos - gastosMantenimiento):C2}

TOP 5 AUTOBUSES MÁS UTILIZADOS:
{string.Join("\n", topAutobuses.Select((a, i) => $"{i + 1}. {a.Autobus}: {a.Viajes} viajes"))}

TOP 5 CONDUCTORES MÁS ACTIVOS:
{string.Join("\n", topConductores.Select((c, i) => $"{i + 1}. {c.Conductor}: {c.Viajes} viajes"))}

TOP 5 RUTAS MÁS POPULARES:
{string.Join("\n", topRutas.Select((r, i) => $"{i + 1}. {r.Ruta}: {r.Viajes} viajes"))}

Usa esta información para responder preguntas sobre el estado actual de la empresa de transporte.
";

            return contexto;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error obteniendo contexto: {ex.Message}");
            return "No se pudo acceder a los datos de la empresa en este momento.";
        }
    }
}

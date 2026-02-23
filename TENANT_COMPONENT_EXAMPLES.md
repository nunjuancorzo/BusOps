# 📝 Ejemplo de Uso de TenantComponentBase

## Uso Básico en un Componente

```razor
@page "/mi-pagina"
@using BusOps.Helpers
@inherits TenantComponentBase
@rendermode InteractiveServer

<PageTitle>Mi Página</PageTitle>

<h2>Listado de Autobuses</h2>

@if (autobuses == null)
{
    <p>Cargando...</p>
}
else
{
    <ul>
        @foreach (var autobus in autobuses)
        {
            <li>@autobus.Matricula - @autobus.Marca</li>
        }
    </ul>
}

@code {
    private List<Autobus> autobuses = null!;

    protected override async Task OnInitializedAsync()
    {
        // 1. Cargar contexto de tenant (obligatorio)
        await LoadTenantContextAsync();

        // 2. Crear DbContext con tenant configurado
        using var context = await CreateTenantContextAsync();

        // 3. Las consultas automáticamente están filtradas por empresa
        autobuses = await context.Autobuses.ToListAsync();
    }
}
```

## Verificar Permisos

```razor
@code {
    protected override async Task OnInitializedAsync()
    {
        // Solo SuperAdmin puede acceder
        if (!await RequireSuperAdminAsync())
            return;

        // ... tu código aquí ...
    }
}
```

O para Administradores:

```razor
@code {
    protected override async Task OnInitializedAsync()
    {
        // Solo Admin o SuperAdmin pueden acceder
        if (!await RequireAdminAsync())
            return;

        // ... tu código aquí ...
    }
}
```

## Crear Nuevos Registros

```razor
@code {
    private async Task GuardarAutobus()
    {
        using var context = await CreateTenantContextAsync();

        var nuevoAutobus = new Autobus
        {
            Matricula = "ABC123",
            Marca = "Mercedes",
            // IMPORTANTE: Asignar empresa
            EmpresaId = CurrentEmpresaId.Value
        };

        context.Autobuses.Add(nuevoAutobus);
        await context.SaveChangesAsync();
    }
}
```

## Verificar Límites de Recursos

```razor
@code {
    private async Task AgregarNuevoAutobus()
    {
        using var context = await CreateTenantContextAsync();
        
        // Obtener empresa para verificar límites
        var empresa = await context.Empresas
            .FirstOrDefaultAsync(e => e.Id == CurrentEmpresaId);

        // Verificar límite
        var (allowed, message) = await CheckResourceLimitAsync<Autobus>(empresa?.MaxAutobuses);
        
        if (!allowed)
        {
            // Mostrar mensaje de error
            await JSRuntime.InvokeVoidAsync("alert", message);
            return;
        }

        // Proceder a crear el autobús
        // ...
    }
}
```

## Acceder a Datos del Usuario

```razor
@code {
    protected override async Task OnInitializedAsync()
    {
        await LoadTenantContextAsync();

        <p>Usuario ID: @CurrentUserId</p>
        <p>Rol: @CurrentUserRole</p>
        <p>Empresa ID: @CurrentEmpresaId</p>
        <p>Es SuperAdmin: @IsSuperAdmin</p>
    }
}
```

## Modo SuperAdmin (Ver Todas las Empresas)

```razor
@code {
    private async Task CargarTodasLasEmpresas()
    {
        using var context = await CreateTenantContextAsync();
        
        // Ya está configurado con IsSuperAdmin = true
        // No se aplican filtros
        var empresas = await context.Empresas.ToListAsync();
    }
}
```

## Ejemplo Completo: CRUD

```razor
@page "/autobuses"
@using BusOps.Helpers
@inherits TenantComponentBase
@rendermode InteractiveServer

@code {
    private List<Autobus> autobuses = new();
    
    protected override async Task OnInitializedAsync()
    {
        await LoadTenantContextAsync();
        await CargarAutobuses();
    }

    private async Task CargarAutobuses()
    {
        using var context = await CreateTenantContextAsync();
        autobuses = await context.Autobuses
            .Include(a => a.Conductor)
            .OrderBy(a => a.Matricula)
            .ToListAsync();
    }

    private async Task Crear(Autobus nuevoAutobus)
    {
        using var context = await CreateTenantContextAsync();
        
        // Asignar empresa
        nuevoAutobus.EmpresaId = CurrentEmpresaId.Value;
        
        context.Autobuses.Add(nuevoAutobus);
        await context.SaveChangesAsync();
        await CargarAutobuses();
    }

    private async Task Actualizar(Autobus autobus)
    {
        using var context = await CreateTenantContextAsync();
        context.Update(autobus);
        await context.SaveChangesAsync();
        await CargarAutobuses();
    }

    private async Task Eliminar(int id)
    {
        using var context = await CreateTenantContextAsync();
        var autobus = await context.Autobuses.FindAsync(id);
        
        if (autobus != null)
        {
            context.Autobuses.Remove(autobus);
            await context.SaveChangesAsync();
            await CargarAutobuses();
        }
    }
}
```

## Notas Importantes

1. **Siempre** llama a `LoadTenantContextAsync()` en `OnInitializedAsync()`
2. **Siempre** usa `CreateTenantContextAsync()` para crear el DbContext
3. **Siempre** asigna `EmpresaId` al crear nuevos registros:
   ```csharp
   nuevoRegistro.EmpresaId = CurrentEmpresaId.Value;
   ```
4. Para SuperAdmin, `CurrentEmpresaId` será `null` pero `IsSuperAdmin` será `true`
5. El DbContext automáticamente filtra consultas por empresa (excepto SuperAdmin)

## Propiedades Disponibles

- `CurrentEmpresaId`: ID de la empresa actual (null para SuperAdmin)
- `CurrentUserRole`: Rol del usuario ("SuperAdministrador", "Administrador", "Usuario")
- `CurrentUserId`: ID del usuario actual
- `IsSuperAdmin`: true si es SuperAdministrador
- `IsAuthenticated`: true si está autenticado

## Métodos Disponibles

- `LoadTenantContextAsync()`: Carga el contexto desde la sesión
- `CreateTenantContextAsync()`: Crea DbContext configurado
- `RequireSuperAdminAsync()`: Verifica que sea SuperAdmin
- `RequireAdminAsync()`: Verifica que sea Admin o SuperAdmin
- `CheckResourceLimitAsync<T>(maxCount)`: Verifica límites de recursos

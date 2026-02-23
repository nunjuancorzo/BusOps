using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using Microsoft.EntityFrameworkCore;
using BusOps.Data;
using BusOps.Models;

namespace BusOps.Helpers;

/// <summary>
/// Clase base para componentes que requieren acceso al DbContext con contexto multi-tenant
/// </summary>
public class TenantComponentBase : ComponentBase
{
    [Inject] protected IDbContextFactory<BusOpsDbContext> DbFactory { get; set; } = null!;
    [Inject] protected ProtectedSessionStorage SessionStorage { get; set; } = null!;
    [Inject] protected NavigationManager NavigationManager { get; set; } = null!;

    protected int? CurrentEmpresaId { get; private set; }
    protected string? CurrentUserRole { get; private set; }
    protected int? CurrentUserId { get; private set; }
    protected bool IsSuperAdmin { get; private set; }
    protected bool IsAuthenticated { get; private set; }

    /// <summary>
    /// Carga el contexto de tenant desde la sesión
    /// Llama a este método en OnInitializedAsync()
    /// </summary>
    protected async Task LoadTenantContextAsync()
    {
        try
        {
            var authResult = await SessionStorage.GetAsync<bool>("isAuthenticated");
            IsAuthenticated = authResult.Success && authResult.Value;

            if (!IsAuthenticated)
            {
                NavigationManager.NavigateTo("/login");
                return;
            }

            var roleResult = await SessionStorage.GetAsync<string>("userRole");
            if (roleResult.Success)
            {
                CurrentUserRole = roleResult.Value;
                IsSuperAdmin = roleResult.Value == Roles.SuperAdministrador;
            }

            var userIdResult = await SessionStorage.GetAsync<int>("userId");
            if (userIdResult.Success)
            {
                CurrentUserId = userIdResult.Value;
            }

            if (!IsSuperAdmin)
            {
                var empresaResult = await SessionStorage.GetAsync<int>("EmpresaId");
                if (empresaResult.Success)
                {
                    CurrentEmpresaId = empresaResult.Value;
                }
                else
                {
                    // Usuario sin empresa asignada (error de configuración)
                    NavigationManager.NavigateTo("/login");
                }
            }
        }
        catch
        {
            NavigationManager.NavigateTo("/login");
        }
    }

    /// <summary>
    /// Crea un DbContext configurado con el contexto de tenant actual
    /// </summary>
    protected async Task<BusOpsDbContext> CreateTenantContextAsync()
    {
        if (CurrentEmpresaId == null && CurrentUserRole == null)
        {
            await LoadTenantContextAsync();
        }

        var context = await DbFactory.CreateDbContextAsync();
        context.CurrentEmpresaId = CurrentEmpresaId;
        context.IsSuperAdmin = IsSuperAdmin;
        
        return context;
    }

    /// <summary>
    /// Verifica que el usuario actual sea SuperAdmin
    /// Redirige al home si no lo es
    /// </summary>
    protected async Task<bool> RequireSuperAdminAsync()
    {
        await LoadTenantContextAsync();
        
        if (!IsSuperAdmin)
        {
            NavigationManager.NavigateTo("/");
            return false;
        }
        
        return true;
    }

    /// <summary>
    /// Verifica que el usuario actual sea al menos Administrador (de empresa)
    /// Redirige al home si no lo es
    /// </summary>
    protected async Task<bool> RequireAdminAsync()
    {
        await LoadTenantContextAsync();
        
        if (CurrentUserRole != Roles.SuperAdministrador && CurrentUserRole != Roles.Administrador)
        {
            NavigationManager.NavigateTo("/");
            return false;
        }
        
        return true;
    }

    /// <summary>
    /// Verifica los límites de recursos para la empresa actual
    /// </summary>
    protected async Task<(bool allowed, string? message)> CheckResourceLimitAsync<T>(int? maxCount) where T : class
    {
        if (IsSuperAdmin || !maxCount.HasValue)
        {
            return (true, null);
        }

        using var context = await CreateTenantContextAsync();
        var currentCount = await context.Set<T>().CountAsync();

        if (currentCount >= maxCount.Value)
        {
            var resourceName = typeof(T).Name;
            return (false, $"Ha alcanzado el límite de {maxCount} {resourceName}s para su plan.");
        }

        return (true, null);
    }
}

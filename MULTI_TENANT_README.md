# 🏢 Sistema Multi-Tenant de BusOps

## Descripción

BusOps ahora soporta múltiples empresas en una sola base de datos. Puedes vender la aplicación a diferentes empresas y cada una tendrá sus propios datos completamente aislados.

## 🔑 Roles de Usuario

### 1. **SuperAdministrador**
- Usuario único que controla toda la aplicación
- Puede ver y administrar TODAS las empresas
- Crea y gestiona empresas
- No está asociado a ninguna empresa específica
- **Usuario por defecto:** `superadmin` / `1234`

### 2. **Administrador** (de empresa)
- Administra una empresa específica
- Solo ve datos de su empresa
- Puede gestionar usuarios de su empresa
- Debe estar asociado a una empresa

### 3. **Usuario** (de empresa)
- Usuario regular de una empresa
- Solo ve datos de su empresa
- Acceso limitado a funcionalidades

## 📊 Estructura del Sistema

```
┌─────────────────────────────────────────┐
│       Super Administrador (Tú)          │
│         usuario: superadmin             │
└──────────────┬──────────────────────────┘
               │
       ┌───────┴────────┐
       ▼                ▼
┌────────────┐    ┌────────────┐
│ Empresa 1  │    │ Empresa 2  │
│ "Mi Empresa"│    │ "Otra SA"  │
├────────────┤    ├────────────┤
│ Usuarios   │    │ Usuarios   │
│ Autobuses  │    │ Autobuses  │
│ Clientes   │    │ Clientes   │
│ Facturas   │    │ Facturas   │
│ ...        │    │ ...        │
└────────────┘    └────────────┘
```

## 🚀 Cómo Empezar

### Paso 1: Ejecutar Migración SQL

```bash
# Desde la carpeta Database
mysql -u tu_usuario -p tu_base_de_datos < 15_multi_tenant_migration.sql
```

Este script:
- ✅ Crea la tabla `Empresas`
- ✅ Agrega columna `EmpresaId` a todas las tablas
- ✅ Crea una "Empresa Principal" con ID=1
- ✅ Migra todos tus datos actuales a esa empresa
- ✅ Convierte el usuario "admin" en "superadmin"

### Paso 2: Iniciar Sesión como SuperAdmin

```
Usuario: superadmin
Contraseña: 1234
```

**⚠️ IMPORTANTE:** Cambia esta contraseña inmediatamente en producción.

### Paso 3: Gestionar Empresas

1. Ve a la sección **"Empresas"** (solo visible para SuperAdmin)
2. Haz clic en **"Nueva Empresa"**
3. Completa:
   - Nombre comercial
   - Slug (URL amigable)
   - Plan de suscripción
   - Límites de recursos
   - Configuración de la empresa

## 💻 Uso en el Código

### En Componentes Razor

Cuando trabajescón el DbContext en tus componentes, el sistema automáticamente filtra los datos por la empresa del usuario logueado:

```csharp
@code {
    protected override async Task OnInitializedAsync()
    {
        using var context = await DbFactory.CreateDbContextAsync();
        
        // Configurar contexto de tenant
        var empresaId = await SessionStorage.GetAsync<int?>("EmpresaId");
        var rol = await SessionStorage.GetAsync<string>("userRole");
        
        if (empresaId.Success && empresaId.Value.HasValue)
        {
            context.CurrentEmpresaId = empresaId.Value;
        }
        context.IsSuperAdmin = rol.Success && rol.Value == "SuperAdministrador";
        
        // Esta consulta SOLO verá datos de la empresa del usuario
        var autobuses = await context.Autobuses.ToListAsync();
        
        // Para SuperAdmin: verá TODOS los autobuses de TODAS las empresas
    }
}
```

### Al Crear Nuevos Registros

Siempre asigna el `EmpresaId` al crear:

```csharp
var nuevoAutobus = new Autobus
{
    Matricula = "ABC123",
    Marca = "Mercedes",
    // ... otros campos
    EmpresaId = context.CurrentEmpresaId.Value // IMPORTANTE
};

context.Autobuses.Add(nuevoAutobus);
await context.SaveChangesAsync();
```

## 📝 Planes de Suscripción

Puedes definir límites por plan:

- **Básico**: 5 usuarios, 10 autobuses, 20 conductores
- **Profesional**: 20 usuarios, 50 autobuses, 100 conductores
- **Empresarial**: Sin límites

### Verificar Límites

```csharp
using var context = await DbFactory.CreateDbContextAsync();
var empresa = await context.Empresas
    .FirstOrDefaultAsync(e => e.Id == empresaId);

if (empresa.MaxAutobuses.HasValue)
{
    var cantidadActual = await context.Autobuses
        .CountAsync(a => a.EmpresaId == empresaId);
    
    if (cantidadActual >= empresa.MaxAutobuses.Value)
    {
        // Mostrar error: límite alcanzado
    }
}
```

## 🔒 Seguridad

### Query Filters Automáticos

El sistema usa **Query Filters** de Entity Framework Core para aislar datos:

```csharp
// En BusOpsDbContext.cs
modelBuilder.Entity<Autobus>().HasQueryFilter(e => 
    IsSuperAdmin || (CurrentEmpresaId.HasValue && e.EmpresaId == CurrentEmpresaId.Value));
```

Esto significa que:
- ✅ No puedes acceder accidentalmente a datos de otra empresa
- ✅ Las consultas automáticamente filtran por `EmpresaId`
- ✅ Solo SuperAdmin puede ver todos los datos

### Desactivar Filtros (Solo SuperAdmin)

```csharp
context.IsSuperAdmin = true; // Desactiva todos los filtros
var todasLasEmpresas = await context.Empresas.ToListAsync();
```

## 🎯 Casos de Uso

### 1. Agregar Nueva Empresa Cliente

1. Login como `superadmin`
2. Ir a **Empresas** → **Nueva Empresa**
3. Completar datos
4. Crear usuarios para esa empresa
5. Entregar credenciales al cliente

### 2. Usuario de Empresa Trabajando

1. Usuario hace login con sus credenciales
2. El sistema automáticamente:
   - Guarda `EmpresaId` en sesión
   - Filtra todas las consultas por su empresa
   - Solo ve sus datos

### 3. Desactivar Empresa

1. Como SuperAdmin
2. Ir a **Empresas**
3. Click en ❌ para desactivar
4. Los usuarios de esa empresa no podrán iniciar sesión

## 📋 Checklist de Implementación

- [x] Modelo `Empresa.cs`
- [x] Actualizar todos los modelos con `EmpresaId`
- [x] Query Filters en DbContext
- [x] Servicio `TenantService`
- [x] Actualizar Login
- [x] Scripts SQL de migración
- [x] Páginas de administración de empresas
- [ ] Actualizar componentes existentes para usar TenantService
- [ ] Agregar verificación de límites
- [ ] Crear middleware de tenant (opcional)

## 🔄 Próximos Pasos Recomendados

1. **Crear un componente base** para simplificar el uso del DbContext en páginas
2. **Agregar validación de límites** antes de crear recursos
3. **Implementar auditoría** para saber qué empresa hace qué
4. **Agregar reportes de uso** por empresa
5. **Sistema de facturación** basado en planes

## ⚠️ Notas Importantes

- Los datos existentes se migraron a "Empresa Principal" (ID=1)
- Cambia la contraseña del SuperAdmin en producción
- Asegúrate de configurar `CurrentEmpresaId` en el DbContext en TODOS los componentes
- Los SuperAdmin siempre deben configurar `IsSuperAdmin = true` para ver todo

## 🆘 Troubleshooting

### No veo datos después de la migración
```csharp
// Asegúrate de configurar el contexto:
context.CurrentEmpresaId = empresaId;
context.IsSuperAdmin = esSuperAdmin;
```

### Error "No se puede insertar NULL en EmpresaId"
```csharp
// Siempre asigna EmpresaId al crear:
nuevoRegistro.EmpresaId = context.CurrentEmpresaId.Value;
```

### Quiero que SuperAdmin no vea filtros
```csharp
context.IsSuperAdmin = true; // Esto desactiva TODOS los filtros
```

---

✨ **¡Tu aplicación ahora es multi-tenant y lista para vender a múltiples empresas!**

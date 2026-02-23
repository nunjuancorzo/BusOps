# SOLUCION AL ERROR DE SCRIPTS POWERSHELL

## Problema Resuelto

El error era causado por **caracteres especiales** (acentos, ñ, símbolos) que se corrompían al transferir el archivo de Mac a Windows.

**Problemas encontrados**:
- "instalación" se convertía en "instalaciÃ³n"
- Símbolos ✓, ⚠ causaban errores de sintaxis
- Comillas tipográficas incompatibles

## Scripts Corregidos

He reemplazado TODOS los caracteres especiales por ASCII básico en los scripts:

- ✅ `instalar_requisitos.ps1` - Corregido
- ✅ `configurar_iis.ps1` - Corregido

## Qué Hacer Ahora

### 1. Descargar el ZIP actualizado

El nuevo archivo ZIP ha sido recreado:
```
BusOps_Publicacion_Completa_IIS.zip (39 MB)
Ubicación: /Users/juanmariacorzo/Documents/BusOps/BusOps/
```

### 2. Transferir al servidor Windows

- Elimina el ZIP anterior del servidor
- Copia el nuevo `BusOps_Publicacion_Completa_IIS.zip`
- Extrae en `C:\Temp\BusOps` o cualquier ubicación

### 3. Copiar archivos

```powershell
# En Windows
# Copiar la carpeta publish al destino final
Copy-Item "C:\Temp\BusOps\BusOps\publish\*" -Destination "C:\inetpub\wwwroot\BusOps\" -Recurse -Force
```

### 4. Ejecutar los scripts corregidos

```powershell
# Abrir PowerShell como Administrador
cd C:\inetpub\wwwroot\BusOps

# Permitir ejecución de scripts (solo primera vez)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 1. Instalar requisitos
.\instalar_requisitos.ps1

# REINICIAR EL SERVIDOR

# 2. Después de reiniciar, configurar IIS
cd C:\inetpub\wwwroot\BusOps
.\configurar_iis.ps1
```

## Cambios en los Scripts

### Antes (con errores):
```powershell
Write-Host "✓ Instalación completada" -ForegroundColor Green
Write-Host "Contraseña: A76262136.r"
```

### Ahora (corregido):
```powershell
Write-Host "[OK] Instalacion completada" -ForegroundColor Green
Write-Host "Contrasena: A76262136.r"
```

## Verificación

Después de ejecutar los scripts, deberías ver mensajes como:

```
[OK] Módulo IIS cargado
[OK] Carpeta de archivos encontrada
[OK] Application Pool 'BusOps' creado
[OK] Sitio web 'BusOps' creado
[OK] Permisos configurados
[OK] Sitio web iniciado correctamente
```

## Si Aún Tienes Problemas

### Error: "Running scripts is disabled"
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Error: "Módulo WebAdministration no disponible"
- IIS no está instalado correctamente
- Ejecuta primero `instalar_requisitos.ps1`
- Reinicia el servidor

### Error: Otros errores de sintaxis
- Asegúrate de que estás usando el ZIP NUEVO
- Elimina completamente la carpeta anterior
- Extrae de nuevo el ZIP y copia todo

## Archivos Actualizados en el ZIP

```
BusOps_Publicacion_Completa_IIS/
├── BusOps/publish/
│   ├── instalar_requisitos.ps1      ← CORREGIDO ✓
│   ├── configurar_iis.ps1           ← CORREGIDO ✓
│   ├── BusOps.dll
│   ├── web.config
│   └── ... (resto de archivos)
├── Database/
│   ├── importar_database.ps1
│   ├── verificar_mysql.ps1
│   └── ... (scripts SQL)
└── ... (documentación)
```

## Próximos Pasos

Después de ejecutar los scripts exitosamente:

1. **Verificar servicios**:
   ```powershell
   Get-Service W3SVC, MySQL*
   # Ambos deben estar "Running"
   ```

2. **Acceder a BusOps**:
   ```
   http://localhost
   ```

3. **Login**:
   ```
   Email: admin@autocaresyegros.com
   Contraseña: (configurada en BD)
   ```

---

**El problema está solucionado. El nuevo ZIP tiene scripts 100% compatibles con Windows.**

Fecha de corrección: 19 de febrero de 2026

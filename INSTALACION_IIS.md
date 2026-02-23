# GUÍA DE INSTALACIÓN DE BUSOPS EN IIS (WINDOWS SERVER)

## 📋 REQUISITOS PREVIOS

### 1. .NET 8.0 Hosting Bundle
- Descargar de: https://dotnet.microsoft.com/download/dotnet/8.0
- Buscar: "ASP.NET Core Runtime 8.0.x - Windows Hosting Bundle"
- Instalar el bundle completo
- **IMPORTANTE**: Reiniciar el servidor después de la instalación

### 2. MySQL Server
- Versión recomendada: MySQL 8.0 o superior
- Durante la instalación:
  - Usuario: root
  - Contraseña: A76262136.r
- Permitir conexiones desde localhost
- Configurar el servicio para inicio automático

### 3. IIS (Internet Information Services)
- Abrir "Panel de Control" → "Programas" → "Activar o desactivar las características de Windows"
- Activar:
  - ✅ Internet Information Services
  - ✅ Servicios de World Wide Web
  - ✅ Características de desarrollo de aplicaciones
    - ✅ ASP.NET 4.8
    - ✅ Extensibilidad de .NET 4.8
  - ✅ Características HTTP comunes (todas)
  - ✅ Herramientas de administración web

---

## 📦 PREPARACIÓN DE LA BASE DE DATOS

### 1. Crear la base de datos
```sql
-- Conectar a MySQL
mysql -u root -pA76262136.r

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS busops CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Verificar
SHOW DATABASES;
USE busops;
```

### 2. Importar los scripts SQL
En el servidor Windows, ejecutar en orden los scripts de la carpeta `Database/`:

```bash
cd ruta\a\BusOps\Database

mysql -u root -pA76262136.r busops < 01_create_tables.sql
mysql -u root -pA76262136.r busops < 02_insert_test_data.sql
mysql -u root -pA76262136.r busops < 03_alter_clientes_table.sql
mysql -u root -pA76262136.r busops < 04_create_proveedores_table.sql
mysql -u root -pA76262136.r busops < 04_create_usuarios_table.sql
mysql -u root -pA76262136.r busops < 05_alter_conductores_add_autobus.sql
mysql -u root -pA76262136.r busops < 05_alter_configuracion_empresa.sql
mysql -u root -pA76262136.r busops < 06_alter_proveedores_table.sql
mysql -u root -pA76262136.r busops < 06_create_documentos_table.sql
mysql -u root -pA76262136.r busops < 07_alter_autobuses_add_fields.sql
mysql -u root -pA76262136.r busops < 07_alter_clientes_table.sql
mysql -u root -pA76262136.r busops < 08_alter_conductores_add_fields.sql
mysql -u root -pA76262136.r busops < 08_alter_facturas_add_cargos_retencion.sql
mysql -u root -pA76262136.r busops < 09_alter_lineas_factura_add_tipo.sql
mysql -u root -pA76262136.r busops < 10_alter_facturas_add_importe_concepto.sql
mysql -u root -pA76262136.r busops < 11_fix_tipo_column_type.sql
mysql -u root -pA76262136.r busops < 12_create_presupuestos_table.sql
mysql -u root -pA76262136.r busops < 13_alter_configuracion_add_presupuesto_serie.sql
mysql -u root -pA76262136.r busops < 14_alter_gastos_add_documento.sql
mysql -u root -pA76262136.r busops < 15_multi_tenant_migration.sql
mysql -u root -pA76262136.r busops < 16_crear_autocares_yegros.sql
mysql -u root -pA76262136.r busops < 17_alter_configuracion_add_empresaid.sql
mysql -u root -pA76262136.r busops < 18_alter_for_facturae.sql
mysql -u root -pA76262136.r busops < 19_create_centros_administrativos.sql
mysql -u root -pA76262136.r busops < 20_alter_configuracion_empresa_facturae.sql
mysql -u root -pA76262136.r busops < 21_insert_cliente_epesec.sql
mysql -u root -pA76262136.r busops < 22_add_cliente_facturae_flag.sql
mysql -u root -pA76262136.r busops < 23_add_certificado_fields.sql
```

**ALTERNATIVA**: Si tienes un backup completo de la base de datos, importarlo directamente:
```bash
mysql -u root -pA76262136.r busops < backup_completo.sql
```

---

## 🚀 INSTALACIÓN DE LA APLICACIÓN EN IIS

### PASO 1: Copiar archivos al servidor

1. Comprimir la carpeta `publish` que se encuentra en:
   ```
   /Users/juanmariacorzo/Documents/BusOps/BusOps/BusOps/publish/
   ```

2. Copiar el archivo ZIP al servidor Windows (por ejemplo, a `C:\inetpub\wwwroot\BusOps\`)

3. Extraer todos los archivos en esa ubicación

4. La estructura debe quedar así:
   ```
   C:\inetpub\wwwroot\BusOps\
   ├── BusOps.dll
   ├── BusOps.exe
   ├── appsettings.json
   ├── appsettings.Production.json
   ├── web.config
   ├── wwwroot\
   │   ├── css\
   │   ├── js\
   │   └── lib\
   └── ... (otros archivos)
   ```

### PASO 2: Configurar permisos de carpeta

1. Clic derecho en la carpeta `C:\inetpub\wwwroot\BusOps\`
2. Propiedades → Seguridad → Editar
3. Agregar usuario: `IIS AppPool\BusOps` (creado en el siguiente paso)
4. Permisos necesarios:
   - ✅ Lectura y ejecución
   - ✅ Mostrar el contenido de la carpeta
   - ✅ Lectura
   - ✅ Escritura (para la carpeta logs)

### PASO 3: Crear carpeta de logs

```powershell
mkdir C:\inetpub\wwwroot\BusOps\logs
```

Dar permisos completos a `IIS AppPool\BusOps` en esta carpeta.

### PASO 4: Configurar IIS

1. **Abrir IIS Manager**
   - Presionar `Win + R`
   - Escribir `inetmgr`
   - Enter

2. **Crear Application Pool**
   - En el panel izquierdo, clic en "Application Pools"
   - Clic derecho → "Add Application Pool"
   - Nombre: `BusOps`
   - .NET CLR version: `No Managed Code`
   - Managed pipeline mode: `Integrated`
   - Clic en "OK"
   
3. **Configurar Application Pool avanzado**
   - Clic derecho en el pool "BusOps" → "Advanced Settings"
   - Configurar:
     - **General**
       - Enable 32-Bit Applications: `False`
     - **Process Model**
       - Identity: `ApplicationPoolIdentity`
       - Idle Time-out (minutes): `20` (o 0 para desactivar)
     - **Recycling**
       - Regular Time Interval (minutes): `1740` (29 horas)
   - Clic en "OK"

4. **Crear Sitio Web**
   - En IIS Manager, expandir "Sites"
   - Clic derecho en "Sites" → "Add Website"
   - Configurar:
     - **Site name**: `BusOps`
     - **Application pool**: `BusOps` (seleccionar el creado)
     - **Physical path**: `C:\inetpub\wwwroot\BusOps`
     - **Binding**:
       - Type: `http`
       - IP address: `All Unassigned` (o la IP específica)
       - Port: `80` (o el puerto que prefieras, ej: `8080`)
       - Host name: (vacío o el dominio, ej: `busops.tudominio.com`)
   - Clic en "OK"

5. **Configurar HTTPS (OPCIONAL pero recomendado)**
   - Si tienes un certificado SSL:
     - Clic derecho en el sitio "BusOps" → "Edit Bindings"
     - Clic en "Add"
     - Type: `https`
     - Port: `443`
     - SSL certificate: (seleccionar tu certificado)
     - Clic en "OK"

### PASO 5: Verificar la configuración

1. **Verificar web.config**
   Abrir `C:\inetpub\wwwroot\BusOps\web.config` y verificar que contenga:
   ```xml
   <environmentVariable name="ASPNETCORE_ENVIRONMENT" value="Production" />
   ```

2. **Verificar appsettings.Production.json**
   Abrir el archivo y verificar la connection string:
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=localhost;Database=busops;User=root;Password=A76262136.r;AllowPublicKeyRetrieval=true;SslMode=none;"
   }
   ```

3. **Iniciar el sitio**
   - En IIS Manager, seleccionar el sitio "BusOps"
   - En el panel derecho, clic en "Start"

---

## 🔍 VERIFICACIÓN Y PRUEBAS

### 1. Probar acceso local
Abrir un navegador en el servidor y navegar a:
- `http://localhost` (o el puerto configurado)
- Debe aparecer la página de login de BusOps

### 2. Revisar logs en caso de error
Si hay problemas, revisar:
```
C:\inetpub\wwwroot\BusOps\logs\stdout_[fecha].log
```

### 3. Verificar conexión a MySQL
```bash
# Desde PowerShell o CMD
mysql -u root -pA76262136.r -e "SELECT COUNT(*) FROM busops.Usuarios;"
```

---

## 🔧 SOLUCIÓN DE PROBLEMAS COMUNES

### Error 500.19 - Error de configuración
- **Causa**: No está instalado el ASP.NET Core Hosting Bundle
- **Solución**: Instalar el bundle y reiniciar el servidor

### Error 502.5 - Error al iniciar el proceso
- **Causa**: .NET Runtime no encontrado o configuración incorrecta
- **Solución**: 
  1. Verificar instalación de .NET 8.0
  2. Revisar logs en la carpeta `logs/`
  3. Ejecutar desde CMD: `dotnet --info` para verificar versión

### La aplicación se inicia pero no conecta a base de datos
- **Causa**: MySQL no accesible o credenciales incorrectas
- **Solución**:
  1. Verificar que MySQL esté corriendo: `services.msc` → MySQL
  2. Probar conexión manual: `mysql -u root -pA76262136.r`
  3. Revisar firewall de Windows

### Error al subir archivos grandes
- **Causa**: Límite de tamaño de request
- **Solución**: Ya está configurado en web.config (100MB), pero si necesitas más:
  ```xml
  <requestLimits maxAllowedContentLength="209715200" /> <!-- 200MB -->
  ```

### Application Pool se detiene constantemente
- **Causa**: Error en la aplicación
- **Solución**:
  1. Revisar logs detallados en `C:\inetpub\wwwroot\BusOps\logs\`
  2. Verificar Event Viewer de Windows: `eventvwr.msc`
  3. Buscar errores en "Windows Logs" → "Application"

---

## 📱 ACCESO DESDE OTROS DISPOSITIVOS

### En red local:
1. Obtener la IP del servidor Windows:
   ```powershell
   ipconfig
   ```
   Buscar "IPv4 Address"

2. Configurar firewall:
   ```powershell
   # Abrir puerto 80 (HTTP)
   New-NetFirewallRule -DisplayName "BusOps HTTP" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
   
   # Abrir puerto 443 (HTTPS) si usas SSL
   New-NetFirewallRule -DisplayName "BusOps HTTPS" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow
   ```

3. Acceder desde otros dispositivos:
   - `http://[IP-DEL-SERVIDOR]`
   - Ejemplo: `http://192.168.1.100`

### Desde Internet (requiere configuración adicional):
1. Configurar port forwarding en el router
2. Usar un dominio o DNS dinámico
3. **MUY RECOMENDADO**: Configurar certificado SSL/TLS

---

## 🔄 ACTUALIZACIONES FUTURAS

Para actualizar la aplicación:

1. Detener el sitio en IIS
2. Hacer backup de la carpeta actual:
   ```powershell
   Copy-Item "C:\inetpub\wwwroot\BusOps" "C:\inetpub\wwwroot\BusOps_backup_[fecha]" -Recurse
   ```
3. Copiar nuevos archivos de la carpeta `publish`
4. Preservar `appsettings.Production.json` si tiene cambios personalizados
5. Iniciar el sitio en IIS

---

## 📞 INFORMACIÓN TÉCNICA

- **Framework**: .NET 8.0
- **Tipo**: Blazor Server (InteractiveServer)
- **Base de datos**: MySQL 8.0+
- **Puerto por defecto**: 80 (HTTP) / 443 (HTTPS)
- **Hosting Model**: In-Process
- **Application Pool**: No Managed Code

---

## ✅ CHECKLIST FINAL

Antes de poner en producción, verificar:

- [ ] .NET 8.0 Hosting Bundle instalado
- [ ] MySQL Server instalado y corriendo
- [ ] Base de datos `busops` creada con todos los scripts
- [ ] Usuario de prueba creado y funcional
- [ ] IIS instalado y configurado
- [ ] Application Pool "BusOps" creado
- [ ] Sitio web "BusOps" creado y iniciado
- [ ] Permisos de carpeta configurados
- [ ] Carpeta `logs` creada con permisos
- [ ] web.config configurado correctamente
- [ ] appsettings.Production.json con connection string correcta
- [ ] Firewall configurado (puertos abiertos)
- [ ] Acceso local funcional (http://localhost)
- [ ] Logs revisados sin errores
- [ ] Login de prueba exitoso

---

**¡BusOps está listo para producción!** 🚌✨

# 🗄️ GUÍA DE INSTALACIÓN DE MYSQL SERVER EN WINDOWS

## 📥 PASO 1: DESCARGAR MYSQL SERVER

### Opción A - Instalador MSI (Recomendado para servidores)

1. **Ir a la página oficial de MySQL**:
   ```
   https://dev.mysql.com/downloads/mysql/
   ```

2. **Seleccionar versión**:
   - Scroll hacia abajo hasta ver "MySQL Community Server"
   - Seleccionar sistema operativo: **Windows**
   - Recomendado: **MySQL Installer for Windows** (mysql-installer-community)

3. **Descargar el instalador completo**:
   - Clic en "Download" del archivo: **mysql-installer-community-x.x.x.msi**
   - Tamaño aproximado: 400-500 MB
   - NO necesitas crear cuenta de Oracle, clic en "No thanks, just start my download"

### Opción B - Instalador Web (Más ligero)

Si prefieres descargar solo lo necesario:
- Descargar: **mysql-installer-web-community-x.x.x.msi** (2-3 MB)
- Descargará los componentes durante la instalación

---

## 💿 PASO 2: EJECUTAR EL INSTALADOR

### 1. Iniciar instalación

1. **Doble clic** en el archivo descargado: `mysql-installer-community-x.x.x.msi`
2. Si aparece UAC (Control de cuentas de usuario), clic en **"Sí"**
3. Esperar a que se inicie el instalador

### 2. Elegir tipo de instalación

Aparecerá la pantalla "Choosing a Setup Type":

**OPCIÓN RECOMENDADA: Server only**
- Seleccionar: **"Server only"**
- Clic en **"Next"**

Esta opción instala solo el servidor MySQL sin herramientas extras (ya tienes Workbench).

**ALTERNATIVA: Custom** (si quieres seleccionar componentes específicos)
- Seleccionar: **"Custom"**
- En la lista de productos disponibles, asegurarte de seleccionar:
  - ✅ MySQL Server 8.x (o la versión más reciente)
  - ✅ MySQL Router (opcional)
- Clic en **"Next"**

### 3. Verificar requisitos

El instalador verificará requisitos previos (como Visual C++ Redistributable).

- Si todo está OK: Clic en **"Execute"** o **"Next"**
- Si faltan componentes: El instalador los instalará automáticamente

### 4. Confirmar instalación

- Revisar que aparezca "MySQL Server" en la lista
- Clic en **"Execute"** para comenzar la instalación
- Esperar a que complete (puede tardar 2-5 minutos)
- Cuando veas "Complete" en verde, clic en **"Next"**

---

## ⚙️ PASO 3: CONFIGURACIÓN DEL SERVIDOR (MUY IMPORTANTE)

Ahora viene la configuración inicial. Sigue estos pasos EXACTAMENTE:

### Pantalla 1: Product Configuration

- Clic en **"Next"** para comenzar la configuración

### Pantalla 2: Type and Networking

**Configuración recomendada**:

1. **Config Type**: 
   - Seleccionar: **"Development Computer"** (para servidor de pruebas)
   - O **"Server Computer"** (para servidor de producción)

2. **Connectivity**:
   - ✅ TCP/IP habilitado
   - Port: **3306** (puerto por defecto)
   - ✅ Open Windows Firewall ports for network access (marcar esta opción)

3. **Advanced Configuration**:
   - ✅ Show Advanced and Logging Options (marcar si quieres más opciones)

4. Clic en **"Next"**

### Pantalla 3: Authentication Method

**MUY IMPORTANTE**:

Aparecerán dos opciones:
- 🔘 Use Strong Password Encryption for Authentication (Recommended) ← **SELECCIONAR ESTA**
- ⚪ Use Legacy Authentication Method

**Seleccionar**: "Use Strong Password Encryption..." (primera opción)

Clic en **"Next"**

### Pantalla 4: Accounts and Roles (CRÍTICO PARA BUSOPS)

**Configurar la contraseña de root**:

1. **MySQL Root Password**: `A76262136.r`
2. **Repeat Password**: `A76262136.r`

**IMPORTANTE**: Esta contraseña DEBE ser exactamente esta porque está configurada en BusOps.

3. **MySQL User Accounts** (OPCIONAL):
   - Puedes agregar usuarios adicionales, pero NO es necesario
   - Para BusOps usaremos el usuario root

4. Clic en **"Next"**

### Pantalla 5: Windows Service

**Configuración del servicio de Windows**:

1. **Configure MySQL Server as a Windows Service**: ✅ (debe estar marcado)

2. **Windows Service Name**: `MySQL80` (o el nombre sugerido)

3. **Start the MySQL Server at System Startup**: ✅ (marcar para que arranque automáticamente)

4. **Run Windows Service as**:
   - Seleccionar: **"Standard System Account"**
   - NO cambiar a custom user

5. Clic en **"Next"**

### Pantalla 6: Server File Permissions (si aparece)

Si aparece esta pantalla:
- Dejar la opción por defecto seleccionada
- Clic en **"Next"**

### Pantalla 7: Apply Configuration

1. Revisar el resumen de configuración
2. Clic en **"Execute"**
3. El instalador aplicará la configuración:
   - ✅ Writing configuration file
   - ✅ Updating Windows Firewall rules
   - ✅ Adjusting Windows service
   - ✅ Initializing database
   - ✅ Starting server
   - ✅ Applying security settings

4. Cuando todo esté en verde, clic en **"Finish"**
5. Clic en **"Next"** en la siguiente pantalla
6. Clic en **"Finish"** para cerrar el instalador

---

## ✅ PASO 4: VERIFICAR LA INSTALACIÓN

### 1. Verificar servicio de Windows

**Método 1 - Interfaz gráfica**:
1. Presionar **Win + R**
2. Escribir: `services.msc`
3. Enter
4. Buscar en la lista: **MySQL80** (o el nombre que pusiste)
5. Verificar que:
   - **Status**: Running (Ejecutándose)
   - **Startup Type**: Automatic (Automático)

**Método 2 - PowerShell**:
```powershell
Get-Service MySQL*
```

Debe mostrar:
```
Status   Name               DisplayName
------   ----               -----------
Running  MySQL80            MySQL80
```

### 2. Verificar que MySQL responde

**Opción A - Desde PowerShell/CMD**:

```bash
# Ir a la carpeta de instalación de MySQL
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

# Conectar a MySQL
mysql -u root -p
```

Cuando pida password, escribir: `A76262136.r`

Deberías ver:
```
Welcome to the MySQL monitor...
mysql>
```

**Probar conexión**:
```sql
SELECT VERSION();
SELECT CURRENT_DATE();
exit
```

**Opción B - Desde MySQL Workbench**:

1. Abrir MySQL Workbench
2. Clic en el icono "+" al lado de "MySQL Connections"
3. Configurar:
   - **Connection Name**: BusOps Local
   - **Hostname**: localhost
   - **Port**: 3306
   - **Username**: root
   - **Password**: Clic en "Store in Vault..." → escribir `A76262136.r`
4. Clic en **"Test Connection"**
5. Si aparece "Successfully made the MySQL connection", ¡está funcionando!
6. Clic en **"OK"**

---

## 🗄️ PASO 5: CREAR BASE DE DATOS BUSOPS

### Opción A - Desde MySQL Workbench (Visual)

1. **Abrir conexión**:
   - Doble clic en la conexión "BusOps Local" creada anteriormente
   - Introducir password si lo pide: `A76262136.r`

2. **Crear base de datos**:
   - En la parte superior, clic en el icono de "Create a new schema in the connected server" (cuadrado amarillo con símbolo +)
   - O ejecutar en el query editor:
   ```sql
   CREATE DATABASE busops CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```
   - Clic en el rayo ⚡ (Execute) o presionar **Ctrl + Enter**

3. **Verificar creación**:
   ```sql
   SHOW DATABASES;
   ```
   
   Debe aparecer "busops" en la lista.

### Opción B - Desde línea de comandos

```bash
# Ir a la carpeta bin de MySQL
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

# Conectar y crear base de datos
mysql -u root -pA76262136.r -e "CREATE DATABASE busops CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Verificar
mysql -u root -pA76262136.r -e "SHOW DATABASES;"
```

---

## 📊 PASO 6: IMPORTAR DATOS DE BUSOPS

Ahora que tienes MySQL Server corriendo y la base de datos creada, importa los datos.

### Método 1 - Scripts individuales (Recomendado)

Si transferiste la carpeta `Database/` con todos los scripts:

```bash
# Ir a la carpeta donde están los scripts SQL
cd C:\ruta\a\Database

# Ejecutar cada script EN ORDEN
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 01_create_tables.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 02_insert_test_data.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 03_alter_clientes_table.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 04_create_proveedores_table.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 04_create_usuarios_table.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 05_alter_conductores_add_autobus.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 05_alter_configuracion_empresa.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 06_alter_proveedores_table.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 06_create_documentos_table.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 07_alter_autobuses_add_fields.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 07_alter_clientes_table.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 08_alter_conductores_add_fields.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 08_alter_facturas_add_cargos_retencion.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 09_alter_lineas_factura_add_tipo.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 10_alter_facturas_add_importe_concepto.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 11_fix_tipo_column_type.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 12_create_presupuestos_table.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 13_alter_configuracion_add_presupuesto_serie.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 14_alter_gastos_add_documento.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 15_multi_tenant_migration.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 16_crear_autocares_yegros.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 17_alter_configuracion_add_empresaid.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 18_alter_for_facturae.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 19_create_centros_administrativos.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 20_alter_configuracion_empresa_facturae.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 21_insert_cliente_epesec.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 22_add_cliente_facturae_flag.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < 23_add_certificado_fields.sql
```

### Método 2 - Backup completo

Si tienes un archivo de backup completo (`busops_backup.sql`):

```bash
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -pA76262136.r busops < C:\ruta\a\busops_backup.sql
```

### Método 3 - Desde MySQL Workbench (Importar dump)

1. Abrir MySQL Workbench y conectar
2. Menú: **Server** → **Data Import**
3. Seleccionar:
   - ⚪ Import from Self-Contained File
   - Buscar el archivo `busops_backup.sql`
   - Default Target Schema: **busops**
4. Clic en **"Start Import"**
5. Esperar a que complete

---

## 🔍 PASO 7: VERIFICAR DATOS IMPORTADOS

### Verificar tablas creadas

```sql
USE busops;
SHOW TABLES;
```

Deberías ver todas las tablas de BusOps:
```
Autobuses
CentrosAdministrativos
Clientes
Conductores
ConfiguracionEmpresa
Documentos
Empresas
Facturas
Gastos
LineasFactura
Mantenimientos
Paradas
Pasajeros
Presupuestos
LineasPresupuesto
Proveedores
Reservas
Rutas
Usuarios
Viajes
```

### Verificar datos de Autocares Yegros

```sql
-- Ver empresas
SELECT * FROM Empresas;

-- Ver configuración
SELECT * FROM ConfiguracionEmpresa WHERE EmpresaId = 1;

-- Contar clientes
SELECT COUNT(*) as TotalClientes FROM Clientes WHERE EmpresaId = 1;

-- Contar conductores
SELECT COUNT(*) as TotalConductores FROM Conductores WHERE EmpresaId = 1;

-- Contar autobuses
SELECT COUNT(*) as TotalAutobuses FROM Autobuses WHERE EmpresaId = 1;

-- Contar facturas
SELECT COUNT(*) as TotalFacturas FROM Facturas WHERE EmpresaId = 1;

-- Ver usuario de prueba
SELECT * FROM Usuarios WHERE Email = 'admin@autocaresyegros.com';
```

Si ves datos en estas consultas, **¡la importación fue exitosa!**

---

## 🌐 PASO 8: CONFIGURAR ACCESO REMOTO (OPCIONAL)

Si necesitas conectarte a MySQL desde otra máquina:

### 1. Modificar configuración de MySQL

Editar el archivo `my.ini`:
```
C:\ProgramData\MySQL\MySQL Server 8.0\my.ini
```

Buscar la línea:
```ini
bind-address = 127.0.0.1
```

Cambiar a:
```ini
bind-address = 0.0.0.0
```

O comentarla:
```ini
#bind-address = 127.0.0.1
```

### 2. Crear usuario remoto (si es necesario)

```sql
-- Permitir root desde cualquier IP (NO recomendado en producción)
CREATE USER 'root'@'%' IDENTIFIED BY 'A76262136.r';
GRANT ALL PRIVILEGES ON busops.* TO 'root'@'%';
FLUSH PRIVILEGES;

-- O crear un usuario específico
CREATE USER 'busops_user'@'%' IDENTIFIED BY 'A76262136.r';
GRANT ALL PRIVILEGES ON busops.* TO 'busops_user'@'%';
FLUSH PRIVILEGES;
```

### 3. Abrir puerto en firewall de Windows

```powershell
New-NetFirewallRule -DisplayName "MySQL Server" -Direction Inbound -LocalPort 3306 -Protocol TCP -Action Allow
```

### 4. Reiniciar servicio MySQL

```powershell
Restart-Service MySQL80
```

---

## 🚨 SOLUCIÓN DE PROBLEMAS

### Error: "El servicio MySQL no inicia"

**Causas comunes**:
1. Puerto 3306 ya en uso por otra aplicación
2. Configuración incorrecta en `my.ini`
3. Permisos insuficientes en carpeta de datos

**Soluciones**:

1. **Verificar puerto en uso**:
   ```powershell
   netstat -ano | findstr :3306
   ```

2. **Ver logs de error**:
   ```
   C:\ProgramData\MySQL\MySQL Server 8.0\Data\[nombre-pc].err
   ```

3. **Reiniciar servicio manualmente**:
   ```powershell
   # Detener
   Stop-Service MySQL80
   
   # Iniciar
   Start-Service MySQL80
   ```

4. **Reinstalar configuración**:
   - Abrir MySQL Installer
   - Seleccionar MySQL Server
   - Clic en "Reconfigure"

---

### Error: "Access denied for user 'root'@'localhost'"

**Solución**:

1. Verificar que estás usando la contraseña correcta: `A76262136.r`

2. Si olvidaste la contraseña, resetearla:
   ```powershell
   # Detener MySQL
   Stop-Service MySQL80
   
   # Iniciar en modo seguro (abrir CMD como Admin)
   cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"
   mysqld --console --skip-grant-tables
   ```
   
   En otra ventana CMD:
   ```sql
   mysql
   FLUSH PRIVILEGES;
   ALTER USER 'root'@'localhost' IDENTIFIED BY 'A76262136.r';
   FLUSH PRIVILEGES;
   exit
   ```
   
   Cerrar primera ventana (Ctrl+C) y reiniciar servicio normalmente.

---

### Error: "Can't connect to MySQL server on 'localhost' (10061)"

**Solución**:

1. Verificar que el servicio está corriendo:
   ```powershell
   Get-Service MySQL*
   ```

2. Si no está corriendo, iniciarlo:
   ```powershell
   Start-Service MySQL80
   ```

3. Verificar que MySQL está escuchando en el puerto:
   ```powershell
   netstat -ano | findstr :3306
   ```

---

### No encuentro mysql.exe en el PATH

**Solución - Agregar MySQL al PATH de Windows**:

1. Buscar en Windows: "Variables de entorno"
2. Clic en "Variables de entorno del sistema"
3. En "Variables del sistema", buscar "Path"
4. Clic en "Editar"
5. Clic en "Nuevo"
6. Agregar: `C:\Program Files\MySQL\MySQL Server 8.0\bin`
7. Clic en "Aceptar" en todas las ventanas
8. Cerrar y volver a abrir PowerShell/CMD

Ahora podrás ejecutar `mysql` desde cualquier ubicación.

---

## ✅ CHECKLIST FINAL

Marca cada item al completarlo:

- [ ] MySQL Server descargado (mysql-installer-community)
- [ ] Instalador ejecutado completamente
- [ ] Puerto 3306 configurado y accesible
- [ ] Contraseña root configurada: `A76262136.r`
- [ ] Servicio MySQL80 corriendo y configurado para inicio automático
- [ ] Conexión exitosa con `mysql -u root -p`
- [ ] Conexión exitosa desde MySQL Workbench
- [ ] Base de datos `busops` creada
- [ ] Scripts SQL importados completamente
- [ ] Tablas verificadas con `SHOW TABLES`
- [ ] Datos verificados (Clientes, Conductores, Facturas, etc.)
- [ ] Usuario de prueba existe: admin@autocaresyegros.com
- [ ] Sin errores en logs de MySQL

---

## 🎯 PRÓXIMOS PASOS

Una vez completado esto:

1. **Ir a la instalación de BusOps**:
   - Seguir la guía `INSTALACION_IIS.md`
   - O ejecutar el script `configurar_iis.ps1`

2. **Verificar connection string** en BusOps:
   ```
   C:\inetpub\wwwroot\BusOps\appsettings.Production.json
   ```
   
   Debe contener:
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=localhost;Database=busops;User=root;Password=A76262136.r;AllowPublicKeyRetrieval=true;SslMode=none;"
   }
   ```

3. **Iniciar sitio en IIS** y probar acceso

---

## 📞 INFORMACIÓN ADICIONAL

**Ubicaciones importantes en Windows**:

- Ejecutable MySQL: `C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe`
- Archivo de configuración: `C:\ProgramData\MySQL\MySQL Server 8.0\my.ini`
- Archivos de datos: `C:\ProgramData\MySQL\MySQL Server 8.0\Data\`
- Logs de error: `C:\ProgramData\MySQL\MySQL Server 8.0\Data\[PC-NAME].err`

**Comandos útiles**:

```powershell
# Ver estado del servicio
Get-Service MySQL*

# Iniciar servicio
Start-Service MySQL80

# Detener servicio
Stop-Service MySQL80

# Reiniciar servicio
Restart-Service MySQL80

# Ver versión de MySQL
mysql --version

# Conectar a MySQL
mysql -u root -pA76262136.r

# Ver bases de datos
mysql -u root -pA76262136.r -e "SHOW DATABASES;"
```

---

**¡MySQL Server está listo para BusOps!** 🚀

Si encuentras algún problema no cubierto en esta guía, revisa los logs de error y verifica que cada paso se completó correctamente.

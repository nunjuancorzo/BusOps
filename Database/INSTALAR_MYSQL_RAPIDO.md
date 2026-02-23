# ⚡ GUÍA RÁPIDA: Instalar MySQL en Windows

## 🎯 LO QUE NECESITAS HACER

Has instalado **MySQL Workbench** (la herramienta visual), pero te falta **MySQL Server** (el motor de base de datos).

---

## 📥 DESCARGA E INSTALACIÓN (15 minutos)

### 1. Descargar MySQL Server

**Enlace directo**:
```
https://dev.mysql.com/downloads/mysql/
```

**Qué descargar**:
- Busca: "MySQL Installer for Windows"
- Archivo: `mysql-installer-community-8.x.x.msi`
- Tamaño: ~400 MB
- Clic en "Download"
- Clic en "No thanks, just start my download"

### 2. Ejecutar instalador

1. **Doble clic** en el archivo `.msi` descargado
2. Clic en "Sí" si aparece UAC
3. **Elegir tipo**: Seleccionar "**Server only**"
4. Clic en "Next" → "Execute" → Esperar instalación
5. Clic en "Next" cuando veas "Complete" en verde

### 3. Configurar servidor (IMPORTANTE)

Después de instalar, aparecerá la configuración:

**Paso A - Type and Networking**:
- Config Type: "Development Computer" o "Server Computer"
- Port: **3306** ✓
- ✅ Marcar "Open Windows Firewall ports"
- Clic "Next"

**Paso B - Authentication**:
- Seleccionar: "Use Strong Password Encryption" (primera opción)
- Clic "Next"

**Paso C - Accounts** ⚠️ **MUY IMPORTANTE**:
```
MySQL Root Password: A76262136.r
Repeat Password: A76262136.r
```
> ⚠️ Esta contraseña DEBE ser exactamente esta porque BusOps la usa

- Clic "Next"

**Paso D - Windows Service**:
- ✅ "Configure MySQL Server as a Windows Service"
- ✅ "Start the MySQL Server at System Startup"
- Clic "Next"

**Paso E - Apply**:
- Clic "Execute"
- Esperar a que todo esté en verde ✓
- Clic "Finish"

---

## ✅ VERIFICAR INSTALACIÓN

### Opción 1: Desde PowerShell

Abrir PowerShell y ejecutar:

```powershell
# Ir a la carpeta de scripts de BusOps
cd C:\ruta\donde\copiaste\Database

# Ejecutar verificación
.\verificar_mysql.ps1
```

Deberías ver:
```
✅ MySQL Server está INSTALADO y FUNCIONANDO
```

### Opción 2: Desde Servicios de Windows

1. Presionar **Win + R**
2. Escribir: `services.msc`
3. Buscar: "MySQL80"
4. Estado debe ser: **"Ejecutándose"**

### Opción 3: Desde MySQL Workbench

1. Abrir MySQL Workbench
2. Clic en "+" al lado de "MySQL Connections"
3. Configurar:
   - Connection Name: **BusOps**
   - Hostname: **localhost**
   - Port: **3306**
   - Username: **root**
   - Password: Clic en "Store in Vault" → escribir `A76262136.r`
4. Clic en "Test Connection"
5. Debe decir: **"Successfully made the MySQL connection"** ✓

---

## 📊 IMPORTAR BASE DE DATOS

Una vez MySQL esté instalado y funcionando:

### Método Automático (Recomendado)

```powershell
# Ir a la carpeta Database
cd C:\ruta\donde\copiaste\Database

# Ejecutar importación
.\importar_database.ps1
```

El script:
- Crea la base de datos `busops`
- Importa todas las tablas
- Carga los datos de Autocares Yegros
- Verifica que todo está correcto

### Método Manual (desde MySQL Workbench)

1. Abrir conexión en MySQL Workbench
2. Clic en el icono "Create Schema" (base de datos)
3. Name: **busops**
4. Charset: **utf8mb4**
5. Apply
6. Ejecutar los scripts SQL uno por uno (01, 02, 03... 23)

---

## 🚨 PROBLEMAS COMUNES

### "No se encuentra mysql.exe"

**Solución**: MySQL está instalado pero no en el PATH

```powershell
# Agregar MySQL al PATH
# Ir a: Sistema → Variables de entorno → Path → Editar → Nuevo
# Agregar: C:\Program Files\MySQL\MySQL Server 8.0\bin
```

### "El servicio MySQL no inicia"

**Solución 1**: Verificar que el puerto 3306 no está en uso

```powershell
netstat -ano | findstr :3306
```

**Solución 2**: Ver logs de error

```
C:\ProgramData\MySQL\MySQL Server 8.0\Data\[nombre-pc].err
```

**Solución 3**: Reiniciar servicio

```powershell
Restart-Service MySQL80
```

### "Access denied for user 'root'"

**Solución**: Verificar que usas la contraseña correcta: `A76262136.r`

Si olvidaste la contraseña, consulta la sección "Error: Access denied" en `INSTALAR_MYSQL_WINDOWS.md`

---

## 📁 ARCHIVOS DE AYUDA

En la carpeta `Database/` encontrarás:

| Archivo | Propósito |
|---------|-----------|
| **verificar_mysql.ps1** | Verifica si MySQL está instalado y corriendo |
| **importar_database.ps1** | Importa automáticamente toda la base de datos |
| **01_create_tables.sql** hasta **23_...sql** | Scripts individuales de base de datos |

---

## 🎯 SIGUIENTE PASO

Una vez MySQL esté instalado y la base de datos importada:

1. **Configurar IIS**:
   ```powershell
   cd C:\inetpub\wwwroot\BusOps
   .\configurar_iis.ps1
   ```

2. **Acceder a BusOps**:
   ```
   http://localhost
   ```

3. **Credenciales de prueba**:
   - Email: `admin@autocaresyegros.com`
   - Contraseña: (la configurada en tu instalación)

---

## 📚 DOCUMENTACIÓN COMPLETA

Si necesitas más detalles, consulta:

- **INSTALAR_MYSQL_WINDOWS.md** - Guía completa paso a paso con capturas
- **INSTALACION_IIS.md** - Instalación de BusOps en IIS
- **RESUMEN_PUBLICACION.md** - Vista general de todo el proceso

---

## ✅ CHECKLIST

- [ ] MySQL Server descargado (mysql-installer-community)
- [ ] Instalador ejecutado con "Server only"
- [ ] Contraseña root configurada: `A76262136.r`
- [ ] Servicio MySQL80 corriendo
- [ ] Conexión exitosa desde MySQL Workbench
- [ ] Base de datos `busops` creada
- [ ] Scripts SQL importados
- [ ] Verificación exitosa con `verificar_mysql.ps1`

---

**¿Necesitas ayuda?** Revisa `INSTALAR_MYSQL_WINDOWS.md` para solución de problemas detallada.

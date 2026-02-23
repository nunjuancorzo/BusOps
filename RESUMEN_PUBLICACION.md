# 📦 RESUMEN: Publicación BusOps para IIS

## ✅ ARCHIVOS GENERADOS

### 1. Carpeta de Publicación
📂 **Ubicación**: `/Users/juanmariacorzo/Documents/BusOps/BusOps/BusOps/publish/`

Esta carpeta contiene:
- Todos los archivos compilados de la aplicación
- Scripts de instalación automatizados
- Configuración optimizada para producción
- Documentación completa

### 2. Archivo ZIP para Transferencia
📦 **Ubicación**: `/Users/juanmariacorzo/Documents/BusOps/BusOps/BusOps/BusOps_Publicacion_IIS.zip`

Este archivo contiene todo lo necesario para la instalación en Windows Server.

### 3. Guía de Instalación Completa
📄 **Ubicación**: `/Users/juanmariacorzo/Documents/BusOps/BusOps/INSTALACION_IIS.md`

Documentación detallada con todos los pasos necesarios.

---

## 🚀 PASOS PARA INSTALAR EN WINDOWS SERVER

### PREPARACIÓN (EN TU MAC)

1️⃣ **Transferir el archivo ZIP al servidor Windows**
   - Archivo: `BusOps_Publicacion_IIS.zip`
   - Métodos: USB, red compartida, OneDrive, o cualquier método de transferencia

2️⃣ **Transferir los scripts de base de datos**
   - Copiar la carpeta completa: `Database/`
   - O crear un backup de tu base de datos actual:
     ```bash
     mysqldump -u root -pA76262136.r busops > busops_backup.sql
     ```

---

### INSTALACIÓN (EN WINDOWS SERVER)

#### 🔹 PASO 1: Extraer archivos
```
Extraer BusOps_Publicacion_IIS.zip → C:\inetpub\wwwroot\BusOps\
```

#### 🔹 PASO 2: Ejecutar instalación automática

Abrir PowerShell **como Administrador** y ejecutar:

```powershell
# Ir a la carpeta
cd C:\inetpub\wwwroot\BusOps

# Permitir ejecución de scripts (solo la primera vez)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 1. Instalar requisitos previos
.\instalar_requisitos.ps1

# ** REINICIAR EL SERVIDOR **

# 2. Configurar sitio en IIS (después de reiniciar)
.\configurar_iis.ps1
```

#### 🔹 PASO 3: Instalar MySQL

1. Descargar: https://dev.mysql.com/downloads/mysql/
2. Instalar con:
   - Usuario: `root`
   - Contraseña: `A76262136.r`
3. Importar base de datos (ver sección siguiente)

---

## 🗄️ BASE DE DATOS

### Opción A: Importar backup completo (Recomendado)

Si transferiste `busops_backup.sql`:

```bash
# Crear base de datos
mysql -u root -pA76262136.r -e "CREATE DATABASE busops CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Importar backup
mysql -u root -pA76262136.r busops < busops_backup.sql
```

### Opción B: Ejecutar scripts individuales

Si transferiste la carpeta `Database/`:

```bash
cd ruta\a\Database

mysql -u root -pA76262136.r -e "CREATE DATABASE busops CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Ejecutar cada script en orden (01, 02, 03, etc.)
mysql -u root -pA76262136.r busops < 01_create_tables.sql
mysql -u root -pA76262136.r busops < 02_insert_test_data.sql
...y así sucesivamente
```

---

## 🌐 ACCESO A LA APLICACIÓN

Una vez completada la instalación:

### Desde el servidor:
```
http://localhost
```

### Desde otros equipos en la red:
```
http://[IP-DEL-SERVIDOR]
```

Para obtener la IP:
```powershell
ipconfig
```

---

## 📁 ESTRUCTURA DE ARCHIVOS EN EL SERVIDOR

```
C:\inetpub\wwwroot\BusOps\
├── 📄 README.md                        ← Instrucciones rápidas
├── 📄 instalar_requisitos.ps1          ← Script 1: Instalar .NET, IIS
├── 📄 configurar_iis.ps1               ← Script 2: Configurar sitio
├── 📄 web.config                       ← Configuración IIS
├── 📄 appsettings.json                 ← Configuración general
├── 📄 appsettings.Production.json      ← Configuración producción ⚙️
├── 📄 BusOps.dll                       ← Aplicación principal
├── 📁 wwwroot/                         ← Archivos estáticos
├── 📁 logs/                            ← Logs de la aplicación
└── ... otros archivos del runtime
```

---

## ⚙️ CONFIGURACIÓN DE PRODUCCIÓN

El archivo `appsettings.Production.json` ya está configurado con:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=busops;User=root;Password=A76262136.r;AllowPublicKeyRetrieval=true;SslMode=none;"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Warning",
      "Microsoft.AspNetCore": "Warning"
    }
  }
}
```

**IMPORTANTE**: Si el servidor MySQL tiene diferente configuración (usuario/contraseña/servidor), editar este archivo antes de iniciar el sitio.

---

## 🔍 VERIFICACIÓN

### Después de la instalación, verificar:

1️⃣ **Servicios corriendo**
```powershell
Get-Service W3SVC     # IIS debe estar "Running"
Get-Service MySQL*    # MySQL debe estar "Running"
```

2️⃣ **Sitio en IIS**
- Abrir IIS Manager (`inetmgr`)
- Verificar que "BusOps" aparece en Sites
- Estado debe ser "Started"

3️⃣ **Acceso web**
- Abrir navegador
- Ir a `http://localhost`
- Debe aparecer la página de login

4️⃣ **Logs limpios**
- Verificar: `C:\inetpub\wwwroot\BusOps\logs\`
- No debe haber errores críticos

---

## ❌ SOLUCIÓN DE PROBLEMAS

### Error 500.19
```powershell
# Reinstalar .NET Hosting Bundle y reiniciar
```

### Error 502.5
```powershell
# Verificar .NET instalado
dotnet --info

# Revisar logs
type C:\inetpub\wwwroot\BusOps\logs\stdout_*.log
```

### No conecta a MySQL
```bash
# Probar conexión manual
mysql -u root -pA76262136.r -e "SELECT VERSION();"

# Si falla, revisar:
# 1. Servicio MySQL corriendo
# 2. Usuario/contraseña correctos
# 3. Firewall de MySQL
```

### No accesible desde red
```powershell
# Abrir puerto en firewall
New-NetFirewallRule -DisplayName "BusOps HTTP" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
```

---

## 📞 INFORMACIÓN DE CONTACTO

- **Email**: infobusops@gmail.com
- **Versión**: Beta 20260219

---

## 📚 DOCUMENTACIÓN ADICIONAL

Para información más detallada:

1. **INSTALACION_IIS.md** - Guía completa paso a paso
2. **README.md** (en publish/) - Instrucciones rápidas
3. Logs de la aplicación en `C:\inetpub\wwwroot\BusOps\logs\`

---

## ✅ CHECKLIST DE INSTALACIÓN

Marca cada paso al completarlo:

- [ ] Transferir `BusOps_Publicacion_IIS.zip` al servidor Windows
- [ ] Transferir scripts de base de datos o backup
- [ ] Extraer ZIP en `C:\inetpub\wwwroot\BusOps\`
- [ ] Ejecutar `instalar_requisitos.ps1` como Admin
- [ ] **REINICIAR EL SERVIDOR**
- [ ] Instalar MySQL Server
- [ ] Importar base de datos
- [ ] Ejecutar `configurar_iis.ps1` como Admin
- [ ] Verificar servicios corriendo (IIS + MySQL)
- [ ] Probar acceso: `http://localhost`
- [ ] Verificar login funcional
- [ ] Probar acceso desde red local
- [ ] Revisar logs sin errores
- [ ] Configurar backup automático de BD (recomendado)
- [ ] Configurar HTTPS (recomendado para producción)

---

**🎉 ¡Todo listo para producción!**

Una vez completado el checklist, BusOps estará corriendo en el servidor Windows y accesible desde cualquier equipo de la red.

---

**Fecha de publicación**: 19 de febrero de 2026  
**Compilado para**: Windows Server / IIS  
**Framework**: .NET 8.0

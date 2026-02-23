# 📦 BusOps - Paquete Completo de Instalación para Windows/IIS

**Versión**: Beta 20260219  
**Plataforma**: Windows Server 2016+ / Windows 10+  
**Framework**: .NET 8.0 + MySQL 8.0+

---

## 🎯 INICIO RÁPIDO - ¿QUÉ HACER PRIMERO?

### Ya tienes MySQL Workbench pero NO MySQL Server:

1. **Lee primero**: [`Database/INSTALAR_MYSQL_RAPIDO.md`](Database/INSTALAR_MYSQL_RAPIDO.md) ⭐
2. Descarga e instala MySQL Server (15 minutos)
3. Verifica con: `Database\verificar_mysql.ps1`
4. Importa datos con: `Database\importar_database.ps1`
5. Luego continúa con BusOps (abajo)

### Ya tienes TODO instalado (MySQL + IIS + .NET):

1. Ir directo a: [`BusOps/publish/README.md`](BusOps/publish/README.md)
2. Ejecutar: `BusOps\publish\configurar_iis.ps1`
3. Acceder a: `http://localhost`

### Instalación desde cero (Windows Server limpio):

Seguir en orden:

**A. Instalar requisitos previos** (20 minutos)
1. Leer: [`INSTALACION_IIS.md`](INSTALACION_IIS.md) - Sección "Requisitos Previos"
2. O ejecutar: `BusOps\publish\instalar_requisitos.ps1`
3. **REINICIAR EL SERVIDOR**

**B. Instalar MySQL** (15 minutos)
1. Leer: [`Database/INSTALAR_MYSQL_RAPIDO.md`](Database/INSTALAR_MYSQL_RAPIDO.md)
2. Descargar e instalar MySQL Server
3. Configurar contraseña root: `A76262136.r`
4. Verificar: `Database\verificar_mysql.ps1`

**C. Importar base de datos** (5 minutos)
1. Ejecutar: `Database\importar_database.ps1`
2. O seguir método manual en la guía

**D. Configurar BusOps en IIS** (10 minutos)
1. Copiar `BusOps/publish/` → `C:\inetpub\wwwroot\BusOps\`
2. Ejecutar: `C:\inetpub\wwwroot\BusOps\configurar_iis.ps1`
3. Acceder: `http://localhost`

---

## 📁 CONTENIDO DEL PAQUETE

```
BusOps_Publicacion_Completa_IIS/
│
├── 📖 README_INICIO.md                    ← ESTE ARCHIVO (empezar aquí)
├── 📖 RESUMEN_PUBLICACION.md             ← Vista general del proceso
├── 📖 INSTALACION_IIS.md                 ← Guía completa de IIS
├── 📖 INSTALAR_MYSQL_WINDOWS.md         ← Guía completa de MySQL
│
├── 📂 BusOps/publish/                    ← Aplicación compilada
│   ├── README.md                         ← Instalación rápida de BusOps
│   ├── instalar_requisitos.ps1          ← Script 1: .NET + IIS
│   ├── configurar_iis.ps1               ← Script 2: Configurar sitio
│   ├── BusOps.dll                       ← Aplicación principal
│   ├── appsettings.Production.json      ← Configuración ⚙️
│   ├── web.config                       ← Configuración de IIS
│   └── wwwroot/                         ← Archivos estáticos
│
└── 📂 Database/                          ← Base de datos
    ├── INSTALAR_MYSQL_RAPIDO.md         ← ⭐ Guía rápida MySQL
    ├── verificar_mysql.ps1              ← Verificar instalación
    ├── importar_database.ps1            ← Importar automática
    └── 01_create_tables.sql ... 23_.sql ← Scripts individuales
```

---

## 🚀 RUTAS DE INSTALACIÓN

Elige la que se ajuste a tu situación:

### 🟢 Ruta 1: Solo necesito instalar MySQL Server

Ya tienes IIS y .NET instalados, solo falta la base de datos.

**Tiempo estimado**: 20 minutos

```
1. Database/INSTALAR_MYSQL_RAPIDO.md
2. Database/verificar_mysql.ps1
3. Database/importar_database.ps1
4. BusOps/publish/configurar_iis.ps1
5. http://localhost ✓
```

### 🟡 Ruta 2: Tengo Windows Server limpio

Necesito instalar todo desde cero.

**Tiempo estimado**: 1 hora

```
1. INSTALACION_IIS.md (Requisitos Previos)
2. BusOps/publish/instalar_requisitos.ps1
3. REINICIAR SERVIDOR
4. Database/INSTALAR_MYSQL_RAPIDO.md
5. Database/importar_database.ps1
6. BusOps/publish/configurar_iis.ps1
7. http://localhost ✓
```

### 🔵 Ruta 3: Instalación manual paso a paso

Quiero entender cada paso y configurar manualmente.

**Tiempo estimado**: 2 horas

```
1. RESUMEN_PUBLICACION.md (leer primero)
2. INSTALAR_MYSQL_WINDOWS.md (completo)
3. INSTALACION_IIS.md (completo)
4. Configuración manual siguiendo las guías
5. http://localhost ✓
```

---

## 📋 CONFIGURACIÓN IMPORTANTE

### Credenciales de MySQL (OBLIGATORIAS)

BusOps está preconfigurado para conectarse con:

```
Servidor: localhost
Puerto: 3306
Base de datos: busops
Usuario: root
Contraseña: A76262136.r
```

**⚠️ IMPORTANTE**: Al instalar MySQL Server, DEBES usar esta contraseña exacta.

Si necesitas cambiarla, editar después:
```
C:\inetpub\wwwroot\BusOps\appsettings.Production.json
```

### Credenciales de BusOps (para hacer login)

Después de importar la base de datos:

```
Email: admin@autocaresyegros.com
Contraseña: (configurada en la base de datos)
```

---

## ✅ CHECKLIST DE INSTALACIÓN COMPLETA

Marca cada paso al completarlo:

### Fase 1: Requisitos Previos
- [ ] Windows Server 2016+ o Windows 10+
- [ ] Cuenta de administrador
- [ ] Conexión a Internet (para descargas)
- [ ] Al menos 5 GB de espacio libre

### Fase 2: Software Base
- [ ] IIS instalado y corriendo
- [ ] .NET 8.0 Hosting Bundle instalado
- [ ] Servidor reiniciado después de .NET
- [ ] MySQL Server 8.0+ instalado
- [ ] Servicio MySQL corriendo

### Fase 3: Base de Datos
- [ ] Conexión MySQL exitosa (root/A76262136.r)
- [ ] Base de datos `busops` creada
- [ ] Scripts SQL importados (23 archivos)
- [ ] Datos verificados en MySQL Workbench

### Fase 4: Aplicación BusOps
- [ ] Archivos copiados a `C:\inetpub\wwwroot\BusOps\`
- [ ] Application Pool "BusOps" creado
- [ ] Sitio web "BusOps" creado en IIS
- [ ] Permisos configurados
- [ ] Sitio iniciado en IIS

### Fase 5: Verificación
- [ ] Acceso local: `http://localhost` ✓
- [ ] Página de login aparece
- [ ] Login exitoso con admin@autocaresyegros.com
- [ ] Dashboard carga correctamente
- [ ] Sin errores en logs

### Fase 6: Red (Opcional)
- [ ] Firewall configurado (puerto 80/443)
- [ ] Acceso desde red local funciona
- [ ] HTTPS configurado (recomendado)

---

## 🔍 VERIFICACIÓN RÁPIDA

Después de instalar, ejecutar estos comandos en PowerShell:

```powershell
# Verificar servicios
Get-Service W3SVC, MySQL*

# Deben mostrar "Running"
```

```powershell
# Verificar puerto IIS
netstat -ano | findstr :80

# Debe mostrar LISTENING
```

```powershell
# Verificar puerto MySQL
netstat -ano | findstr :3306

# Debe mostrar LISTENING
```

```powershell
# Probar MySQL
mysql -u root -pA76262136.r -e "SELECT COUNT(*) FROM busops.Usuarios;"

# Debe mostrar un número (ej: 1)
```

---

## 🚨 SOLUCIÓN DE PROBLEMAS

### Problema: "No encuentro MySQL Server para instalar"

**Solución**: Ir a la sección "Descarga e Instalación" en:
- `Database/INSTALAR_MYSQL_RAPIDO.md` (rápido)
- `INSTALAR_MYSQL_WINDOWS.md` (completo)

**Link directo**: https://dev.mysql.com/downloads/mysql/

---

### Problema: "MySQL Workbench no se conecta"

**Verificar**:

1. Servicio MySQL corriendo:
   ```powershell
   Get-Service MySQL*
   ```

2. Credenciales correctas:
   - Usuario: `root`
   - Contraseña: `A76262136.r`

3. Puerto correcto: `3306`

**Solución**: Ver sección "Verificación" en `Database/INSTALAR_MYSQL_RAPIDO.md`

---

### Problema: "BusOps no inicia (Error 500.19)"

**Causa**: .NET 8.0 Hosting Bundle no instalado o servidor no reiniciado

**Solución**:
1. Ejecutar `BusOps/publish/instalar_requisitos.ps1`
2. REINICIAR el servidor
3. Reiniciar sitio en IIS

---

### Problema: "BusOps no conecta a base de datos"

**Verificar**:

1. MySQL está corriendo
2. Base de datos `busops` existe
3. Usuario root con contraseña correcta
4. Connection string correcto en:
   ```
   C:\inetpub\wwwroot\BusOps\appsettings.Production.json
   ```

**Solución**: Ver logs en `C:\inetpub\wwwroot\BusOps\logs\`

---

### Problema: "No puedo acceder desde otro equipo"

**Solución**:

1. Abrir puerto en firewall:
   ```powershell
   New-NetFirewallRule -DisplayName "BusOps HTTP" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
   ```

2. Obtener IP del servidor:
   ```powershell
   ipconfig
   ```

3. Acceder desde otro equipo: `http://[IP-DEL-SERVIDOR]`

---

## 📞 AYUDA Y DOCUMENTACIÓN

### Documentos incluidos:

| Documento | Propósito | Cuándo leerlo |
|-----------|-----------|---------------|
| **README_INICIO.md** | Este archivo - índice general | Primero |
| **RESUMEN_PUBLICACION.md** | Vista general del proceso | Al planificar |
| **Database/INSTALAR_MYSQL_RAPIDO.md** | Guía rápida MySQL | ⭐ Si falta MySQL |
| **INSTALAR_MYSQL_WINDOWS.md** | Guía completa MySQL | Problemas con MySQL |
| **INSTALACION_IIS.md** | Guía completa IIS + BusOps | Instalación manual |
| **BusOps/publish/README.md** | Instalación rápida BusOps | Si ya tienes todo |

### Scripts útiles:

| Script | Función |
|--------|---------|
| `Database/verificar_mysql.ps1` | Verificar instalación MySQL |
| `Database/importar_database.ps1` | Importar base de datos automáticamente |
| `BusOps/publish/instalar_requisitos.ps1` | Instalar .NET + IIS |
| `BusOps/publish/configurar_iis.ps1` | Configurar sitio en IIS |

---

## 🎓 CONCEPTOS IMPORTANTES

### ¿Qué es IIS?
Internet Information Services - el servidor web de Windows que ejecuta BusOps.

### ¿Qué es MySQL Server vs MySQL Workbench?
- **MySQL Server**: El motor de base de datos (OBLIGATORIO)
- **MySQL Workbench**: Herramienta visual para administrar (opcional pero útil)

### ¿Por qué reiniciar después de instalar .NET?
Windows necesita cargar los nuevos módulos de IIS para .NET 8.0.

### ¿Puedo cambiar la contraseña de MySQL?
Sí, pero debes actualizar `appsettings.Production.json` en BusOps.

---

## 📊 DATOS DE PRUEBA

Después de importar la base de datos, tendrás cargado:

- **Empresa**: Autocares Yegros (EmpresaId = 1)
- **Clientes**: 31 registros
- **Conductores**: 12 registros
- **Autobuses**: 12 unidades
- **Facturas**: 24 registros
- **Presupuestos**: 1 registro
- **Usuario admin**: admin@autocaresyegros.com

---

## 🎯 SIGUIENTE PASO

**Si no tienes MySQL Server instalado**:
👉 Ir a: [`Database/INSTALAR_MYSQL_RAPIDO.md`](Database/INSTALAR_MYSQL_RAPIDO.md)

**Si ya tienes MySQL instalado y funcionando**:
👉 Ir a: [`Database/importar_database.ps1`](Database/importar_database.ps1)

**Si ya tienes la base de datos importada**:
👉 Ir a: [`BusOps/publish/configurar_iis.ps1`](BusOps/publish/configurar_iis.ps1)

---

**¡Bienvenido a BusOps!** 🚌✨

Este paquete contiene todo lo necesario para poner en producción tu sistema de gestión de autobuses. Sigue las guías paso a paso y en menos de 1 hora tendrás BusOps funcionando.

**Contacto**: infobusops@gmail.com  
**Versión**: Beta 20260219  
**Fecha**: 19 de febrero de 2026

---

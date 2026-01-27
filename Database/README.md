# Instrucciones de Configuración de Base de Datos MySQL

## Requisitos Previos
- MySQL Server instalado y en ejecución
- .NET 9.0 SDK instalado

## Paso 1: Crear la Base de Datos y Tablas

Ejecuta los siguientes comandos desde la terminal:

```bash
# Opción 1: Usando mysql desde la terminal
mysql -u root -p < Database/01_create_tables.sql

# Opción 2: Entrar a MySQL y ejecutar el script
mysql -u root -p
source /ruta/completa/a/Database/01_create_tables.sql
```

Cuando se te pida la contraseña, ingresa: `A76262136.r`

## Paso 2: Insertar Datos de Prueba

```bash
# Opción 1: Usando mysql desde la terminal
mysql -u root -p < Database/02_insert_test_data.sql

# Opción 2: Desde MySQL
mysql -u root -p
source /ruta/completa/a/Database/02_insert_test_data.sql
```

## Paso 3: Restaurar Paquetes NuGet

Desde el directorio `BusApp/BusApp`, ejecuta:

```bash
dotnet restore
```

## Paso 4: Ejecutar la Aplicación

```bash
dotnet run
```

## Verificar la Base de Datos

Para verificar que todo se creó correctamente:

```bash
mysql -u root -p
USE busops;
SHOW TABLES;
SELECT COUNT(*) FROM Autobuses;
SELECT COUNT(*) FROM Conductores;
SELECT COUNT(*) FROM Rutas;
```

## Información de Conexión

- **Base de datos:** busops
- **Usuario:** root
- **Contraseña:** A76262136.r
- **Servidor:** localhost
- **Puerto:** 3306 (por defecto)

## Datos de Prueba Incluidos

El script de datos de prueba incluye:
- 1 configuración de empresa
- 5 autobuses
- 5 conductores
- 6 rutas con paradas
- 7 viajes (programados, en curso, completados y cancelados)
- 10 pasajeros
- 15 reservas
- 6 mantenimientos
- 13 gastos
- 6 clientes (particulares, empresas y agencias)
- 5 facturas con líneas de factura

## Solución de Problemas

### Error: "Access denied for user 'root'@'localhost'"
Verifica que la contraseña sea correcta o cambia las credenciales en `appsettings.json` y `appsettings.Development.json`.

### Error: "Can't connect to MySQL server"
Asegúrate de que MySQL esté en ejecución:
```bash
# macOS con Homebrew
brew services start mysql

# O verifica el estado
brew services list
```

### Error relacionado con .NET SDK
Si ves errores relacionados con .NET 9.0, asegúrate de tener instalado el SDK correcto:
```bash
dotnet --version
# Debe mostrar 9.0.x
```

Si no tienes .NET 9.0, descárgalo desde: https://dotnet.microsoft.com/download/dotnet/9.0

## Estructura del Proyecto

```
BusApp/
├── BusApp/
│   ├── Data/
│   │   └── BusOpsDbContext.cs      # Contexto de Entity Framework
│   ├── Models/                      # Modelos de datos
│   ├── Program.cs                   # Configuración de la aplicación
│   └── appsettings.json            # Configuración (incluyendo conexión DB)
└── Database/
    ├── 01_create_tables.sql        # Script de creación de tablas
    └── 02_insert_test_data.sql     # Script de datos de prueba
```

## Notas Importantes

- La cadena de conexión está configurada en `appsettings.json` y `appsettings.Development.json`
- Los enums de C# se mapean como strings en la base de datos
- Las relaciones están configuradas con las restricciones apropiadas (CASCADE, RESTRICT, SET NULL)
- Todos los índices necesarios están creados para mejorar el rendimiento

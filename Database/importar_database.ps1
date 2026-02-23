# Script para importar datos de BusOps a MySQL en Windows
# Ejecutar desde la carpeta donde están los scripts SQL

param(
    [string]$MySQLPath = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    [string]$User = "root",
    [string]$Password = "A76262136.r",
    [string]$Database = "busops",
    [string]$ScriptsPath = "."
)

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  IMPORTACIÓN DE BASE DE DATOS BUSOPS          " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Verificar que existe MySQL
if (-not (Test-Path $MySQLPath)) {
    Write-Host "❌ ERROR: No se encontró MySQL en: $MySQLPath" -ForegroundColor Red
    Write-Host ""
    Write-Host "Ubicaciones comunes:" -ForegroundColor Yellow
    Write-Host "  C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -ForegroundColor White
    Write-Host "  C:\Program Files\MySQL\MySQL Server 8.1\bin\mysql.exe" -ForegroundColor White
    Write-Host ""
    Write-Host "Si MySQL está en otra ubicación, ejecutar:" -ForegroundColor Yellow
    Write-Host '  .\importar_database.ps1 -MySQLPath "C:\ruta\a\mysql.exe"' -ForegroundColor White
    exit 1
}

Write-Host "✓ MySQL encontrado en: $MySQLPath" -ForegroundColor Green
Write-Host ""

# Probar conexión
Write-Host "1. Probando conexión a MySQL..." -ForegroundColor Yellow
$testConnection = & $MySQLPath -u $User -p"$Password" -e "SELECT VERSION();" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ ERROR: No se pudo conectar a MySQL" -ForegroundColor Red
    Write-Host "Verifica:" -ForegroundColor Yellow
    Write-Host "  - Que el servicio MySQL esté corriendo (Get-Service MySQL*)" -ForegroundColor White
    Write-Host "  - Que el usuario sea: $User" -ForegroundColor White
    Write-Host "  - Que la contraseña sea correcta" -ForegroundColor White
    exit 1
}
Write-Host "✓ Conexión exitosa" -ForegroundColor Green
Write-Host ""

# Crear base de datos
Write-Host "2. Creando base de datos '$Database'..." -ForegroundColor Yellow
$createDB = & $MySQLPath -u $User -p"$Password" -e "CREATE DATABASE IF NOT EXISTS $Database CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Base de datos creada o ya existía" -ForegroundColor Green
} else {
    Write-Host "⚠ Advertencia al crear base de datos" -ForegroundColor Yellow
}
Write-Host ""

# Lista de scripts en orden
$scripts = @(
    "01_create_tables.sql",
    "02_insert_test_data.sql",
    "03_alter_clientes_table.sql",
    "04_create_proveedores_table.sql",
    "04_create_usuarios_table.sql",
    "05_alter_conductores_add_autobus.sql",
    "05_alter_configuracion_empresa.sql",
    "06_alter_proveedores_table.sql",
    "06_create_documentos_table.sql",
    "07_alter_autobuses_add_fields.sql",
    "07_alter_clientes_table.sql",
    "08_alter_conductores_add_fields.sql",
    "08_alter_facturas_add_cargos_retencion.sql",
    "09_alter_lineas_factura_add_tipo.sql",
    "10_alter_facturas_add_importe_concepto.sql",
    "11_fix_tipo_column_type.sql",
    "12_create_presupuestos_table.sql",
    "13_alter_configuracion_add_presupuesto_serie.sql",
    "14_alter_gastos_add_documento.sql",
    "15_multi_tenant_migration.sql",
    "16_crear_autocares_yegros.sql",
    "17_alter_configuracion_add_empresaid.sql",
    "18_alter_for_facturae.sql",
    "19_create_centros_administrativos.sql",
    "20_alter_configuracion_empresa_facturae.sql",
    "21_insert_cliente_epesec.sql",
    "22_add_cliente_facturae_flag.sql",
    "23_add_certificado_fields.sql"
)

# Importar scripts
Write-Host "3. Importando scripts SQL..." -ForegroundColor Yellow
Write-Host ""

$scriptCount = 0
$errorCount = 0
$skippedCount = 0

foreach ($script in $scripts) {
    $scriptPath = Join-Path $ScriptsPath $script
    
    if (Test-Path $scriptPath) {
        Write-Host "   📄 Ejecutando: $script" -ForegroundColor Cyan
        
        $result = & $MySQLPath -u $User -p"$Password" $Database -e "source $scriptPath" 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "      ✓ Completado" -ForegroundColor Green
            $scriptCount++
        } else {
            Write-Host "      ⚠ Error al ejecutar (puede ser normal si ya existía)" -ForegroundColor Yellow
            $errorCount++
        }
    } else {
        Write-Host "   ⊘ No encontrado: $script" -ForegroundColor DarkGray
        $skippedCount++
    }
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "           RESUMEN DE IMPORTACIÓN              " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Scripts ejecutados correctamente: $scriptCount" -ForegroundColor Green
Write-Host "Scripts con advertencias: $errorCount" -ForegroundColor Yellow
Write-Host "Scripts no encontrados: $skippedCount" -ForegroundColor DarkGray
Write-Host ""

# Verificar datos
Write-Host "4. Verificando datos importados..." -ForegroundColor Yellow
Write-Host ""

# Ver tablas
Write-Host "Tablas creadas:" -ForegroundColor Cyan
& $MySQLPath -u $User -p"$Password" $Database -e "SHOW TABLES;" 2>$null
Write-Host ""

# Contar registros
Write-Host "Datos de Autocares Yegros (EmpresaId=1):" -ForegroundColor Cyan
$queries = @(
    "SELECT COUNT(*) as Clientes FROM Clientes WHERE EmpresaId = 1;",
    "SELECT COUNT(*) as Conductores FROM Conductores WHERE EmpresaId = 1;",
    "SELECT COUNT(*) as Autobuses FROM Autobuses WHERE EmpresaId = 1;",
    "SELECT COUNT(*) as Facturas FROM Facturas WHERE EmpresaId = 1;",
    "SELECT COUNT(*) as Presupuestos FROM Presupuestos WHERE EmpresaId = 1;"
)

foreach ($query in $queries) {
    & $MySQLPath -u $User -p"$Password" $Database -e $query 2>$null
}

Write-Host ""
Write-Host "Usuario de prueba:" -ForegroundColor Cyan
& $MySQLPath -u $User -p"$Password" $Database -e "SELECT UsuarioId, Email, Empresa FROM Usuarios WHERE Email = 'admin@autocaresyegros.com';" 2>$null

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "         IMPORTACIÓN COMPLETADA ✓              " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "PRÓXIMOS PASOS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Verificar que los datos son correctos" -ForegroundColor White
Write-Host "2. Configurar BusOps en IIS (ejecutar configurar_iis.ps1)" -ForegroundColor White
Write-Host "3. Probar acceso a la aplicación" -ForegroundColor White
Write-Host ""
Write-Host "Credenciales de prueba:" -ForegroundColor Yellow
Write-Host "  Email: admin@autocaresyegros.com" -ForegroundColor Cyan
Write-Host "  Contraseña: (la configurada en la base de datos)" -ForegroundColor Cyan
Write-Host ""

# Script rápido para verificar instalación de MySQL en Windows

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "    VERIFICACIÓN DE MYSQL SERVER               " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Verificar servicio
Write-Host "1. Estado del servicio MySQL:" -ForegroundColor Yellow
$service = Get-Service -Name "MySQL*" -ErrorAction SilentlyContinue

if ($service) {
    Write-Host ""
    $service | Format-Table Name, Status, StartType -AutoSize
    
    if ($service.Status -eq "Running") {
        Write-Host "   ✓ Servicio MySQL está corriendo" -ForegroundColor Green
    } else {
        Write-Host "   ⚠ Servicio MySQL NO está corriendo" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "   Para iniciarlo:" -ForegroundColor Cyan
        Write-Host "   Start-Service $($service.Name)" -ForegroundColor White
    }
} else {
    Write-Host "   ❌ Servicio MySQL NO encontrado" -ForegroundColor Red
    Write-Host "   MySQL Server probablemente NO está instalado" -ForegroundColor Yellow
}

Write-Host ""

# 2. Verificar ejecutable
Write-Host "2. Buscar ejecutable mysql.exe:" -ForegroundColor Yellow

$possiblePaths = @(
    "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.1\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.2\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.3\bin\mysql.exe",
    "C:\Program Files (x86)\MySQL\MySQL Server 8.0\bin\mysql.exe"
)

$found = $false
foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        Write-Host "   ✓ Encontrado: $path" -ForegroundColor Green
        $found = $true
        
        # Verificar versión
        $version = & $path --version 2>&1
        Write-Host "     Versión: $version" -ForegroundColor Cyan
        break
    }
}

if (-not $found) {
    Write-Host "   ❌ No se encontró mysql.exe en ubicaciones comunes" -ForegroundColor Red
    Write-Host "   MySQL Server probablemente NO está instalado" -ForegroundColor Yellow
}

Write-Host ""

# 3. Verificar puerto
Write-Host "3. Puerto 3306 (MySQL):" -ForegroundColor Yellow
$port = netstat -ano | Select-String ":3306"
if ($port) {
    Write-Host "   ✓ Puerto 3306 está en uso (MySQL escuchando)" -ForegroundColor Green
    Write-Host "   $($port[0])" -ForegroundColor Cyan
} else {
    Write-Host "   ❌ Puerto 3306 NO está en uso" -ForegroundColor Red
    Write-Host "   MySQL Server no está ejecutándose o usa otro puerto" -ForegroundColor Yellow
}

Write-Host ""

# 4. Verificar MySQL Workbench
Write-Host "4. MySQL Workbench:" -ForegroundColor Yellow
$workbenchPaths = @(
    "C:\Program Files\MySQL\MySQL Workbench 8.0\MySQLWorkbench.exe",
    "C:\Program Files (x86)\MySQL\MySQL Workbench 8.0\MySQLWorkbench.exe"
)

$workbenchFound = $false
foreach ($path in $workbenchPaths) {
    if (Test-Path $path) {
        Write-Host "   ✓ MySQL Workbench instalado: $path" -ForegroundColor Green
        $workbenchFound = $true
        break
    }
}

if (-not $workbenchFound) {
    Write-Host "   ℹ MySQL Workbench no encontrado en ubicaciones comunes" -ForegroundColor Cyan
}

Write-Host ""

# 5. Probar conexión (si está configurado)
Write-Host "5. Probar conexión:" -ForegroundColor Yellow
if ($found) {
    $mysqlExe = $possiblePaths | Where-Object { Test-Path $_ } | Select-Object -First 1
    
    Write-Host "   Probando conexión con root..." -ForegroundColor Cyan
    $testResult = & $mysqlExe -u root -pA76262136.r -e "SELECT VERSION();" 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ Conexión exitosa con root/A76262136.r" -ForegroundColor Green
        Write-Host "   Versión MySQL: $($testResult -join ' ')" -ForegroundColor Cyan
        
        # Ver bases de datos
        Write-Host ""
        Write-Host "   Bases de datos existentes:" -ForegroundColor Yellow
        & $mysqlExe -u root -pA76262136.r -e "SHOW DATABASES;" 2>$null
    } else {
        Write-Host "   ⚠ No se pudo conectar con las credenciales por defecto" -ForegroundColor Yellow
        Write-Host "   Esto es normal si acabas de instalar MySQL" -ForegroundColor Cyan
        Write-Host "   o si usas otra contraseña" -ForegroundColor Cyan
    }
} else {
    Write-Host "   ⊘ No se puede probar conexión (mysql.exe no encontrado)" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "              RESUMEN                          " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Determinar estado
if ($service -and $service.Status -eq "Running" -and $found) {
    Write-Host "✅ MySQL Server está INSTALADO y FUNCIONANDO" -ForegroundColor Green
    Write-Host ""
    Write-Host "Puedes continuar con:" -ForegroundColor Yellow
    Write-Host "  1. Crear base de datos 'busops'" -ForegroundColor White
    Write-Host "  2. Importar datos (ejecutar importar_database.ps1)" -ForegroundColor White
    Write-Host "  3. Configurar BusOps en IIS" -ForegroundColor White
} elseif ($service -and $found) {
    Write-Host "⚠️ MySQL Server está INSTALADO pero NO está corriendo" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Para iniciarlo:" -ForegroundColor Yellow
    Write-Host "  Start-Service $($service.Name)" -ForegroundColor Cyan
} else {
    Write-Host "❌ MySQL Server NO está instalado o no se detectó" -ForegroundColor Red
    Write-Host ""
    Write-Host "Necesitas instalarlo siguiendo:" -ForegroundColor Yellow
    Write-Host "  INSTALAR_MYSQL_WINDOWS.md" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "O descargar desde:" -ForegroundColor Yellow
    Write-Host "  https://dev.mysql.com/downloads/mysql/" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan

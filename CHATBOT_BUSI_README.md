# Chatbot Busi - Configuración de IA Local

## ¿Qué es Busi?

**Busi** es tu asistente virtual de inteligencia artificial integrado en BusOps. Usa modelos de IA locales (sin necesidad de conexión a servicios externos) para ayudarte con:

- Consultas sobre autobuses, conductores y viajes
- Información sobre reservas y rutas
- Análisis de gastos y mantenimientos
- Explicaciones de funcionalidades de la aplicación
- Consejos sobre gestión de flotas y optimización
- Respuestas rápidas a preguntas generales

## Instalación de Ollama

Busi funciona con **Ollama**, un motor de IA local y gratuito.

### En macOS:

```bash
# Descargar e instalar Ollama
brew install ollama

# O descarga desde https://ollama.ai
```

### En Linux:

```bash
curl -fsSL https://ollama.ai/install.sh | sh
```

### En Windows:

Descarga el instalador desde: https://ollama.ai/download

## Configuración

### 1. Iniciar Ollama

```bash
# Iniciar el servicio Ollama
ollama serve
```

Esto iniciará Ollama en `http://localhost:11434`

### 2. Descargar el modelo

El modelo por defecto es **llama3.2:1b** (pequeño y rápido, ~1.3GB):

```bash
ollama pull llama3.2:1b
```

#### Modelos alternativos:

- **llama3.2:3b** - Más preciso pero más pesado (~2GB)
  ```bash
  ollama pull llama3.2:3b
  ```

- **mistral:7b** - Muy bueno para español (~4GB)
  ```bash
  ollama pull mistral:7b
  ```

### 3. Cambiar el modelo en BusOps

Edita `appsettings.json`:

```json
{
  "Ollama": {
    "Url": "http://localhost:11434",
    "Model": "llama3.2:1b"  // Cambia aquí el modelo
  }
}
```

## Uso

1. Asegúrate de que Ollama esté ejecutándose:
   ```bash
   ollama serve
   ```

2. Abre BusOps en tu navegador

3. Haz clic en el botón flotante morado con el icono de robot en la esquina inferior derecha

4. ¡Comienza a chatear con Busi!

## Ejemplos de preguntas que puedes hacer a Busi

- "¿Cuántos autobuses tenemos actualmente?"
- "¿Cuáles son los conductores más activos?"
- "Muéstrame el balance financiero"
- "¿Qué rutas son las más populares?"
- "¿Cuántos viajes tenemos programados?"
- "¿Cuál es el estado de los mantenimientos?"
- "¿Cómo puedo crear una nueva reserva?"
- "Explícame la gestión de gastos"

## Configuración en Windows con IIS

### Problema: "¿Está Ollama ejecutándose?"

En servidores Windows con IIS, el Application Pool no puede acceder a servicios locales de otros usuarios. Sigue estos pasos:

#### 1. Configurar Ollama para aceptar conexiones de red

Crea el archivo de configuración de Ollama:

**Ubicación**: `C:\Users\TuUsuario\.ollama\config.json`

```json
{
  "origins": ["*"],
  "models": "C:\\Users\\TuUsuario\\.ollama\\models"
}
```

#### 2. Configurar variables de entorno de Ollama

En PowerShell como administrador:

```powershell
# Permitir acceso desde cualquier IP
[Environment]::SetEnvironmentVariable("OLLAMA_HOST", "0.0.0.0:11434", "Machine")

# Reiniciar el servicio de Ollama (si está instalado como servicio)
Restart-Service ollama
```

O si ejecutas Ollama manualmente:

```powershell
$env:OLLAMA_HOST="0.0.0.0:11434"
ollama serve
```

#### 3. Verificar que Ollama está accesible

Desde otra terminal:

```powershell
curl http://127.0.0.1:11434/api/tags
```

Debería devolver la lista de modelos instalados.

#### 4. Configurar BusOps

En el servidor, edita `appsettings.Production.json` (en la carpeta publicada):

```json
{
  "Ollama": {
    "Url": "http://127.0.0.1:11434",
    "Model": "llama3.2:1b"
  }
}
```

**Importante**: Usa `127.0.0.1` en lugar de `localhost` para evitar problemas de resolución DNS.

#### 5. Configurar firewall (si es necesario)

Si Ollama está en otra máquina:

```powershell
# Permitir conexiones al puerto 11434
New-NetFirewallRule -DisplayName "Ollama" -Direction Inbound -Protocol TCP -LocalPort 11434 -Action Allow
```

#### 6. Instalar Ollama como servicio de Windows

Para que Ollama se inicie automáticamente:

1. Descarga NSSM (Non-Sucking Service Manager): https://nssm.cc/download
2. Instala el servicio:

```powershell
# Ejecutar como administrador
nssm install Ollama "C:\Users\TuUsuario\AppData\Local\Programs\Ollama\ollama.exe" "serve"
nssm set Ollama AppEnvironmentExtra OLLAMA_HOST=0.0.0.0:11434
nssm start Ollama
```

### Verificación final

Desde el navegador del servidor, abre:
- http://127.0.0.1:11434

Deberías ver: `Ollama is running`

## Contexto que proporciona Busi

Busi tiene acceso en tiempo real a:

- **Flota**: Número total de autobuses, activos e inactivos
- **Personal**: Conductores activos y sus estadísticas
- **Operaciones**: Viajes programados, en curso y completados
- **Reservas**: Estado de reservas (confirmadas, pendientes, canceladas)
- **Rutas**: Rutas configuradas y su popularidad
- **Finanzas**: Ingresos, gastos, mantenimientos y balance
- **Clientes**: Base de datos de clientes y facturación
- **Rankings**: Top autobuses, conductores y rutas más utilizados

Toda esta información se envía automáticamente al modelo de IA para que pueda responder con datos actualizados de tu empresa.

## Comandos útiles de Ollama

```bash
# Ver modelos instalados
ollama list

# Eliminar un modelo
ollama rm llama3.2:1b

# Actualizar Ollama
brew upgrade ollama  # macOS

# Ver logs de Ollama
journalctl -u ollama -f  # Linux
```

## Solución de problemas

### Error: "No pude procesar tu solicitud"

1. Verifica que Ollama esté ejecutándose:
   ```bash
   curl http://localhost:11434/api/tags
   ```

2. Si no responde, inicia Ollama:
   ```bash
   ollama serve
   ```

3. Verifica que el modelo esté descargado:
   ```bash
   ollama list
   ```

### Error: "Timeout"

El modelo puede estar tardando demasiado en responder. Considera:
- Usar un modelo más pequeño (llama3.2:1b)
- Aumentar los recursos de tu máquina
- Reducir el contexto de la conversación

### Busi no aparece en la interfaz

1. Verifica que hayas reiniciado la aplicación después de la configuración
2. Revisa la consola del navegador (F12) para ver errores de JavaScript
3. Asegúrate de que el componente ChatBox esté correctamente integrado en MainLayout.razor

## Privacidad y Seguridad

- **100% Local**: Todos los datos permanecen en tu servidor
- **Sin conexión externa**: No se envía información a servicios de terceros
- **Control total**: Puedes detener Ollama en cualquier momento
- **Datos privados**: Toda la información de tu empresa se mantiene confidencial

## Mejoras futuras

- Exportación de conversaciones
- Comandos de acción directa ("crear factura", "programar viaje")
- Análisis predictivo de mantenimientos
- Sugerencias de optimización de rutas
- Integración con notificaciones

---

**Nota**: Busi es una herramienta de asistencia y consulta. Siempre verifica la información crítica en la aplicación principal.

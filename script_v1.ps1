
# UBICACION ACTUAL
$ACTUAL_DIR = (Get-Location).Path



function menu {
    Clear-Host
    do {
        $resp = read-host "[🔽] ¿Qué desea realizar?: 
[▶️ ] 1. Actualizar 🔃
[▶️ ] 2. Instalar 📦
[▶️ ] 3. Salir 🚫
[🤔] Seleccione una opcion" 
    } while (
        $resp -ne 1 -and $resp -ne 2 -and $resp -ne 3
    )
    return $resp
}

$resp = menu


function install{
    Write-Warning "[⚒️ ] Comezando la instalacion..."
    if ( Test-Path $ACTUAL_DIR\file.zip) {
        Write-Warning "[⚒️ ] Descomprimiendo el archivo..."
        Expand-Archive -Path $ACTUAL_DIR\file.zip -DestinationPath $ACTUAL_DIR -Force
        Write-Warning "[✅] Archivo descomprimido." 
        Write-Warning "[⚒️ ] Limpiando archivos de instalacion.."
        Remove-Item $ACTUAL_DIR\file.zip
        Write-Warning "[✅] Limpiado."
    } else {
        Write-Warning "[⚒️ ] Descargando nuevamente..."
        Invoke-WebRequest -Uri http://minecraa.duckdns.org/a.zip -OutFile $ACTUAL_DIR\file.zip
        Write-Warning "[✅] Archivo descargado."
        Write-Warning "[⚒️ ] Descomprimiendo el archivo..."
        Expand-Archive -Path $ACTUAL_DIR\file.zip -DestinationPath $ACTUAL_DIR -Force
        Write-Warning "[✅] Archivo descomprimido." 
        Write-Warning "[⚒️ ] Limpiando archivos de instalacion.."
        Remove-Item $ACTUAL_DIR\file.zip
        Write-Warning "[✅] Limpiado."
    }
    Write-Warning "[⚙️] Localizando directorio '.minecraft'"
    if (Test-Path $env:APPDATA/.minecraft) {
        Write-Warning "[✅]Directorio encontrado, indexando..."
        Set-Location $env:APPDATA/.minecraft
        $minecraft_DIR = Get-Location
    } else {
        Write-Warning "[❌] Directorio no encontrado"
        Write-Warning "[⚙️] Creando directorio..."
        do {
            Write-Warning "[✅] El directorio .minecraft no se encontró"
            $resp_ac = read-host "[🔽] Seleccione una opcion: 
[▶️ ] 1. Crear directorio ⚒️
[▶️ ] 2. Salir ❌
[🤔] Seleccione una opcion: " 
        } while (
            $resp_ac -ne 1 -and $resp_ac -ne 2
        )
        if ($resp_ac -eq 1) {
            Write-Warning "[⚙️] Creando directorio..."
            New-Item -ItemType Directory -Force -Path $env:APPDATA/.minecraft
            Set-Location $env:APPDATA/.minecraft
            $minecraft_DIR = Get-Location
            Timeout /T 1
        } elseif ($resp_ac -eq 2) {
            .\script_v1.ps1
        }
        New-Item -ItemType Directory -Path $env:APPDATA/.minecraft
    }
    
    # Buscamos el directorio 'mods'
    Write-Warning "[⚙️] Verificando si existe la carpeta mods..."
    if (Test-Path $env:APPDATA/.minecraft/mods) {
        Write-Host "[⚙️] Removiendo la carpeta mods..."
        Remove-Item $env:APPDATA/.minecraft/mods -Recurse -Force
    } else {
        Write-Host "[❌] La carpeta MODS ya se encuentra eliminada"
    }
    
    # Buscamos el directorio 'config'
    Write-Warning "[⚙️] Verificando si existe la carpeta config..."
    if (test-path $env:APPDATA/.minecraft/config) {
        Write-Host "[⚙️] Removiendo la carpeta config..."
        Remove-Item $env:APPDATA/.minecraft/config -Recurse -Force
    } else {
        Write-Host "[❌] La carpeta CONFIG ya se encuentra eliminada"
    }
    # Movemos la carpeta archivos al directorio .minecraft
    # Write-Warning $ACTUAL_DIR
    # Write-Warning $minecraft_DIR
    Write-Warning "[⚙️] Verificando en la carpeta actual si existe la carpeta mods..."
    if (Test-Path $ACTUAL_DIR\mods) { 
        Write-Host "[⚙️ ]Moviendo dir mods..."
        Get-Item $ACTUAL_DIR/mods | Move-Item -Destination $minecraft_DIR
        Write-Host "[✅ ] Carpeta mods movida exitosamente"
    } else {
        Write-Warning "[❌] Error no se encontro la carpeta mods."
    }
    Write-Warning "[⚙️] Verificando en la carpeta actual si existe la carpeta config..."
    if (Test-Path $ACTUAL_DIR\config) {
        Write-Host "[⚙️ ]Moviendo carpeta config..."
        Get-Item $ACTUAL_DIR/config | Move-Item -Destination $minecraft_DIR
        Write-Host "[✅ ] Carpeta config movida exitosamente"

    } else {
        Write-Host "[❌] Error no se encontro la carpeta config."
    }
}
function actualizar(){
    
    Write-Warning "[⚒️ ] Actualizando..."
    #si encontro el archivo de actualizacion
    if (Test-Path $ACTUAL_DIR/file.zip) {
        do {
            Write-Warning "[✅] El archivo ya se encuentra descargado, seleccione una opcion para continuar!"
            $resp_ac = read-host "[🔽] Seleccione una opcion: 
[▶️ ] 1. Descargar nuevamente 🔃
[▶️ ] 2. Salir 🚫
[🤔] Seleccione una opcion: " 
        } while (
            $resp_ac -ne 1 -and $resp_ac -ne 2
        )
        if ($resp_ac -eq 1) {
            Write-Warning "[⚒️ ] Limpiando archivos previos..."
            Remove-Item $ACTUAL_DIR\file.zip
            Write-Warning "[✅] Limpiado."
            Write-Warning "[⚒️ ] Descargando nuevamente..."
            Invoke-WebRequest -Uri http://minecraa.duckdns.org/a.zip -OutFile $ACTUAL_DIR\file.zip
            Write-Warning "[✅] Archivo descargado."
            Write-Warning "[⚒️ ] Descomprimiendo el archivo..."
            Expand-Archive -Path $ACTUAL_DIR\file.zip -DestinationPath $ACTUAL_DIR -Force
            Write-Warning "[✅] Archivo descomprimido." 
        } elseif ($resp_ac -eq 2) {
            .\script_v1.ps1
        }
    } else {
        Write-Warning "[⚒️ ] Descargando nuevamente..."
        Invoke-WebRequest -Uri http://minecraa.duckdns.org/a.zip -OutFile $ACTUAL_DIR\file.zip
        Write-Warning "[✅] Archivo descargado."
        Write-Warning "[⚒️ ] Descomprimiendo el archivo..."
        Expand-Archive -Path $ACTUAL_DIR\file.zip -DestinationPath $ACTUAL_DIR -Force
        Write-Warning "[✅] Archivo descomprimido." 
        Write-Warning "[⚒️ ] Limpiando archivos de instalacion.."
        Remove-Item $ACTUAL_DIR\file.zip
        Write-Warning "[✅] Limpiado."
    }
}

if ($resp -eq 1) {
    actualizar
} elseif ($resp -eq 2) { 
    install
} elseif ($resp -eq 3) {
    Clear-Host
    Exit
}









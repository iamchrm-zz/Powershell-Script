
# UBICACION ACTUAL
$ACTUAL_DIR = (Get-Location).Path

function menu {
    Clear-Host
    do {
        $resp = read-host "[!] ¿Qué desea realizar?: 
[=>] 1. Actualizar 
[=>] 2. Instalar 
[=>] 3. Salir 
[?] Seleccione una opcion" 
    } while (
        $resp -ne 1 -and $resp -ne 2 -and $resp -ne 3
    )
    return $resp
}

$resp = menu

function install{
    Write-Warning "[WORKING] Comezando la instalacion..."
    if (Test-Path -Path $ACTUAL_DIR\fabric.exe) {
        Write-Warning "[OK] Fabric ya esta descargado"
        Start-Process -FilePath "fabric.exe" -ArgumentList "open" -Wait

    } else {
        Write-Warning "[ERROR] Fabric no encontrado"
        Write-Warning "[LOADING] Descargando..."
        Invoke-WebRequest -Uri http://minecraa.duckdns.org/fabric-0.11.0.exe -OutFile $ACTUAL_DIR\fabric.exe
        Start-Process -FilePath "fabric.exe" -ArgumentList "open" -Wait
    }

    if ( Test-Path $ACTUAL_DIR\file.zip) {
        Write-Warning "[WORKING] Descomprimiendo el archivo..."
        Expand-Archive -Path $ACTUAL_DIR\file.zip -DestinationPath $ACTUAL_DIR -Force
        Write-Warning "[OK] Archivo descomprimido." 
        Write-Warning "[WORKING] Limpiando archivos de instalacion.."
        Remove-Item $ACTUAL_DIR\file.zip
        Write-Warning "[OK] Limpiado."
    } else {
        Write-Warning "[WORKING] Descargando nuevamente..."
        Invoke-WebRequest -Uri http://minecraa.duckdns.org/a.zip -OutFile $ACTUAL_DIR\file.zip
        Write-Warning "[OK] Archivo descargado."
        Write-Warning "[WORKING] Descomprimiendo el archivo..."
        Expand-Archive -Path $ACTUAL_DIR\file.zip -DestinationPath $ACTUAL_DIR -Force
        Write-Warning "[OK] Archivo descomprimido." 
        Write-Warning "[WORKING] Limpiando archivos de instalacion.."
        Remove-Item $ACTUAL_DIR\file.zip
        Write-Warning "[OK] Limpiado."
    }
    Write-Warning "[LOADING] Localizando directorio '.minecraft'"
    if (Test-Path $env:APPDATA/.minecraft) {
        Write-Warning "[OK]Directorio encontrado, indexando..."
        Set-Location $env:APPDATA/.minecraft
        $minecraft_DIR = Get-Location
    } else {
        Write-Warning "[ERROR] Directorio no encontrado"
        Write-Warning "[LOADING] Creando directorio..."
        do {
            Write-Warning "[OK] El directorio .minecraft no se encontró"
            $resp_ac = read-host "[!] Seleccione una opcion: 
[=>] 1. Crear directorio 
[=>] 2. Salir 
[?] Seleccione una opcion: " 
        } while (
            $resp_ac -ne 1 -and $resp_ac -ne 2
        )
        if ($resp_ac -eq 1) {
            Write-Warning "[LOADING] Creando directorio..."
            New-Item -ItemType Directory -Force -Path $env:APPDATA/.minecraft
            Set-Location $env:APPDATA/.minecraft
            $minecraft_DIR = Get-Location
        } elseif ($resp_ac -eq 2) {
            .\script_v1.ps1
        }
    }
    
    # Buscamos el directorio 'mods'
    Write-Warning "[LOADING] Verificando si existe la carpeta mods..."
    if (Test-Path $env:APPDATA/.minecraft/mods) {
        Write-Warning "[LOADING] Removiendo la carpeta mods..."
        Remove-Item $env:APPDATA/.minecraft/mods -Recurse -Force
    } else {
        Write-Warning "[ERROR] La carpeta MODS ya se encuentra eliminada"
    }
    
    # Buscamos el directorio 'config'
    Write-Warning "[LOADING] Verificando si existe la carpeta config..."
    if (test-path $env:APPDATA/.minecraft/config) {
        Write-Warning "[LOADING] Removiendo la carpeta config..."
        Remove-Item $env:APPDATA/.minecraft/config -Recurse -Force
    } else {
        Write-Warning "[ERROR] La carpeta CONFIG ya se encuentra eliminada"
    }
    # Movemos la carpeta archivos al directorio .minecraft
    # Write-Warning $ACTUAL_DIR
    # Write-Warning $minecraft_DIR
    Write-Warning "[LOADING] Verificando en la carpeta actual si existe la carpeta mods..."
    if (Test-Path $ACTUAL_DIR\mods) { 
        Write-Warning "[LOADING] Moviendo dir mods..."
        Get-Item $ACTUAL_DIR/mods | Move-Item -Destination $minecraft_DIR
        Write-Warning "[OK] Carpeta mods movida exitosamente"
    } else {
        Write-Warning "[ERROR] Error no se encontro la carpeta mods."
    }
    Write-Warning "[LOADING] Verificando en la carpeta actual si existe la carpeta config..."
    if (Test-Path $ACTUAL_DIR\config) {
        Write-Warning "[LOADING] Moviendo carpeta config..."
        Get-Item $ACTUAL_DIR/config | Move-Item -Destination $minecraft_DIR
        Write-Warning "[OK] Carpeta config movida exitosamente"

    } else {
        Write-Warning "[ERROR] Error no se encontro la carpeta config."
    }
    Set-Location $ACTUAL_DIR
}
function actualizar(){
    
    Write-Warning "[WORKING] Actualizando..."
    #si encontro el archivo de actualizacion
    if (Test-Path $ACTUAL_DIR/file.zip) {
        do {
            Write-Warning "[OK] El archivo ya se encuentra descargado, seleccione una opcion para continuar!"
            $resp_ac = read-host "[!] Seleccione una opcion: 
[=>] 1. Descargar nuevamente 
[=>] 2. Salir 
[?] Seleccione una opcion: " 
        } while (
            $resp_ac -ne 1 -and $resp_ac -ne 2
        )
        if ($resp_ac -eq 1) {
            Write-Warning "[WORKING] Limpiando archivos previos..."
            Remove-Item $ACTUAL_DIR\file.zip
            Write-Warning "[OK] Limpiado."
            Write-Warning "[WORKING] Descargando nuevamente..."
            Invoke-WebRequest -Uri http://minecraa.duckdns.org/a.zip -OutFile $ACTUAL_DIR\file.zip
            Write-Warning "[OK] Archivo descargado."
            Write-Warning "[WORKING] Descomprimiendo el archivo..."
            Expand-Archive -Path $ACTUAL_DIR\file.zip -DestinationPath $ACTUAL_DIR -Force
            Write-Warning "[OK] Archivo descomprimido." 
        } elseif ($resp_ac -eq 2) {
            .\script_v1.ps1
        }
    } else {
        Write-Warning "[WORKING] Descargando nuevamente..."
        Invoke-WebRequest -Uri http://minecraa.duckdns.org/a.zip -OutFile $ACTUAL_DIR\file.zip
        Write-Warning "[OK] Archivo descargado."
        Write-Warning "[WORKING] Descomprimiendo el archivo..."
        Expand-Archive -Path $ACTUAL_DIR\file.zip -DestinationPath $ACTUAL_DIR -Force
        Write-Warning "[OK] Archivo descomprimido." 
        Write-Warning "[WORKING] Limpiando archivos de instalacion.."
        Remove-Item $ACTUAL_DIR\file.zip
        Write-Warning "[OK] Limpiado."
    }
    Set-Location $ACTUAL_DIR
}

if ($resp -eq 1) {
    actualizar
} elseif ($resp -eq 2) { 
    install
} elseif ($resp -eq 3) {
    Clear-Host
    Exit
}
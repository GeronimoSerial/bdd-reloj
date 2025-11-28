###############################################################################
# CONFIGURACIÓN
###############################################################################

# Ruta del repositorio local donde vas a sincronizar los CSV y el MDB
$repoPath = "C:\Users\geros\Documentos\source\bdd-reloj"

# Ruta del archivo MDB usado por ProSoft
$sourceMdb = "C:\Users\geros\Documentos\source\bdd-reloj\base.mdb"

# Ruta donde instalaste mdbtools para Windows (usando WSL)
# **NOTA:** Se eliminó un espacio invisible/de ruptura aquí.
$sourceMdbWSL = "/mnt/c/Users/geros/Documentos/source/bdd-reloj/base.mdb"

$repoWSL = "/mnt/c/Users/geros/Documentos/source/bdd-reloj"

# Fecha actual
$fecha = (Get-Date -Format "yyyy-MM-dd")

###############################################################################
# 1. COPIAR MDB AL BACKUP HISTÓRICO Y COMO VERSIÓN ACTUAL
###############################################################################

# Crear carpeta historico si no existe
$historicDir = "$repoPath\historico"
if (!(Test-Path $historicDir)) {
    New-Item -ItemType Directory -Force -Path $historicDir | Out-Null
}

# Copia del MDB con fecha (histórico)
Copy-Item $sourceMdb "$repoPath\historico\base-$fecha.mdb" -Force

# Copia del MDB como versión actual
Copy-Item $sourceMdb "$repoPath\base.mdb" -Force

###############################################################################
# 2. EXPORTAR TABLAS A CSV
###############################################################################

Write-Host "Exportando accesos..."
# Asegúrate de que WSL esté configurado y 'mdb-export' esté en el PATH dentro de WSL
wsl mdb-export $sourceMdbWSL "accesos" > "$repoPath\accesos_raw.csv"

Write-Host "Exportando legajos..."
wsl mdb-export $sourceMdbWSL "legajos" > "$repoPath\legajos.csv"


###############################################################################
# 3. FILTRAR ACCESOS SOLO DEL AÑO 2025
###############################################################################

Write-Host "Filtrando accesos del año 2025..."

$raw = Import-Csv "$repoPath\accesos_raw.csv"

# **CORRECCIÓN:** Se simplificó la expresión regular.
# Asumiendo formato DD/MM/AA HH:MM:SS, buscamos /25 seguido por un espacio o el fin de la cadena/valor.
$solo2025 = $raw | Where-Object {
    $_.DIAHORA -match "/25($|\s)"
}

$solo2025 | Export-Csv "$repoPath\accesos_2025.csv" -NoTypeInformation -Encoding UTF8

###############################################################################
# 4. SUBIR TODO A GITHUB
###############################################################################

Write-Host "Subiendo cambios a GitHub..."

# Usar 'Set-Location' (alias 'cd') para cambiar la ubicación
Set-Location $repoPath
git add .
git commit -m "Sync automático $fecha"
git push

Write-Host "Finalizado correctamente."
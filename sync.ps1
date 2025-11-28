###############################################################################
# CONFIGURACIÓN
###############################################################################

# Ruta del repositorio local donde vas a sincronizar los CSV y el MDB
$repoPath = "C:\Users\geros\Documentos\source\bdd-reloj"

# Ruta del archivo MDB usado por ProSoft
$sourceMdb = "C:\Users\geros\Documentos\source\bdd-reloj\base.mdb"

# Ruta del archivo MDB para WSL
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
# 2. EXPORTAR TABLAS A CSV CON DELIMITADOR PUNTO Y COMA (;) 🚀
###############################################################################

Write-Host "Exportando accesos con delimitador ';'"
# Se añade -d ';' para usar punto y coma como separador
wsl mdb-export -d ';' $sourceMdbWSL "accesos" > "$repoPath\accesos_raw.csv"

Write-Host "Exportando legajos con delimitador ';'"
# Se añade -d ';' para usar punto y coma como separador
wsl mdb-export -d ';' $sourceMdbWSL "legajos" > "$repoPath\legajos.csv"


###############################################################################
# 3. FILTRAR ACCESOS SOLO DEL AÑO 2025
###############################################################################

Write-Host "Filtrando accesos del año 2025..."

# **IMPORTANTE:** Al importar, debes especificar el delimitador correcto
$raw = Import-Csv "$repoPath\accesos_raw.csv" -Delimiter ';'

$solo2025 = $raw | Where-Object {
    # Asume formato DD/MM/AA HH:MM:SS, busca /25 seguido por espacio o fin de valor
    $_.DIAHORA -match "/25($|\s)"
}

# **IMPORTANTE:** Al exportar, debes especificar el delimitador punto y coma
$solo2025 | Export-Csv "$repoPath\accesos_2025.csv" -NoTypeInformation -Encoding UTF8 -Delimiter ';'

###############################################################################
# 4. SUBIR TODO A GITHUB
###############################################################################

Write-Host "Subiendo cambios a GitHub..."

Set-Location $repoPath
git add .
git commit -m "Sync automático $fecha"
git push

Write-Host "Finalizado correctamente."
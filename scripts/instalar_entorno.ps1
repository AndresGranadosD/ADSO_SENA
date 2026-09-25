[CmdletBinding()]
param(
    [switch]$SkipMiKTeX
)

$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

function Write-Step {
    param([string]$Message)
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Test-Command {
    param([string]$Name)
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

Write-Host "Configuración del entorno ADSO_SENA para Windows" -ForegroundColor Green
Write-Host "Repositorio: $RepoRoot"

Write-Step "Verificando Python"
$PythonCommand = $null
if (Test-Command 'py') {
    $PythonCommand = 'py'
} elseif (Test-Command 'python') {
    $PythonCommand = 'python'
} else {
    throw "Python no está instalado o no está disponible en PATH. Instálalo desde https://www.python.org/downloads/ y vuelve a ejecutar este script."
}
& $PythonCommand --version

Write-Step "Creando o reutilizando el entorno virtual .venv"
if (-not (Test-Path '.venv\Scripts\python.exe')) {
    & $PythonCommand -m venv .venv
}

$VenvPython = Join-Path $RepoRoot '.venv\Scripts\python.exe'

Write-Step "Actualizando pip e instalando requirements.txt"
& $VenvPython -m pip install --upgrade pip
& $VenvPython -m pip install -r requirements.txt

if (-not $SkipMiKTeX) {
    Write-Step "Verificando herramientas LaTeX"
    $HasLatexmk = Test-Command 'latexmk'
    $HasBiber = Test-Command 'biber'

    if ($HasLatexmk -and $HasBiber) {
        Write-Host "LaTeX, latexmk y biber ya están disponibles." -ForegroundColor Green
    } elseif (Test-Command 'winget') {
        Write-Host "No se detectaron todas las herramientas LaTeX. Se instalará MiKTeX mediante winget." -ForegroundColor Yellow
        Write-Host "Durante o después de la instalación, configure MiKTeX para instalar paquetes faltantes automáticamente." -ForegroundColor Yellow
        winget install --id MiKTeX.MiKTeX --exact --accept-package-agreements --accept-source-agreements
    } else {
        Write-Warning "No se encontró winget. Instale MiKTeX manualmente desde https://miktex.org/download y luego ejecute scripts\verificar_entorno.py."
    }
} else {
    Write-Host "Instalación de MiKTeX omitida por el parámetro -SkipMiKTeX." -ForegroundColor Yellow
}

Write-Step "Verificando el entorno"
& $VenvPython scripts\verificar_entorno.py

Write-Host "`nProceso finalizado." -ForegroundColor Green
Write-Host "Para activar el entorno en una terminal nueva use: .\.venv\Scripts\Activate.ps1"

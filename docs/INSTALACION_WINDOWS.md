# Instalación del entorno en Windows

## Opción recomendada: un solo script

1. Abra la carpeta `ADSO_SENA` con Visual Studio Code.
2. Abra `Terminal > New Terminal`.
3. Ejecute:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\instalar_entorno.ps1
```

El script crea `.venv`, instala todas las dependencias de `requirements.txt`, revisa las herramientas LaTeX y, si es necesario y está disponible `winget`, instala MiKTeX.

## Requisitos previos

- Python instalado y disponible con el comando `py` o `python`.
- Visual Studio Code.
- Recomendado: Administrador de paquetes `winget`, incluido en versiones actuales de Windows.

## Después de instalar

1. En VS Code, presione `Ctrl + Shift + P`.
2. Ejecute `Python: Select Interpreter`.
3. Seleccione el intérprete ubicado en `.venv`.
4. Instale las extensiones recomendadas por el repositorio, especialmente LaTeX Workshop.
5. Ejecute la verificación:

```powershell
.\.venv\Scripts\python.exe .\scripts\verificar_entorno.py
```

## MiKTeX

Si MiKTeX se instala desde el script, abra MiKTeX Console después de terminar y configure la instalación automática de paquetes faltantes como `Always`. Esto permite que LaTeX descargue los paquetes requeridos por cada documento, como `biblatex-apa`.

Después de instalar MiKTeX, cierre y abra nuevamente Visual Studio Code para que los comandos `latexmk`, `biber` y `pdflatex` se actualicen en el PATH.

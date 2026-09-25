# Scripts de entorno

## Windows: instalación automática

Desde la raíz del repositorio, abra PowerShell en Visual Studio Code y ejecute:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\instalar_entorno.ps1
```

El script realiza estas tareas:

1. Verifica que Python esté disponible.
2. Crea o reutiliza el entorno virtual `.venv`.
3. Instala las dependencias de `requirements.txt`.
4. Verifica `latexmk`, `biber` y `pdflatex`.
5. Si falta LaTeX y `winget` está disponible, instala MiKTeX.
6. Ejecuta la comprobación final del entorno.

Para instalar únicamente Python y las dependencias, sin intentar instalar MiKTeX, use:

```powershell
.\scripts\instalar_entorno.ps1 -SkipMiKTeX
```

## Verificación manual

Con el entorno virtual activado, ejecute:

```powershell
.\.venv\Scripts\python.exe .\scripts\verificar_entorno.py
```

La comprobación informa si faltan paquetes Python, herramientas LaTeX o archivos fundamentales de la plantilla.

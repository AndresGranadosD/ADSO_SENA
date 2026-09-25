from __future__ import annotations

import importlib
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REQUIRED_PACKAGES = {
    "yaml": "PyYAML",
    "bibtexparser": "bibtexparser",
    "pylatexenc": "pylatexenc",
}
REQUIRED_COMMANDS = ("latexmk", "biber", "pdflatex")


def status(ok: bool, message: str) -> None:
    symbol = "OK" if ok else "FALTA"
    print(f"[{symbol}] {message}")


def main() -> int:
    print("Verificación del entorno ADSO_SENA")
    print(f"Raíz del repositorio: {ROOT}")
    print(f"Python: {sys.executable}")
    print()

    all_ok = True

    for module, package in REQUIRED_PACKAGES.items():
        try:
            importlib.import_module(module)
            status(True, f"Paquete Python: {package}")
        except ImportError:
            status(False, f"Paquete Python: {package}. Ejecute: python -m pip install -r requirements.txt")
            all_ok = False

    print()
    for command in REQUIRED_COMMANDS:
        available = shutil.which(command) is not None
        status(available, f"Comando LaTeX: {command}")
        if not available:
            all_ok = False

    print()
    template = ROOT / "plantilla" / "plantilla_trabajo.tex"
    bibliography = ROOT / "plantilla" / "referencias.bib"
    status(template.is_file(), "Plantilla LaTeX disponible")
    status(bibliography.is_file(), "Archivo de referencias disponible")

    if not template.is_file() or not bibliography.is_file():
        all_ok = False

    print()
    if all_ok:
        print("Entorno listo para crear y compilar evidencias.")
        return 0

    print("El entorno necesita ajustes. Consulte README.md y ejecute scripts\instalar_entorno.ps1.")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())

# Plantilla de evidencia SENA

Esta carpeta es la base para crear nuevas evidencias en el repositorio. Copie ambos archivos dentro de la ruta correspondiente: `GA[número]/[código de competencia]/[actividad]/[evidencia]/`.

## Configuración dinámica

En `plantilla_trabajo.tex`, edite únicamente el bloque `DATOS CONFIGURABLES` para cambiar el título, código de evidencia, programa, instructor, ficha, centro y fecha.

## Citas y APA

- Registre cada fuente en `referencias.bib`.
- Use `\textcite{clave}` para cita narrativa.
- Use `\parencite{clave}` para cita parentética.
- La sección de referencias se genera automáticamente con `\printbibliography`.

## Compilación

1. Instale MiKTeX o TeX Live con `latexmk`, `biber` y `biblatex-apa`.
2. Abra el proyecto en Visual Studio Code.
3. Instale la extensión LaTeX Workshop.
4. Abra el archivo `.tex` y ejecute `LaTeX Workshop: Build LaTeX project`.

El PDF y los archivos temporales se crean en la carpeta `build/`, que no se sube al repositorio.

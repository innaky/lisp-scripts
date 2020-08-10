# Composite-Cl
Repository in construction.

This repository is a script for mix two imagenes with imagemagick.

## Problema y Uso

* Un directorio padre con directorios y archivos a un nivel de profundidad.
* En el procedimiento se necesita descartar archivos y usar sólo los directorios que contienen las imágenes a procesar.
* Generar una copia exacta del árbol de directorios, la única diferencia que la imagen será una mezcla.
* Usar un transformador de imágenes por línea de comandos.
* Rápido y portable.

```lisp
(composite-run 
  (get-insides (only-paths (cl-fad:list-directory "/home/innaky/directory_father"))))
```
## Notas 

Esto es un script que puede ser resuelto con cualquier lenguaje de scripting (shell, python, perl...), lo importante es
lo gramatical de lisp, la posibilidad para sacar "forks" o derivados, genéricos o menos genéricos según el caso y la
posibilidad de llevarlo a un binario con [cl-launch](https://github.com/fare/cl-launch).

## Usage

## Installation

## Author

* Innaky (innaky@protonmail.com)

## Copyright

Copyright (c) 2020 Innaky (innaky@protonmail.com)

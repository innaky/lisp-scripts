# Lisp Scripts

Repository for lisp scripts, replacing scripting languages.

## Composite

This script apply composite of imagemagick over very much images in a one level directories tree
and build in another directory a mirror of the tree processed.

### Goal

Add a watermark over many images in a pool of directories.

### Problema y Uso (Spanish)

* Un directorio padre con directorios y archivos a un nivel de profundidad.
* En el procedimiento se necesita descartar archivos y usar sólo los directorios que contienen las imágenes a procesar.
* Generar una copia exacta del árbol de directorios, la única diferencia que la imagen será una mezcla.
* Usar un transformador de imágenes por línea de comandos.
* Rápido y portable en sistemas "Unix-like"
* Ejemplo de árbol de directorios y archivos:
``` 
  *- - Father directory 
    |- - some_file0
    |- - some_file1
    *- - directory_one/     _
       | - - image0.png     |
       | - - image1.png     |
       | ...                |  Mix with a watermark
       | - - imageX.png     |
    *- - directory_two/     _
       | - - image1.png     |
       | ...                |   Mix with a watermark
       | - - imageX.png     |
    *- - directory_three/   _
    |- - some file 2
    |- - some file X
    *- - directory_X/       |
```

* Reemplaza estas variables por tus rutas:

** *water* corresponde a la ruta absoluta de la marca de agua.

** *external-dir* Un directorio que aún no existe en tu /home/user


```lisp
(defparameter *water* "/home/innaky/water.png")
(defparameter *external-dir* "/home/innaky/output-dir/")
```

* Leer el script y ejecutar:

```lisp
CL-USER > (load "/home/innaky/src/lisp-scripts/composite.lisp")
CL-USER > (composite-run
           (get-insides
            (path-to-str (only-paths (cl-fad:list-directory "/home/innaky/father_directory/")))))
```

### Notas 

Esto es un script que puede ser resuelto con cualquier lenguaje de scripting (shell, python, perl...),
lo importante es poder reemplazarles, lo gramatical de lisp, la posibilidad para sacar "forks" o
derivados, genéricos o menos genéricos según el caso y la
posibilidad de llevarlo a un binario con [cl-launch](https://github.com/fare/cl-launch), para un
ejemplo revisar el siguiente repositorio [my-busybox-cl](https://github.com/innaky/my-busybox-cl)

## Problem and Usage (English)

* A father directory with some directories and files in one deepend level.
* In the processing is necessary take only the directories.
* Create a mirror of the directory tree, but with the image mixed.
* Use cli command, speed and portable over Unix-like.
* Example tree:

``` 
  *- - Father directory 
    |- - some_file0
    |- - some_file1
    *- - directory_one/     _
       | - - image0.png     |
       | - - image1.png     |
       | ...                |  Mix with a watermark
       | - - imageX.png     |
    *- - directory_two/     _
       | - - image1.png     |
       | ...                |   Mix with a watermark
       | - - imageX.png     |
    *- - directory_three/   _
    |- - some file 2
    |- - some file X
    *- - directory_X/       |
```

* Replace this variables for your paths:

```lisp
(defparameter *water* "/home/innaky/water.png")
(defparameter *external-dir* "/home/innaky/output-dir/")
```

* Read the script and run:

** *water* It's the absolute path of the watermark.

** *external-dir* It's a directory in your /home/user, not exists before run the script.

```lisp
CL-USER > (load "/home/innaky/src/lisp-scripts/composite.lisp")
CL-USER > (composite-run
           (get-insides
            (path-to-str (only-paths (cl-fad:list-directory "/home/innaky/father_directory/")))))
```

### Notes
The big important (for me) here is replace the scripting languages (shell, python... ) by Common Lisp,
another posibility is build binaries with [cl-launch](https://github.com/fare/cl-launch), for an
example check this repository [my-busybox-cl](https://github.com/innaky/my-busybox-cl).

## Author

* Innaky (innaky@protonmail.com)

## Copyright

Copyright (c) 2020 Innaky (innaky@protonmail.com)

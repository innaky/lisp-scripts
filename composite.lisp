(defparameter *water* "/home/innaky/water.png")
(defparameter *external-dir* "/home/innaky/external-dir/")

(defmacro cc-s (&rest strs)
  "Simple macro for concatenate strings."
  `(concatenate 'string ,@strs))

(defun gnu (bin &rest args)
  "A beautiful function for connect lisp with the OS.
For more variants check the documentation of
Mr. François-René Rideau:
https://github.com/fare/inferior-shell#exported-functionality"
  (inferior-shell:run/lines
   (list* bin args)))

(defun output-dir ()
  (gnu "mkdir" *water*))

(defun directory-p (filepath)
  (pathnamep
   (cl-fad:directory-exists-p filepath)))

(defun path-to-str (lst-true-paths)
  "Tranform from true path to string path"
  (mapcar #'(lambda (filepath)
	      (namestring filepath))
	  lst-true-paths))

(defun only-paths (lst-true-paths)
  "Filter the true paths, return a list of directories true paths."
  (if (equal nil lst-true-paths)
      nil 
      (if (directory-p (car lst-true-paths))
	  (cons (car lst-true-paths)
		(only-paths (cdr lst-true-paths)))
	  (only-paths (cdr lst-true-paths)))))

(defun get-insides (lst-directory-str-path)
  "List the files inside of the second directories level."
  (mapcar #'(lambda (directory-str-path)
	      (path-to-str (cl-fad:list-directory directory-str-path)))
	  lst-directory-str-path))

(defun get-filename (str-filepath)
  "From the str path, get the filename."
  (car (last (cl-ppcre:split "/" str-filepath))))

(defun get-base-dirname (str-filepath)
  "From the str path, get the directory name of second level."
  (second (reverse (cl-ppcre:split "/" str-filepath))))

(defun file-exists-p (filepath)
  "Check if a file exists."
  (pathnamep
   (probe-file filepath)))

(defun make-base-dir (str-filepath)
  "Make the external directory for save the transformated images."
  (let ((file-output (cc-s *external-dir* (get-base-dirname str-filepath))))
    (if (file-exists-p file-output)
	(format t "Processing the file: ~A~%" str-filepath)
	(gnu "mkdir" "-p" (cc-s *external-dir* (get-base-dirname str-filepath))))))

(defun out-file-generator (str-filepath)
  "Str path of the external file, necessary for `composite'."
  (let ((base-dir (get-base-dirname str-filepath))
	(filename (get-filename str-filepath)))
    (cc-s *external-dir* base-dir "/" filename)))

(defun small-composite (str-filepath)
  "Make the external directory for save the transformated images and run `composite' for
the file."
  (progn
    (make-base-dir str-filepath)
    (gnu "composite" *water* str-filepath
	 (out-file-generator str-filepath))))

(defun lst-composite-run (lst-str-paths)
  "Apply `composite' over a list of files of a directory."
  (mapc #'(lambda (str-path)
	    (small-composite str-path))
	lst-str-paths))

(defun composite-run (list-of-lst-str-paths)
  "Apply composite over all images in the all directories."
  (mapc #'(lambda (lst-str-paths)
	    (lst-composite-run lst-str-paths))
	list-of-lst-str-paths))

(ql:quickload '(cl-fad cl-ppcre))

(defparameter *characters*
  (concatenate 'string
	       "abcdefghijklmnopqrstuvwxyz"
	       "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	       "0123456789"))

(defun random-elem (lst)
  (aref lst (random (length lst))))

(defun random-string (&optional (length 15))
  "Build a random string, the default is a string with 15 letters"
  (if (equal length 0)
      nil
      (cons (random-elem *characters*)
	    (random-string (- length 1)))))

(defun concatenate-elems-of-lst (lst-of-strings)
  "Receive a list of strings and return the words concatenated in a string."
  (if (equal nil lst-of-strings)
      nil
      (concatenate 'string (car lst-of-strings)
		   (concatenate-elems-of-lst (cdr lst-of-strings)))))

(defun base-path (one-file-path)
  "Build the base-path of the `one-file-path'."
  (reverse
   (cdr
    (reverse
     (cdr (mapcar #'(lambda (elem)
		      (concatenate 'string "/" elem))
		  (cl-ppcre:split "/" one-file-path)))))))

(defun transformation-file (one-file-path)
  "This function return a list with the absolute path of `one-file-path' and with the absolute path
of the new name, and rename the `one-file-path' to the new name."
  (let ((random-name (concatenate 'string (concatenate-elems-of-lst (base-path one-file-path))
				  "/" (random-string))))
    (cons one-file-path
	  (cons random-name nil))
    (rename-file one-file-path random-name)))

(defun hide (db-file directory-to-hide)
  "Save a `db-file' in a path and change the name of the directory `directory-to-hide'."
  (with-open-file (stream db-file
			  :direction :output
			  :if-does-not-exist :create
			  :if-exists :supersede)
    (format stream "~A~%" (mapcar #'(lambda (one-file-path)
				      (transformation-file (namestring one-file-path)))
				  (cl-fad:list-directory directory-to-hide)))))


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

(defun hide (db-file directory-to-hide)
  (with-open-file (stream db-file
			  :direction :output
			  :if-does-not-exist :create
			  :if-exists :supersede)
    (mapc #'(lambda (one-file-path)
		(let ((random-name (concatenate 'string (concatenate-elems-of-lst
							 (base-path (namestring one-file-path)))
						"/" (random-string))))
		  (format stream "~A~%" (concatenate 'string
						     (namestring one-file-path) " " random-name))
		  (rename-file one-file-path random-name)))
	    (cl-fad:list-directory directory-to-hide))))

(defparameter *files* nil)

(defun charge (db-file)
  (with-open-file (stream db-file)
    (when stream
      (loop for line = (read-line stream nil)
	 while line do (push line *files*)))))

(defun unhide ()
  (mapcar #'(lambda (line)
	      (let ((line-file (cl-ppcre:split " " line)))
		(rename-file (cadr line-file) (car line-file))))
	  *files*))

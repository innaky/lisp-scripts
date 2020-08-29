(ql:quickload '(cl-fad cl-ppcre))

(defparameter *characters*
  (concatenate 'string
	       "abcdefghijklmnopqrstuvwxyz"
	       "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	       "0123456789"))

(defun random-elem (lst)
  (aref lst (random (length lst))))

(defun random-string (&optional (length 15))
  (if (equal length 0)
      nil
      (cons (random-elem *characters*)
	    (random-string (- length 1)))))

(defun copy-file (from to)
  "Copy a file `from' a path to another path `to'"
  (with-open-file (input-stream from)
    (with-open-file (output-stream to
				   :direction :output
				   :if-does-not-exist :create
				   :if-exists :supersede)
      (when input-stream
	(loop for line = (read-line input-stream nil)
	     while line do (format output-stream "~A~%" line))))))

(defun mv (from-path to-path)
  "Copy a file in `to-path' and delete of `from-path'"
  (copy-file from-path to-path)
  (delete-file from-path))

(defun concatenate-elems-of-lst (lst-of-strings)
  (if (equal nil lst-of-strings)
      nil
      (concatenate 'string (car lst-of-strings)
		   (concatenate-elems-of-lst (cdr lst-of-strings)))))

(defun base-path (one-file-path)
  (reverse
   (cdr
    (reverse
     (cdr (mapcar #'(lambda (elem)
		      (concatenate 'string "/" elem))
		  (cl-ppcre:split "/" one-file-path)))))))

(defun transformation-not-mv (one-file-path)
  (let ((random-name (concatenate 'string "/" (random-string))))
    (cons one-file-path
	  (cons (concatenate 'string random-name) nil))))

(defun transformation (one-file-path)
  (let ((random-name (concatenate 'string "/" (random-string)))
	(base-file (concatenate-elems-of-lst (base-path one-file-path))))
    (progn
      (cons one-file-path
	    (cons (concatenate 'string random-name) nil))
      (mv one-file-path base-file))))

(defun hide-not-mv (db-file directory-to-hide)
  (with-open-file (stream db-file
			  :direction :output
			  :if-does-not-exist :create
			  :if-exists :supersede)
    (format stream "~A~%" (mapcar #'(lambda (one-file-path)
				      (transformation-not-mv one-file-path))
				  (cl-fad:list-directory directory-to-hide)))))

(defun hide (db-file directory-to-hide)
  (with-open-file (stream db-file
			  :direction :output
			  :if-does-not-exist :create
			  :if-exists :supersede)
    (format stream "~A~%" (mapcar #'(lambda (one-file-path)
				      (let ((random-name (random-string)))
					(cons one-file-path
					      (cons (concatenate 'string random-name) nil))))
				  (cl-fad:list-directory directory-to-hide)))))


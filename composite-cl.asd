(defsystem "composite-cl"
  :version "0.1.0"
  :author "Innaky"
  :license ""
  :depends-on ("inferior-shell"
               "cl-fad"
               "cl-ppcre")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "composite-cl/tests"))))

(defsystem "composite-cl/tests"
  :author "Innaky"
  :license ""
  :depends-on ("composite-cl"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for composite-cl"
  :perform (test-op (op c) (symbol-call :rove :run c)))

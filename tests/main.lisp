(defpackage composite-cl/tests/main
  (:use :cl
        :composite-cl
        :rove))
(in-package :composite-cl/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :composite-cl)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))

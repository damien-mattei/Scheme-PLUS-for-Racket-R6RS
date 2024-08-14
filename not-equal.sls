#!r6rs


;; /Applications/Racket\ v8.13/bin/plt-r6rs --install not-equal.scm


(library (not-equal) ; R6RS


  (export <>
	  ≠ )

  (import (rnrs base (6)))



;; not equal operator for numbers

;; scheme@(guile-user)> (<> 1 2)
;; #t
;; scheme@(guile-user)> {1 <> 2}
;; #t
;; scheme@(guile-user)> {1 <> 1}
;; #f


(define (<> x y)
  (not (= x y)))

(define (≠ x y)
  (not (= x y)))


) ; end library

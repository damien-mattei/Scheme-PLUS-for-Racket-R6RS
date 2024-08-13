#!r6rs


;; /Applications/Racket\ v8.13/bin/plt-r6rs --install --force bitwise.scm


(library (bracket-apply) ; R6RS


  (export << >>
	  & ∣ )

  (import (rnrs base (6))
	  (rnrs arithmetic bitwise (6)) )


(define (<< x n)
  (bitwise-arithmetic-shift x n))

(define (>> x n)
  (bitwise-arithmetic-shift x (- n)))

(define & bitwise-and)
(define ∣ bitwise-ior) ;; this is U+2223  because vertical line is reserved in Racket


) ; end library


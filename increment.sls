#!r6rs

;; /Applications/Racket\ v8.13/bin/plt-r6rs --install increment.scm 

(library (increment)

  (export incf
	  add1)
  
  (import (rnrs base (6)))
  


;; increment variable
;; this is different than add1 in DrRacket
(define-syntax incf
  (syntax-rules ()
    ((_ x)   (begin (set! x (+ x 1))
		    x))))

(define-syntax add1
  (syntax-rules ()
    ((_ x)   (+ x 1))))

) ; end library

#!r6rs


;; /Applications/Racket\ v8.13/bin/plt-r6rs --install exponential.scm


(library (exponential) ; R6RS


  (export ** )

  (import (rnrs base (6)))


;; coding hint: use only macro when necessary

;; (define-syntax **
;;   (syntax-rules ()
;;     ((_ a b) (expt a b))))

;; (define (** a b)
;;   (expt a b))

(define ** expt)
;;(define mod modulo)


) ; end library



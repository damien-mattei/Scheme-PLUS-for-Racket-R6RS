#lang reader SRFI-105

;; Scheme+ REPL for Racket R6RS with SRFI 105 Curly Infix


#!r6rs


(library (r6rs-srfi-105-repl)

  (export)

  (import

   (except (rnrs base (6)) if define) ; Scheme+ has its own 'if' compatible with Scheme's 'if' and its own 'define'

   ;; example:
   ;; (rename (rnrs base (6)) (+ orig+)
   ;;                         (if if-rnrs))

   (only (srfi :43) vector-append)
   
   (rnrs syntax-case (6))
   
   (only (racket) print-mpair-curly-braces print-as-expression)
   
   (only (rnrs control (6)) when)
   
   (only (rnrs io simple (6)) display newline)


   (Scheme+R6RS)

   ;;(Scheme+R6RS def-nfx)

   ;;(Scheme+R6RS n-arity)
  
   ) ; end import

  (print-as-expression #f) ; print (a b) instead of (mcons a (mcons b '()))
  
  ;; display mutable list { } with classic ( ).
  (print-mpair-curly-braces #f)

  ;; example:
  ;; (define-overload-existing-operator + orig+)
  ;; (overload-existing-operator + vector-append (vector? vector?))
  ;; (define rv {(vector 1 2 3 3.5) + (vector 4 5 6 7)})
  ;; (display rv) (newline)

  ;; (for ({i := 0} {i < 5} {i := i + 1})
  ;;      {x := 7}
  ;;      (display {x + i})
  ;;      (newline) )


) ; end REPL module

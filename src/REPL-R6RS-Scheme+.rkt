;; Scheme+ REPL for Racket R6RS


#!r6rs


(library (r6rs-repl)

  (export)

  (import

   (except (rnrs base (6)) if) ; Scheme+ has it own 'if' compatible with Scheme's 'if'

   ;; example
   ;; (rename (rnrs base (6)) (+ orig+)
   ;;                         (if if-rnrs))

   (only (srfi :43) vector-append)
   
   (rnrs syntax-case (6))
   
   (only (racket) print-mpair-curly-braces)
   
   (only (rnrs control (6)) when)
   
   (only (rnrs io simple (6)) display newline)


   (Scheme+R6RS)
  
   ) ; end import

  ;; display { } as they are.
  (print-mpair-curly-braces #f)


  ;; example :
  
  ;; (define-overload-existing-operator + orig+)
  ;; (overload-existing-operator + vector-append (vector? vector?))
  ;; (define rv (+ (vector 1 2 3 3.5) (vector 4 5 6 7)))
  ;; (display rv) (newline)

  ;; (for ((define i 0) (< i 5) (set! i (+ i 1))) (define x 7) (display i) (newline) )


) ; end REPL module

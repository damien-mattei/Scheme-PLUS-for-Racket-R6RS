#!r6rs

(library (test) ; R6RS

  (export if)
  
  (import (except (rnrs base (6)) if)

	  ;;(rnrs syntax-case (6))
	  (for (rnrs base (6)) expand) ; import at expand phase (not run phase)
	  (for (rnrs syntax-case (6)) expand)
	  )

  ;;(define if 7)


  (define-syntax if
  
    (lambda (stx)
    
      (syntax-case stx (then else)
	
	((if tst ...)  7))))

  )


#!r6rs



(library (Scheme+)  ; works also with (main) , (Scheme-PLUS-for-Racket-R6RS) 

  (export if)

  (import

   ;; definition and block
   (Scheme+ def)
   (Scheme+ declare)
   (Scheme+ block)

   ;; overloading
   (Scheme+ overload)

   ;; infix notation,indexing,slicing and assignment
   (Scheme+ slice)
   (Scheme+ bracket-apply)
   (Scheme+ assignment)
   (Scheme+ nfx)

   ;; control: if then else
   (Scheme+ if-then-else)

   ;; iteration
   (Scheme+ for_next_step)
   (Scheme+ range)

   ;; control
   (Scheme+ condx)
   (Scheme+ when-unless)
   (Scheme+ while-do)
   (Scheme+ repeat-until)

   ;; operators
   (Scheme+ not-equal)
   (Scheme+ exponential)
   (Scheme+ bitwise)
   (Scheme+ modulo)

   ) ; end import


  ) ; end library

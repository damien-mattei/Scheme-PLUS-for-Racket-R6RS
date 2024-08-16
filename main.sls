#!r6rs



(library (Scheme+)  ; works also with (main) , (Scheme-PLUS-for-Racket-R6RS) 

  (export

   
   ;; definition and block
   
   def
   <+ ;;+> not allowed in R6RS
   ⥆ ⥅
   :+ ;;+:
   declare
   $> ; begin
   ; (let () ...
   $+> 
   begin-def


   
   ;; infix notation,indexing,slicing and assignment

   : ; slice symbol
   $nfx$ ; infix
   $bracket-apply$ ; [ ]
   <- ->
   ← →
   :=  =:
   ;; multiple values assignment
   <v v>
   ⇜ ⇝

   ;; control: if then else
   if

   ;; iteration
   for
   for-basic
   for-next
   for-basic/break
   for-basic/break-cont
   for/break-cont
   for-each-in

   
   ;; control
   condx
   repeat
   do
   unless
   while


   
   ;; operators
   <> ≠
   **
   %
   << >>
   &
   ∣ ; warning: this pipe could be a special character (different from keyboard stroke)


   

   ;; overloading
   define-overload-procedure
   overload-procedure
   
   define-overload-existing-procedure
   overload-existing-procedure
   
   define-overload-operator
   overload-operator
   
   define-overload-existing-operator
   overload-existing-operator
   
   define-overload-n-arity-operator
   overload-n-arity-operator
   
   define-overload-existing-n-arity-operator
   overload-existing-n-arity-operator
   
   overload-square-brackets

   find-getter-for-overloaded-square-brackets
   find-setter-for-overloaded-square-brackets
	 
   
   )


  

  (import

   ;; definition and block
   (Scheme+ def)
   (Scheme+ declare)
   (Scheme+ block)

   
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

   ;; overloading
   (Scheme+ overload)


   ) ; end import


  ) ; end library

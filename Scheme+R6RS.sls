;; This file is part of Scheme+ for Racket/R6RS

;; Copyright 2023-2024 Damien MATTEI

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; version 9.7

#!r6rs



(library (Scheme+R6RS)  ; works also with (main) , (Scheme-PLUS-for-Racket-R6RS) 

  (export

   
   ;; definition and block
   
   def
   define
   define-infix
   
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

   ;; sequence
   in-range
   reversed
   
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
   (Scheme+R6RS def)
   (Scheme+R6RS def-nfx) ; infix define
   (Scheme+R6RS declare)
   (Scheme+R6RS block)

   
   ;; infix notation,indexing,slicing and assignment
   (Scheme+R6RS slice)
   (Scheme+R6RS bracket-apply)
   (Scheme+R6RS assignment)
   (Scheme+R6RS nfx)

   ;; control: if then else
   (Scheme+R6RS if-then-else)

   ;; iteration
   (Scheme+R6RS for_next_step)
   (Scheme+R6RS range)

   ;; control
   (Scheme+R6RS condx)
   (Scheme+R6RS when-unless)
   (Scheme+R6RS while-do)
   (Scheme+R6RS repeat-until)

   ;; operators
   (Scheme+R6RS not-equal)
   (Scheme+R6RS exponential)
   (Scheme+R6RS bitwise)
   (Scheme+R6RS modulo)

   ;; overloading
   (Scheme+R6RS overload)


   ) ; end import


  ) ; end library

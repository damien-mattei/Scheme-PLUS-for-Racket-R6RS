;; This file is part of Scheme+R6RS

;; Copyright 2024 Damien MATTEI

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



#!r6rs
  
(library (operators-list)

  (export definition-operator
	  assignment-operator
	  exponential-operator
	  
	  infix-operators-lst-for-parser
	  
	  definition-operator-syntax
	  assignment-operator-syntax
	  exponential-operator-syntax
	  
	  infix-operators-lst-for-parser-syntax
	  get-infix-operators-lst-for-parser-syntax ; for Kawa
	  
	  operators-lst
	  operators-lst-syntax)

  (import
   (rnrs base (6))
   (only (racket) syntax))


(define definition-operator (list '<+ ;'+> ; commented because lexically forbidden in R6RS
				  '⥆ '⥅
				  ':+ ;'+:
				  ))

(define assignment-operator (list '<- '->
				  '← '→
				  ':=  '=:
				  '<v 'v>
				  '⇜ '⇝))

(define exponential-operator (list 'expt '**))


(define infix-operators-lst-for-parser

  (list
    
   exponential-operator
   
   (list '* '/ '%)
 
   (list '+ '-)
   
   (list '<< '>>)
   
   (list '&)
   (list '^)
   (list '∣)
   
   (list '< '> '= '≠ '<= '>= '<>)

   (list 'and)
   
   (list 'or)
    
   (append assignment-operator 
	   definition-operator)
     
   )
  
  )



  
(define definition-operator-syntax (list #'<+ ;#'+>
					 #'⥆ #'⥅
					 #':+ ;#'+:
					 ))

(define assignment-operator-syntax (list #'<- #'->
					 #'← #'→
					 #':= '=:
					 #'<v #'v>
					 #'⇜ #'⇝))


(define exponential-operator-syntax (list #'expt #'**))


(define infix-operators-lst-for-parser-syntax

  (list
    exponential-operator-syntax
    (list #'* #'/ #'%)
    (list #'+ #'-)
	
    (list #'<< #'>>)

    (list #'& #'∣)

    (list #'< #'> #'= #'≠ #'<= #'>= #'<>)

    (list #'and)

    (list #'or)

    assignment-operator-syntax
    definition-operator-syntax 
    )

  )


(define (get-infix-operators-lst-for-parser-syntax)
  infix-operators-lst-for-parser-syntax)



;; liste à plate des operateurs
(define operators-lst
  (apply append infix-operators-lst-for-parser))

(define operators-lst-syntax
  (apply append infix-operators-lst-for-parser-syntax))



) ; end module

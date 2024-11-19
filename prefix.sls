;; prefix

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

;; R6RS version



#!r6rs


(library (prefix) ; R6RS

  (export prefix?)

  (import (rnrs base (6))
	  (Scheme+R6RS operators)
	  (only (racket) syntax?))

  ;; test if a sexpr is prefix expression but only at the upper level (do not dive in the arguments) 
  (define (prefix? expr)

    ;;(display "prefix? : expr =")(display expr)(newline)

    (define rv
      (cond ((not (list? expr))
	     #t)
	    
	    ((null? expr)
	     #t)
	    
	    ((and (syntax? (car expr))
		  (operator-syntax? (car expr))) ; operator at first position
	     #t)

	    ((and (syntax? (cadr expr))
		  (operator-syntax? (cadr expr))) ; forbid operator in prefix expression in second position
	     ;; it is not true to pass operator to a procedure as first argument , you will have to hide them in a variable
	     #f)

	    (else (or (operator? (car expr)) ; operator in first position
		      (not (operator? (cadr expr))))))) ; not operator in second position

    ;;(display "prefix? : rv=")(display rv)(newline)
    rv)



  ) ; end module

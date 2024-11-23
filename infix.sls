;; check that expression is infix


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

;; /Applications/Racket\ v8.13/bin/plt-r6rs --install infix.scm
;; /Applications/Racket\ v8.13/bin/plt-r6rs --install --force infix.scm


#!r6rs


(library (infix)

  (export infix?
	  simple-infix-list-syntax?)

  (import (rnrs base (6))
	  (Scheme+R6RS syntax))

  

  
;; modified for syntax too


;; Welcome to DrRacket, version 8.13 [cs].
;; Language: r6rs, with debugging; memory limit: 8192 MB.
;; > (infix? '(2 + 3 -) operators-lst)
;; #f
;; > (infix? '(2 + 3) operators-lst)
;; #t
;; > (infix? '(+ 2 3) operators-lst)
;; #f
;; > (infix? '(+ 2 3 4) operators-lst)
;; #f
;; > (infix? '(3) operators-lst)
;; #f
;; > (infix? '3 operators-lst)
;; #t

(define (infix? expr oper-lst)

  ;;(display "infix? : expr=") (display expr) (newline)
  ;;(display "infix? : oper-lst=") (display oper-lst) (newline)
  
  (define (infix-rec? expr) ; (op1 e1 op2 e2 ...)
    ;;(display "infix-rec? : expr=") (display expr) (newline)
    (if (null? expr)
	#t
    	(and (not (null? (cdr expr))) ; forbids: op1 without e1
	     (member-syntax (car expr) oper-lst) ;; check (op1 e1 ...) 
	     (not (member-syntax (cadr expr) oper-lst)) ; check not (op1 op2 ...)
	     (infix-rec? (cddr expr))))) ; continue with (op2 e2 ...) 


  (define rv
    (cond ((not (list? expr)) (not (member-syntax expr oper-lst))) ; ex: 3 , not an operator ! 
	  ((null? expr) #t) ; definition
	  ((null? (cdr expr)) #t) ;#f) ; (a)  allowed or not as infix
	  (else
	   (and (not (member-syntax (car expr) oper-lst)) ; not start with an operator !
		(infix-rec? (cdr expr)))))) ; sublist : (op arg ...) match infix-rec
  
  ;;(display "infix? : rv=") (display rv) (newline)

  rv
  
  )


 ; Return true if lyst has an even # of parameters, and the (alternating)
  ; first parameters are "op".  Used to determine if a longer lyst is infix.
  ; If passed empty list, returns true (so recursion works correctly).
  
  (define (even-and-op-prefix-syntax? op lyst)
    (cond
      ((null? lyst) #t)
      ((not (pair? lyst)) #f)
      ((not (datum=? op (car lyst))) #f) ; fail - operators not the same
      ((not (pair? (cdr lyst)))  #f) ; Wrong # of parameters or improper
      (#t   (even-and-op-prefix-syntax? op (cddr lyst))))) ; recurse.

  ; Return true if the lyst is in simple infix format
  ; (and thus should be reordered at read time).
  
  (define (simple-infix-list-syntax? lyst)
    (and
      (pair? lyst)           ; Must have list;  '() doesn't count.
      (pair? (cdr lyst))     ; Must have a second argument.
      (pair? (cddr lyst))    ; Must have a third argument (we check it
                             ; this way for performance)
      (even-and-op-prefix-syntax? (cadr lyst) (cdr lyst)))) ; true if rest is simple

 



) ; end library


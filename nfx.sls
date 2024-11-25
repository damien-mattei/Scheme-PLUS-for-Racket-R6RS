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


(library (nfx) ; R6RS


  (export $nfx$)

  (import (rnrs base (6))
	  (for (rnrs base (6)) expand) ; import at expand phase (not run phase)
	  (for (rnrs syntax-case (6)) expand)
	  
	  (for (Scheme+R6RS n-arity) expand) ; at phase: 1; the transformer environment
	  (for (Scheme+R6RS infix-with-precedence-to-prefix) expand) ; at phase: 1; the transformer environment
	  (for (Scheme+R6RS operators-list) expand)
	  (for (Scheme+R6RS operators) expand);; at phase: 1; the transformer environment
	  (for (Scheme+R6RS infix) expand)
	  
	  (for (only (rnrs io simple (6)) display newline) expand)
	  (for (only (rnrs control (6)) when) expand)
	  (for (only (racket) syntax->list) expand)
	  (for (compatibility mlist) expand)
	  ;; (for (only (racket) print-mpair-curly-braces print-as-expression) expand)
	  ;; (only (racket) print-mpair-curly-braces print-as-expression)
	  )





;; Welcome to DrRacket, version 8.13 [cs].
;; Language: r6rs, with debugging; memory limit: 8192 MB.
;; > ($nfx$ 3 * 5 + 2)
;; $nfx$ : parsed-args={.#<syntax:15-interactions from an unsaved editor:3:15 +> {.#<syntax:15-interactions from an unsaved editor:3:11 *> .#<syntax:15-interactions from an unsaved editor:3:9 3> .#<syntax:15-interactions from an unsaved editor:3:13 5>} .#<syntax:15-interactions from an unsaved editor:3:17 2>}
;; 17

(define-syntax $nfx$

  (lambda (stx)
    
    (syntax-case stx ()

      (($nfx$ expr)

       (with-syntax
			 
	   ((parsed-args

	     (begin

	       ;; (print-as-expression #f) ; print (a b) instead of (mcons a (mcons b '()))
  
	       ;; ;; display mutable list { } with classic ( ).
	       ;; (print-mpair-curly-braces #f)

	     
		 ;;(display "$nfx$: #'(expr)=") (display #'(expr)) (newline)

	     
	       (car ;  probably because the result will be encapsuled in a list !
		;; apply operator precedence rules
		(!*prec-generic-infix-parser
		 ;; (list->mlist
		 ;;  (syntax->list ;; no need in R6RS ???
		   ;;#'(expr) )) ; do not work
		   (list #'expr););)
		   infix-operators-lst-for-parser-syntax
		   (lambda (op a b) (list op a b))) )

	       ;; works
	       ;; (recall-infix-parser #'expr
	       ;; 			    infix-operators-lst-for-parser-syntax
	       ;; 			    (lambda (op a b) (list op a b)))
	       )))
	 
	 #'parsed-args))
      

	 

      ;; !!!!!!!!!!!!!!!!!!!
      ;; (define y sin 0.34)
      ;; y
      ;; 0.3334870921408144
      ;; (define x  - 4)
      ;; x
      ;; -4
      (($nfx$ op1 e1) ; note : with 2 arg !*-prec-generic-infix-parser could not work , so we use recall-infix-parser

       (with-syntax
			 
	   ((parsed-args
	     
	     (recall-infix-parser #'(op1 e1)
				  infix-operators-lst-for-parser-syntax
				  (lambda (op a b) (list op a b)))

	     ))
	 
	 #'parsed-args))	   

      
      
      ;; (($nfx$ e1 op1 e2) #'(op1 e1 e2))
      ;; (($nfx$ e1 op1 e2 op2)

      ;;  (error "$nfx$ : called with 4 args (should be 3 or 5 or more) :" #'e1 #'op1 #'e2 #'op2))

      ;; note that ,in the normal case,to have $nfx$ called you need at minimum to have 2 different operator causing an operator precedence question
      ;; and then at least those 2 operators must be between operands each, so there is a need for 3 operand
      ;; the syntax then looks like this : e1 op1 e2 op2 e3 ..., example : 3 * 4 + 2
      ;;(($nfx$ e1 op1 e2 op2 e3 op ...) ; note: i add op because in scheme op ... could be non existent
      (($nfx$ e1 op1 e2 op ...)
       
	 (with-syntax ;; let
			 
	     ((parsed-args

	       (begin

		 
		   ;;(display "$nfx$: #'(e1 op1 e2 op ...)=") (display #'(e1 op1 e2 op ...)) (newline)
		   ;;(display "$nfx$: (syntax->list #'(e1 op1 e2 op ...))=") (display (syntax->list #'(e1 op1 e2 op ...))) (newline)
		   

		 (let ((expr (car ;  probably because the result will be encapsuled in a list !
			      ;;(!*prec-generic-infix-parser (syntax->list #'(e1 op1 e2 op2 e3 op ...)) ; apply operator precedence rules
			      (!*prec-generic-infix-parser ;;(list->mlist
			                        ;;(syntax->list ;; no need in R6RS ???
			                        ;; give this sort of errors (perheaps because in with-syntax):
			                        ;;  ../nfx.sls:101:47: syntax->list: contract violation
			                        ;; expected: syntax?
			                        ;; given: (mcons #<syntax 3> (mcons #<syntax *> (mcons #<syntax (5 - 2)> (mcons #<syntax +> (mcons #<syntax 1> '())))))
					       	#'(e1 op1 e2 op ...);))
						infix-operators-lst-for-parser-syntax
						(lambda (op a b) (list op a b))))))

		   ;; TODO pass back in n-arity also arithmetic operators (+ , * , ...) note: fail with n-arity
		   (if ;;(not (isEXPONENTIAL? expr))
		       (or (isDEFINE? expr)
		       	   (isASSIGNMENT? expr))
		       ;;  make n-arity for <- and <+ only (because could be false with ** , but not implemented in n-arity for now)
		       ;; (begin
		       ;; 	 (display "$nfx$ : calling n-arity on expr :") (display expr) (newline) 
			 (n-arity ;; this avoids : '{x <- y <- z <- t <- u <- 3 * 4 + 1}
			  ;; SRFI-105.scm : !0 result = (<- (<- (<- (<- (<- x y) z) t) u) (+ (* 3 4) 1)) ;; fail set! ...
			  ;; transform in : '(<- x y z t u (+ (* 3 4) 1))
			  expr) ;) ; end begin
		       expr)))))

	  
	     ;;(display "$nfx$ : parsed-args=") (display #'parsed-args) (newline)
	   #'parsed-args)))))


;; (print-as-expression #f) ; print (a b) instead of (mcons a (mcons b '()))
  
;; ;; display mutable list { } with classic ( ).
;; (print-mpair-curly-braces #f)

  
) ; end library



;; (define (foo) 7)

;; (foo)
;; 7

;; (define x  - (foo))

;; x
;; -7

;; (define (bar) -)

;; (bar)
;; #<procedure:->

;; (define z  (bar) (foo))
;; z
;; -7

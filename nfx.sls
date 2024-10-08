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


;; /Applications/Racket\ v8.13/bin/plt-r6rs --install nfx.scm  


#!r6rs


(library (nfx) ; R6RS


  (export $nfx$)

  (import (rnrs base (6))
	  (for (rnrs base (6)) expand) ; import at expand phase (not run phase)
	  (for (rnrs syntax-case (6)) expand)
	  (for (Scheme+R6RS n-arity) expand) ; at phase: 1; the transformer environment
	  (for (Scheme+R6RS infix-with-precedence-to-prefix) expand) ; at phase: 1; the transformer environment
	  (for (Scheme+R6RS operators-list) expand);; at phase: 1; the transformer environment
	  (for (only (rnrs io simple (6)) display newline) expand)
	  )


  


  
;; Welcome to DrRacket, version 8.13 [cs].
;; Language: r6rs, with debugging; memory limit: 8192 MB.
;; > ($nfx$ 3 * 5 + 2)
;; $nfx$ : parsed-args={.#<syntax:15-interactions from an unsaved editor:3:15 +> {.#<syntax:15-interactions from an unsaved editor:3:11 *> .#<syntax:15-interactions from an unsaved editor:3:9 3> .#<syntax:15-interactions from an unsaved editor:3:13 5>} .#<syntax:15-interactions from an unsaved editor:3:17 2>}
;; 17

(define-syntax $nfx$

  (lambda (stx)
    
    (syntax-case stx ()

      ;; note that to have $nfx$ called you need at minimum to have 2 different operator causing an operator precedence question
      ;; and then at least those 2 operators must be between operands each, so there is a need for 3 operand
      ;; the syntax then looks like this : e1 op1 e2 op2 e3 ..., example : 3 * 4 + 2
      (($nfx$ e1 op1 e2 op2 e3 op ...) ; note: i add op because in scheme op ... could be non existent

       ;;#'(list e1 op1 e2 op2 e3 op ...)
       
	 (with-syntax ;; let
			 
		       ((parsed-args
			 ;; TODO : make n-arity for <- and <+ only (because could be false with ** , but not implemented in n-arity for now)
			 (n-arity ;; this avoid : '{x <- y <- z <- t <- u <- 3 * 4 + 1}
			   ;; SRFI-105.scm : !0 result = (<- (<- (<- (<- (<- x y) z) t) u) (+ (* 3 4) 1)) ;; fail set! ...
			   ;; transform in : '(<- x y z t u (+ (* 3 4) 1))
			   (!0-generic #'(e1 op1 e2 op2 e3 op ...) ; apply operator precedence rules
				       infix-operators-lst-for-parser-syntax
				       ;;(get-infix-operators-lst-for-parser-syntax)
				       (lambda (op a b) (list op a b))))))
		       (display "$nfx$ : parsed-args=") (display #'parsed-args) (newline)
		       #'parsed-args)))))

) ; end library


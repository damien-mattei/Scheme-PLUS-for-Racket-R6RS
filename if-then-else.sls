;; This file is part of Scheme+

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


;; /Applications/Racket\ v8.13/bin/plt-r6rs --install if-then-else.scm
;; [installing /Users/mattei/Library/Racket/8.13/collects/if-then-else/main.ss]
;; [Compiling /Users/mattei/Library/Racket/8.13/collects/if-then-else/main.ss]



(library (if-then-else) ; R6RS

  (export if)
  
  (import ;;(rnrs base (6))
   (except (rnrs base (6)) if)
   
   ;;(rnrs syntax-case (6))

   ;;(only (racket) syntax-case)

   ;;(for (rnrs base (6)) expand) ; import at expand phase (not run phase)
   (for ;;(except (rnrs base (6)) if) expand)
    (rename (rnrs base (6)) (if if-scheme)) expand)
	  (for (rnrs syntax-case (6)) expand)
	  (only (srfi :1) third)
	  (Scheme+ declare)
	  (Scheme+ insert)
	  (Scheme+ syntax)
	  (for (Scheme+ if-parser) expand)
	  (for (only (rnrs io simple (6)) display newline) expand))



  
(define-syntax if
  
  (lambda (stx)
    
    (syntax-case stx (then else)
      
      ((if tst ...)

       (with-syntax ((parsed-args  ;;#'(cond (#t 3))))
	      
		      (call-parse-if-args-syntax #'(tst ...))))

		    (display "if : parsed-args=") (display #'parsed-args) (newline)
       		    #'parsed-args)))))
		    

) ; end module


;; scheme@(guile-user)> (if #t 7)
;; WARNING: (guile-user): imported module (if-then-else) overrides core binding `if'
;; if : parsed-args=(#<syntax:if-then-else.scm:244:23 cond> (#<syntax:unknown file:2:4 #t> #<syntax:unknown file:2:7 7>))
;; $1 = 7
;; scheme@(guile-user)> (if #t then 7)
;; if : parsed-args=(#<syntax:if-then-else.scm:246:42 cond> (#<syntax:unknown file:3:4 #t> #<syntax:unknown file:3:12 7>))
;; $2 = 7
;; scheme@(guile-user)> (if #t 2 else 3)
;; if : parsed-args=(#<syntax:if-then-else.scm:307:22 cond> (#<syntax:unknown file:4:4 #t> #<syntax:unknown file:4:7 2>) (#<syntax:if-then-else.scm:308:29 else> #<syntax:unknown file:4:14 3>))
;; $3 = 2
;; scheme@(guile-user)> (if #t then 2 else 3)
;; if : parsed-args=(#<syntax:if-then-else.scm:307:22 cond> (#<syntax:unknown file:5:4 #t> #<syntax:unknown file:5:12 2>) (#<syntax:if-then-else.scm:308:29 else> #<syntax:unknown file:5:19 3>))
;; $4 = 2
;; scheme@(guile-user)> (if #f then 2 else 3)
;; if : parsed-args=(#<syntax:if-then-else.scm:307:22 cond> (#<syntax:unknown file:6:4 #f> #<syntax:unknown file:6:12 2>) (#<syntax:if-then-else.scm:308:29 else> #<syntax:unknown file:6:19 3>))
;; $5 = 3
;; scheme@(guile-user)> (if #f then 1 2 else 3 4)
;; if : parsed-args=(#<syntax:if-then-else.scm:307:22 cond> (#<syntax:unknown file:7:4 #f> #<syntax:unknown file:7:12 1> #<syntax:unknown file:7:14 2>) (#<syntax:if-then-else.scm:308:29 else> #<syntax:unknown file:7:21 3> #<syntax:unknown file:7:23 4>))
;; $6 = 4
;; scheme@(guile-user)> (if #t then 1 2 else 3 4)
;; if : parsed-args=(#<syntax:if-then-else.scm:307:22 cond> (#<syntax:unknown file:8:4 #t> #<syntax:unknown file:8:12 1> #<syntax:unknown file:8:14 2>) (#<syntax:if-then-else.scm:308:29 else> #<syntax:unknown file:8:21 3> #<syntax:unknown file:8:23 4>))
;; $7 = 2
;; scheme@(guile-user)> (if #t 1 2 3)
;; if : parsed-args=(#<syntax:if-then-else.scm:300:37 cond> (#<syntax:unknown file:9:4 #t> #<syntax:unknown file:9:7 1> #<syntax:unknown file:9:9 2> #<syntax:unknown file:9:11 3>))
;; $8 = 3
;; scheme@(guile-user)> (if #t then 1 2 else 3 4 then 5)
;; While compiling expression:
;; if: then after else near : (#<syntax:unknown file:10:25 then> #<syntax:unknown file:10:30 5>)
;; scheme@(guile-user)> (if #t then 1 2 else 3 4 else 5)
;; While compiling expression:
;; if: 2 else inside near: (#<syntax:unknown file:11:25 else> #<syntax:unknown file:11:30 5>)
;; scheme@(guile-user)> (if #t else 1 2 then 3 4)
;; While compiling expression:
;; if: then after else near : (#<syntax:unknown file:12:16 then> #<syntax:unknown file:12:21 3> #<syntax:unknown file:12:23 4>)
;; scheme@(guile-user)> (if #t then 1 2 then 3 4)
;; While compiling expression:
;; if: 2 then inside near: (#<syntax:unknown file:13:16 then> #<syntax:unknown file:13:21 3> #<syntax:unknown file:13:23 4>)
;; scheme@(guile-user)> 

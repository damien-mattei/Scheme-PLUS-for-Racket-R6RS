#lang info

(define pkg-name "Scheme-PLUS-for-Racket-R6RS") ; "+" not allowed in package names
(define collection "Scheme+")
(define compile-omit-paths '("deprecated" "compiled"))
(define test-omit-paths '("compiled"))
(define pkg-desc "Scheme+ for Racket R6RS")
(define version "9.1")
(define pkg-authors '(mattei))
(define scribblings '(("scribblings/Scheme-PLUS-for-Racket-R6RS.scrbl" ())))
(define build-deps '("scribble-lib" "racket-doc" "scribble-code-examples" "scribble-doc"))
(define license 'GPL-3.0-or-later)

(define deps
  '("base"
    "r6rs-lib"
    "srfi-lib"
    "sci"))


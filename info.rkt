#lang info

(define pkg-name "Scheme-PLUS-for-Racket-R6RS") ; "+" not allowed in package names
(define collection "Scheme+")
(define compile-omit-paths '("deprecated"))
(define pkg-desc "Scheme+ for Racket R6RS")
(define version "9.1")
(define pkg-authors '(mattei))
(define license 'GPL-3.0-or-later)

(define deps
  '("base"
    "r6rs-lib"
    "srfi-lib"
    "sci"))
;;"reprovide-lang-lib"))

(define build-deps
  '())


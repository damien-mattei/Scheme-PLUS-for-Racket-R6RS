#lang racket/base

;; install in a kw-example collect

(require (for-syntax racket/base
                     racket/string
                     syntax/parse)
         racket/format
         syntax/parse/define)

(provide define-kwish
         test)

(begin-for-syntax
  (define-syntax-class maybe-kwish
    #:attributes (translate)
    (pattern id
      #:declare id id
      #:do [(define id-string
              (symbol->string (syntax-e #'id)))]
      #:when (string-suffix? id-string ":")
      #:attr
      translate
      #`#,(string->keyword
           (substring id-string 0 (sub1 (string-length id-string)))))
    (pattern e
      #:attr translate #'e)))

(define-syntax-parse-rule (kw-rewrite vs:maybe-kwish ...)
  (vs.translate ...))

(define-syntax-parse-rule (define-kwish name:id orig-name:id)
  (define-syntax-rule (name . rest) (kw-rewrite orig-name . rest)))

(define (test #:greeting [greeting "hello"]
              #:location [location "world"])
  (~a greeting " " location))
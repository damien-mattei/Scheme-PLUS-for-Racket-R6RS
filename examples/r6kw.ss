#!r6rs

(library (test-kw)
         (export)
         (import (rnrs base (6))
                 (only (rnrs io simple (6)) display newline)
                 (kw-example kw))

         (define (displayln x) (display x) (newline))

         (displayln (test))

         (define-kwish kw-test test)

         (displayln (kw-test greeting: "hola"
                             location: "mundo")))

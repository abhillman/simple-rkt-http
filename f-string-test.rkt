#lang racket

(require rackunit "f-string.rkt")

(require megaparsack megaparsack/text)

(check-equal? (f-string/parse "{123}") "123")
(check-equal? (f-string/parse "{123}{123}") "123123")
; (check-equal? (f-string/parse "hello {\"xyz\"}") "hello xyz")

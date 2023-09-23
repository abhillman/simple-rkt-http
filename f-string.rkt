#lang racket

(provide f-string/expr/p f-string/parse)

(require megaparsack megaparsack/text)
(require data/monad data/applicative data/functor)

; (define f-string/text/p
;   (do
;     [text <- (many/p (char-not-in/p "{}"))]
;     (pure (list->string text))))

(define f-string/expr/p
  (do
    (char/p #\{)
    [expr <- (many+/p (char-not-in/p "{}"))]
    (char/p #\})
    (pure
      (read (open-input-string (list->string expr))))))

(define f-string/p
  (many/p
    (do [datum <- f-string/expr/p]
      (map (lambda (v) (format "~v" v)) (pure datum)))))

(define (f-string/parse text)
  (string-join
    (parse-result!
      (parse-string f-string/p text)) ""))

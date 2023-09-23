#lang racket

(provide f-string/expr/p f-string/parse)

(require megaparsack megaparsack/text)
(require data/monad data/applicative)

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
      (pure datum))))

(define (f-string/read text)
  (read
    (open-input-string
      text)))

(define (f-string/parse text)
  (string-join
    (map (λ (v) (format "~v" v))
      (parse-result!
        (parse-string f-string/p text))) ""))

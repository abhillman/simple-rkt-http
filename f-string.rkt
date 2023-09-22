#lang racket

(provide f-string/p f-string/parse)

(require megaparsack megaparsack/text)
(require data/monad data/applicative)

(define f-string/p
  (do
    (char/p #\{)
    [expression <- (many+/p (char-not-in/p "{}"))]
    (char/p #\})
    (pure
      (list->string expression))))

(define (f-string/parse text)
    (read
      (open-input-string
        (parse-result!
          (parse-string f-string/p text)))))


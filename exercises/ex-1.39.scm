(load "ex-1.37.scm")

(newline)
(display (tan 10))

(define (tan x k)
  (define (n i)
    (if (= 1 i)
      x
      (- (square x))
      )
    )

  (define (d i)
    (- (* 2 i) 1)
    )

  (exact->inexact (cont-frac n d k))
  )

(newline)
(display (tan 10 10))

(newline)
(display (tan 10 100))

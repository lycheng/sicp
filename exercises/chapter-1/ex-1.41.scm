(define (double f)
  (lambda (x) (f (f x)))
  )

(define (inc i)
  (+ i 1)
  )

(newline)
(display (((double (double double)) inc) 5))

(newline)
(display (((double double) inc) 1))

(load "ex-1.43.scm")

(define dx 0.0001)

(define (smooth f)
  (lambda (x)
    (/ (+
         (f (- x dx))
         (f x)
         (f (+ x dx))
         )
       3)
    ))

(define (smooth-n-times f n)
  ((repeated smooth n) f)
  )

(newline)

(define (square n) (* n n))
(trace-entry square)

(display ((smooth-n-times square 2) 10))

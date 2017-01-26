(load "functions.scm")

(define (good-enough guess nguess)
  (> 0.01
     (/ (abs (- nguess guess))
        guess)))

(define (improve i src)
  (average i (/ src i)))

(define (sqrt-iter i src)
  (if (good-enough i (improve i src))
    (improve i src)
    (sqrt-iter (improve i src) src)
  ))

(define (sqrt src) (sqrt-iter 1.0 src))

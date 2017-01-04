(load "functions.scm")

(define (cube x) (* x x x))

(define (good-enough guess nguess)
  (> 0.01
     (/ (abs (- nguess guess))
        guess)))

(define (improve y x)
   (/ (+
        (/ x (square y))
        (* 2 y))
      3))

(define (cube-root-iter y x)
  (if (good-enough y (improve y x))
    (improve y x)
    (cube-root-iter (improve y x) x)
  ))

(define (cube-root x) (cube-root-iter 1.0 x))

(display (cube-root (cube 7)))

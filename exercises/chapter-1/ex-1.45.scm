(load "ex-1.43.scm")
(load "ex-1.35.scm")

(define (average x y) (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x)
    (average x (f x))))

(define (nth-root x n)
  (fixed-point
     (average-damp
        (lambda (y) (/ x (expt y (- n 1)))))
     1.0))

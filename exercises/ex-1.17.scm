(load "functions.scm")

(define (double x) (+ x x))
(define (halve x) (/ x 2))
(define (is-even n) (= (remainder n 2) 0))

(define (* a b)
  (cond ((= b 0) 0)
        ((is-even b) (double (* a (halve b))))
        (else (+ a (* (a (- b 1)))))
        )
  )

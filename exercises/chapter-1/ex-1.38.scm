(load "ex-1.37.scm")

(define (di i)
  (if (= 2 (remainder i 3))
    (* 2 (/ (+ i 1) 3))
    1
    ))

(define (cal-e k)
  (+ 2
     (cont-frac (lambda (i) 1.0)
                di
                k)))

(newline)
(display (cal-e 1))
(newline)
(display (cal-e 5))
(newline)
(display (cal-e 10))

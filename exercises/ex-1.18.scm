(define (double x) (+ x x))
(define (halve x) (floor (/ x 2)))
(define (is-even n) (= (remainder n 2) 0))

(define (* a b)
  (iter a b 0)
  )

(define (iter a b r)
  (cond ((= b 0) r)
        ((is-even b) (iter (double a) (halve b) r))
        (else (iter a (- b 1) (+ r a)))
        )
  )

(display (* 4 0))
(display (* 4 2))
(display (* 4 5))

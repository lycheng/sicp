(load "functions.scm")

(define (is-even n) (= (remainder n 2) 0))

(define (expt b n)
  (fast-expt b n 1))

(define (fast-expt b n r)
  (cond ((= n 0) r)
        ((is-even n) (fast-expt (square b) (/ n 2) r))
        (else (fast-expt b (- n 1) (* r b)))
    )
  )

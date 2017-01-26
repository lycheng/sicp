(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a)
              (accumulate combiner null-value term (next a) next b))
    )
  )

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (combiner (term a) result))
      )
    )
  (iter a null-value))


(define (sum term a next b)
  (accumulate + 0 term a next b)
  )

(define (product term a next b)
  (accumulate-iter * 1 term a next b)
  )

(define (s a b)
  (define (term a) a)
  (define (next a) (+ a 1))
  (sum term a next b)
  )

(define (f n)
  (define (term a) a)
  (define (next a) (+ a 1))
  (product term 1 next n)
  )

(newline)
(display (s 0 10))
(newline)
(display (f 4))



(define (f n)
  (if (< n 3)
    n
    (+ (f (- n 1))
       (* 2 (f (- n 2)))
       (* 3 (f (- n 3))))
    )
  )

(define (fi n)
  (fiter 2 1 0 n)
  )

(define (fiter a b c n)
  (if (= n 0)
    c
    (fiter (+ a (* 2 b) (* 3 c))
           a
           b
           (- n 1)
           )
    )
  )

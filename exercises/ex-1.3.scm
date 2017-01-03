(load "functions.scm")

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (larger a b)
  (if (> a b) a
    b
    )
  )

(define (smaller a b)
  (if (> a b) b
    a
    )
  )

(define (f a b c)
  (sum-of-squares (larger a b)
                  (larger (smaller a b) c)
                  )
  )

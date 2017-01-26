(load "functions.scm")

(define (next n)
  (if (even? n)
    (+ n 1)
    (+ n 2)
    )
  )

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) 1)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else 0)))

(define (is-prime n)
  (= 1 (fast-prime? n 128))
  )

(define (next-odd n)
  (if (even? n)
    (+ n 1)
    (+ n 2)
    )
  )

(define (search-for-primes i n)
  (cond ((= n 0)
         (newline)
         )
        ((is-prime i)
         (newline)
         (display i)
         (search-for-primes (next-odd i) (- n 1))
         )
        (else
          (search-for-primes (next-odd i) n))
        )
  )


(define (timed i n)
  (start i n (runtime))
  )

(define (start i n start-time)
  (search-for-primes i n)
  (report-prime (- (runtime) start-time))
  )

(define (report-prime elapsed-time)
  (display "Consume: ")
  (display elapsed-time))
  (newline)

(timed 10000000 3)
(timed 10240000000 3)

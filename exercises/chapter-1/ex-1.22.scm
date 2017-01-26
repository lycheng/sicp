(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (is-prime n)
  (= n (smallest-divisor n)))

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
  (start i n (runtime)))

(define (start i n start-time)
  (search-for-primes i n)
  (report-prime (- (runtime) start-time))
  )

(define (report-prime elapsed-time)
  (display "Consume: ")
  (display elapsed-time))
  (newline)

(timed 10000000 3)
(timed 100000000 3)
(timed 1000000000 3)
(timed 10000000000 3)
(timed 100000000000 3)

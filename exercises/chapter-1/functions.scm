
(define (abs i) (if (< i 0) (- i) i))

(define (average x y)
  (/ (+ x y) 2))

(define (expmod base e m)
  (cond ((= e 0) 1)
        ((even? e)
         (remainder (square (expmod base (/ e 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- e 1) m))
                     m))))

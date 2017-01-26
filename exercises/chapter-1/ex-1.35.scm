(define tolerance 0.00001)

(define (fixed-point f first-guess)

  (define (close? v1 v2)
    (< (abs (- v1 v2)) tolerance))

  (define (try guess)
    (let ((next (f guess)))
     (if (close? guess next)
       next
       (try next))))

  (try first-guess))


(define golden-ratio (fixed-point
                       (lambda (x) (+ 1 (/ 1 x)))
                       1.0))

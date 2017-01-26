(define tolerance 0.00001)

(define (average x y) (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x)
    (average x (f x))))

(define (fixed-point f first-guess)

  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))

  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
     (if (close-enough? guess next)
       next
       (try next))))

  (try first-guess))


(newline)
(define r1 (fixed-point
             (lambda (x) (/ (log 1000) (log x)))
             2.0))

(newline)
(define r2 (fixed-point
             (average-damp (lambda (x) (/ (log 1000) (log x))))
             2.0))

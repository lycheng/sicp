(define (iter-improve good? improve)
  (lambda (x)
    (define (iter cur)
      (let ((next (improve cur)))
       (if (good? cur next)
         next
         (iter next)
         )))
    (iter x)))

(define (fixed-point f first-guess)

    (define tolerance 0.00001)

    (define (good? v1 v2)
        (< (abs (- v1 v2)) tolerance))

    (define (improve guess)
        (f guess))

    ((iter-improve good? improve) first-guess))


(newline)
(display (fixed-point cos 1.0))

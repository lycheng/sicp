(define (product a b term next)
  (if (> a b)
    1
    (* (term a)
       (product (next a) b term next))))

(define (product-iter a b term next)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* (term a) result))
      )
    )
  (iter a 1))


(define (pi n)
  (define (term i)
    (if (even? i)
      (/ (+ 2 i) (+ 3 i))
      (/ (+ 3 i) (+ 2 i))
      ))
  (define (next i) (+ 1 i))
  (* 4 (product-iter 0 n term next)))

(define (factorial n)
  (define (next i) (+ 1 i))
  (define (term i) i)
  (product 1 n term next)
  )

; (newline)
; (display (exact->inexact (pi 100000)))
; (newline)
; (display (factorial 4))

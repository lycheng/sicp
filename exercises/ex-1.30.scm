(load "ex-1.29.scm")

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (+ (term a) result))
      )
    )
  (iter a 0))

; (display (new cube 0 1 100))
; (newline)
; (display (new cube 0 1 10000))

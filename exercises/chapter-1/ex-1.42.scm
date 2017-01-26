(define (compose f g)
  (lambda (x) (f (g x)))
  )

; (newline)
; (display ((compose square (lambda (x) (+ 1 x))) 6))

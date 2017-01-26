(load "ex-1.42.scm")

(define (repeated f nth)
  (if (or (< nth 1) (= nth 1))
    f
    (lambda (x)
      (f ((repeated f (- nth 1)) x))
      )
    )
  )

; (newline)
; (display ((repeated square 2) 5))

(define (repeated-compose f nth)
  (if (or (< nth 1) (= nth 1))
    f
    (lambda (x)
      ((compose f (repeated f (- nth 1))) x)
      )
    )
  )

; (newline)
; (display ((repeated-compose square 2) 5))

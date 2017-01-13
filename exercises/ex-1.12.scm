(define (pascal row col)
  (cond ((or (= col 1) (= row col)) 1)
        ((> col row) 0)
        (else
          (+ (pascal (- row 1) col)
             (pascal (- row 1) (- col 1)))
          )
        )
  )

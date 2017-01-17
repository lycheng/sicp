(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))


(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

; (newline)
; (display (integral cube 0 1 0.01))

(define (new f a b n)
  (define h (/ (- b a) n))

  (define (y k) (f (+ a (* k h))))

  (define (factor k)
    (cond ((or (= k 0) (= k n)) 1)
          ((even? k) 2)
          (else 4)))

  (define (term k) (* (factor k)
                      (y k)))


  (define (next k) (+ 1 k))

  (* (/ h 3) (sum term 0 next n)))

; (newline)
; (display (new cube 0 1 100))
; (newline)
; (display (new cube 0 1 10000))

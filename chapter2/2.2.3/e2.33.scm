(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y) )
              '()
              sequence))

(define (accumulate op init-value sequence)
  (if (null? sequence) 
    init-value
    (op (car sequence)
        (accumulate op 
                    init-value 
                    (cdr sequence)))))

(accumulate + 0 (list 1 2 3 4 5))

(map square (list 1 2 3))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(append (list 1 2)
        (list 3 4))

(define (length sequence)
  (accumulate (lambda (a b) (+ b 1))  0 sequence))


(length (list 1 1 1))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs))))))

(define (accumulate op init-value sequence)
  (if (null? sequence) 
    init-value
    (op (car sequence)
        (accumulate op 
                    init-value 
                    (cdr sequence)))))


(define m '((1 2 3) 
            (4 5 6) 
            (7 8 9) 
            (10 11 12)))

(accumulate-n + 
              0 
              '((1 2 3) 
                (4 5 6) 
                (7 8 9) 
                (10 11 12)))



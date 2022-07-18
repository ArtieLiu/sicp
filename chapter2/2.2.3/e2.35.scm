(define (accumulate op init-value sequence)
  (if (null? sequence) 
    init-value
    (op (car sequence)
        (accumulate op 
                    init-value 
                    (cdr sequence)))))

(define (enumerate-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append 
               (enumerate-tree (car tree))
               (enumerate-tree (cdr tree))))))

(define (count-leaves t)
  (accumulate (lambda (l length-of-other-lists) 
                (+ (length l) 
                   length-of-other-lists))
              0
              (map enumerate-tree t)))



(count-leaves '(1 (2 (3 4 (8 9))) 5))

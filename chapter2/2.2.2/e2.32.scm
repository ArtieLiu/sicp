(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s)))) 
        (append rest 
                (map (lambda (l) 
                       (cons (car s) l)) 
                     rest)))))

(subsets '(1 2 3))

;s = (1 2 3)
;
;(1 2 3) (1 2) (1 3) (1)
;(2 3) (2) (3) ()
;
;(append 
;  all subset with the first element 
;  all subset without the first element)
;
;all subset with the first element = (append-to-every-sublist 1st-element 
;                                                             (subsets s-without-1st-element))
;
;(define (append-to-every-sublist l e)
;  (map (lambda (l)
;         (cons e l))
;       l))
;
;(append-to-every-sublist '(()) 1)
;(append-to-every-sublist '((1)) 1)
;(append-to-every-sublist '(() (2 3) (2) (3) ()) 1)
;(append-to-every-sublist 1 '(() (2 3) (2) (3) ()))

;first is empty?
;  return empty list
;
;first element is number?
;  deep-reverse the rest of the list and append to it the first element
;
;first element is list?
;  deep-reverse the rest of the list and append to it the first element deep-reversed 
;  

(define (deep-reverse l)
  (cond ((null? l) '())
        ((not (list? (car l))) 
         (append (deep-reverse (cdr l)) 
                 (list (car l))))
        (else (append (deep-reverse (cdr l))
                      (list (deep-reverse (car l)))))))

(deep-reverse '())
(deep-reverse '(1 2 3))
(deep-reverse '(1 2 (3 4) 5))
(deep-reverse '(1 2 (3 4) 5 (6 (7 8) 9) 0))

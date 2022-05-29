(define (value-at-row-column row col)
	(cond ((and (= col 1) 
              (= row 1)) 1)
        ((or (= col 0) 
             (> col row)) 0)
        (else (+ (value-at-row-column (- row 1) 
                                       (- col 1)) 
                  (value-at-row-column (- row 1) 
                                       col)))))

(value-at-row-column 4 2)



; 1
; 1 1
; 1 2 1  (3 2) 
; 1 3 3 1

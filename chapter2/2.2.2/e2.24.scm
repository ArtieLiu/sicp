(list 1 (list 2 (list 3 4)))
(list 1 (list 2 (cons 3 
                      (cons 4 '()))))
(cons 1
      (cons (list 2 (list 3 4))
            '()))

(cons 1
      (cons (cons 2 
                  (cons (list 3 4)
                        '()))
            '()))
(cons 1
      (cons (cons 2 
                  (cons (cons 3
                              (cons 4
                                    '()))
                        '()))
            '()))

(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
	  (list-of-values (rest-operands exps) 
			  env))))


; from left to right
(define (list-of-values exps env) 
  (if (no-operands? exps)
    '()
    (let ((x (eval (first-operand exps) env)))
      (let ((y (list-of-values (rest-operands exps) env)))
	(cons x y)))))

; from right to left
(define (list-of-values exps env) 
  (if (no-operands? exps)
    '()
    (let ((x (list-of-values (rest-operands exps) env)))
      (let ((y (eval (first-operand exps) env)))
	(cons y x)))))

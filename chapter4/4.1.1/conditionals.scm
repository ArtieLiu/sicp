(define (eval-if exp env) 
  (if (true? (eval (if-procedure exp) env))
    (eval (if-consequent exp) env)
    (eval (if-alternative exp) env)))

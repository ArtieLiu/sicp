(let ((<var> <exp>)) 
  <body>)

((lambda (<var>) <body>) <exp>)

(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance 
                       (- balance amount))
                 balance)
          "Insufficient funds"))))

(define make-withdraw initial-amount 
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
	(begin (set! balance (- balance amount))
	       balance)
	"Insufficient funds"))))

(define make-withdraw initial-amount
  ((lambda (balance)
     (lambda (amount)
       (if (>= balance amount)
	 (begin (set! balance (- balance amount))
		balance)
	 "Insufficient funds"))) 
   initial-amount))

(define W1 (make-withdraw 100))



(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (correct-password? inputed-password) 
    (equal? inputed-password password))

  (define (show-error-msg m) 
    "Incorrect password")

  (define (dispatch inputed-password m)
    (if (correct-password? inputed-password)
      (cond ((eq? m 'withdraw) withdraw)
	    ((eq? m 'deposit) deposit)
	    (else (error "Unknown request: 
			 MAKE-ACCOUNT" m)))
      show-error-msg))
  dispatch)

(define acc (make-account 100 'pass))
((acc 'pass 'withdraw) 10)
((acc 'hahaha 'withdraw) 10)

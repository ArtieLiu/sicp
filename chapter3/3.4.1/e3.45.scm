(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance 
	       (- balance amount))
	     balance)
      "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (balance-serializer withdraw))
	    ((eq? m 'deposit) (balance-serializer deposit))
	    ((eq? m 'balance) balance)
	    ((eq? m 'serializer) balance-serializer)
	    (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch))

(define (exchange ccount1 account2)
  (let ((difference (- (account1 'balance)
		       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit)  difference)))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
	(serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange)) account1 
					  account2)))



#|
For serialized-exchange, the withdraw procedure is serialized twice by the same serializer.
By definition, the procedure cannot be performed because two procedures cannot be run concurrently if they are serialized by the same serializer.

For the serialzied exchange to be finished, withdraw procedure must be finished first. However, withdraw cannot be run because withdraw and exchange are in the same serializer.
#|

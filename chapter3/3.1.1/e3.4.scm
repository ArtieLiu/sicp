(define (make-account balance password)
  (define tries-left 7)

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

  (define (show-error-msg) 
    "Incorrect password")

  (define (call-the-cops) 
    "Cops coming......")	

  (define (pending-call-cops arg) 
    (if (= 0 tries-left)
      (call-the-cops)
      (begin (set! tries-left (- tries-left 1))
	     (show-error-msg))))

  (define (dispatch inputed-password m)
    (if (correct-password? inputed-password)
      (cond ((eq? m 'withdraw) withdraw)
	    ((eq? m 'deposit) deposit)
	    (else (error "Unknown request: 
			 MAKE-ACCOUNT" m)))
      pending-call-cops))
  dispatch)

; make account
(define acc (make-account 100 'pass))
((acc 'pass 'withdraw) 10)

((acc 'hahaha 'withdraw) 10)
((acc 'hahaha 'withdraw) 10)
((acc 'hahaha 'withdraw) 10)
((acc 'hahaha 'withdraw) 10)
((acc 'hahaha 'withdraw) 10)
((acc 'hahaha 'withdraw) 10)
((acc 'hahaha 'withdraw) 10)

; Cops coming
((acc 'hahaha 'withdraw) 10)

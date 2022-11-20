(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin 
	(set! balance 
	  (- balance amount))
	balance)
      "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'twithdraw) (protected withdraw))
	    ((eq? m 'deposit)  (protected deposit))
	    ((eq? m 'balance)  ((protected 
				 (lambda () balance)))) ; serialized
	    (else (error "Unknown request: MAKE-ACCOUNT"
			 m))))
    dispatch))


; There is no need to serialize 'balance. 
; Accessing balance does not change state of the value.

; Consider this case. A withdraw takes a very long time and a read opertaion occures 
; during this period. This mid-withdraw read would return the value just before the 
; withdraw operation and the value is changed once after the withdraw completed. 
; The value returned by read is not-correct, however this does not cause any harm 
; to the system.

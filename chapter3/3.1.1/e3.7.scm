(define (in? e l) 
  (cond ((null? l) #f)
	((equal? e (car l)) #t)
	(else (in? e (cdr l)))))

(define (make-account balance password)
  (define passwords (list password))

  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (add-joint newpass) 
    (add-password newpass))

  (define (add-password newpass) 
    (set! passwords (cons newpass passwords)))

  (define (correct-password? inputed-password) 
    (in? inputed-password passwords))

  (define (show-error-msg m) 
    "Incorrect password")

  (define (dispatch inputed-password m)
    (if (correct-password? inputed-password)
      (cond ((eq? m 'withdraw) withdraw)
	    ((eq? m 'deposit) deposit)
	    ((eq? m 'make-joint) add-joint)
	    (else (error "Unknown request: 
			 MAKE-ACCOUNT" m)))
      show-error-msg))
  dispatch)

; ----------------- testing ----------------- 
(define acc (make-account 100 'pass))
((acc 'pass 'withdraw) 10)
((acc 'hahaha 'withdraw) 10)
; ---------------------------------------


(define (make-joint acc password new-password) 
  ((acc password 'make-joint) new-password)

  (lambda (pass msg)
    (acc pass msg)))

; ----------------- testing ----------------- 
(define peter-acc (make-account 100 'open-sesame))

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

((paul-acc 'open-sesame 'withdraw) 10)
((paul-acc 'rosebud 'withdraw) 10)
; ---------------------------------------

; ----------------- and-gate ----------------- 
(define (and-gate a1 a2 output) 
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
		   (lambda () (set-signal! output new-value)))))
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)
    'ok)


; ----------------- or gate ----------------- 
(define (or-gate a1 a2 output) 
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
		   (lambda () (set-signal! output new-value)))))
    (add-action! a1 or-action-procedure)
    (add-action! a2 or-action-procedure)
    'ok)

(define (logical-or s1 s2) 
  (cond ((= s1 1) 1)
	((= s2 1) 1)
	(else 0)))

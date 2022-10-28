; ----------------- not-gate ----------------- 
(define (inverter input output) 
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      after-delay inverter-delay
      (lambda () 
	(set-signal! output new-value))))
  (add-action! input invert-input)
  'ok)

(define (logical-not s) 
  (cond ((= s 0) 1)
	((= s 1) 0)
	(else (error "invalid siganl" s))))

; ----------------- and-gate ----------------- 
(define (and-gate a1 a2 output) 
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
		   (lambda () (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)


; ----------------- nand-gate ----------------- 
(define (nand-gate s1 s2 output)
  (let (o1 (make-wire))
    (and-gate s1 s2 o1)
    (inverter o1))
  'ok)

; ----------------- or-gate ----------------- 
(define (or-gate s1 s2 output) 
  (let ((o1 (make-wire))
	(o2 (make-wire)))
    (nand-gate s1 s1 o1)
    (nand-gate s2 s2 o2)
    (nand-gate o1 o2 output))
  'ok)

; the delay time of the or gate composed from and-gate and inverter is 3*(and-gate-delay + inverter-delay) 

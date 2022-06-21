(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (prime? n) 
  (fast-prime? n 10))

; ----------- test primality -----------
(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define (fermat-test n)
	(define (try-it a)
		(= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
	(cond ((= exp 0) 1)
		((even? exp)
			(remainder 
				(square (expmod base (/ exp 2) m)) 
				m))
		(else
			(remainder 
				(* base (expmod base (- exp 1) m))
				m))))
; --------------------------------------

; ----------- find prime numbers in a list of consecutive odd numbers -----------

(define (find-prime-between start end)
  (timed-prime-test start)
  (if (< start end)
    (if (odd? start)
      (find-prime-between (+ start 2) end) 
      (find-prime-between (+ start 1) end))))

(find-prime-between 1000000 1001000)

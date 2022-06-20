(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (real-time-clock)))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (real-time-clock) start-time))))

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

(define (find-odd-numbers start end t)
  (if (< start end)
    (if (odd? start)
      (find-odd-numbers (+ start 1) end (timed-prime-test start)) 
      (find-odd-numbers (+ start 1) end 0))))

(find-odd-numbers 1000 2000 0)

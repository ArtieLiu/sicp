(define (f n)
	(if (< n 3) n
		(f-iter 2 1 0 (- n 2))))

(define (f-iter a b c count)
	(if (= count 1) (+ a (* 2 b) (* 3 c))
		(f-iter (+ a (* 2 b) (* 3 c))
			a 
			b 
			(- count 1))))
; f0 = 0
; f1 = 1
; f2 = 2
; f3 = f2 + 2 f1 + 3 f0 = 2 + 2 * 1 + 3 * 0 = 4      count=1
; f4 = f3 + 2 f2 + 3 f1 = 4 + 2 * 2 + 3 * 1 = 11     count=2
; f5 = f4 + 2 f3 + 3 f2 = 11 + 2 * 4 + 3 * 2 = 

(f 3)
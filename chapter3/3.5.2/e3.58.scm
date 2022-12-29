(load "infinite-streams.scm")
(load "stream.scm")

(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) 
	    den 
	    radix)))
; result is the floating point representation of (/ num den) with radix as the base.


(cons-stream 
  (quotient (* 1 10) 7)
  (expand (remainder (* 1 10) 7) 
	    7 
	    10))

       quotient remainder
1 7 10  1	3
3 7 10  4	2
2 7 10	2	6
6 7 10  8	4
4 7 10  5	5
5 7 10  7	1	
1 7 10

result: 1427857...


(expand 3 8 10)

       quotient remainder
3 8 10 4	6	
6 8 10 7	4
4 8 10 5	0
0 8 10 0 	0

result: 4750000...

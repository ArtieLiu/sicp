(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define fibs 
  (cons-stream 0 
	       (cons-stream 1 
			    (add-streams (stream-cdr fibs) 
					 fibs))))

    1 1 2 3 5 8 13 ...
    0 1 1 2 3 5  ...
0 1 1 2 3 5 8 13 ...

With memorization, each new element can be computed from the sum of two previous elements which are memorized. 
To compute a new element, requires one more addition. The nth element takes O(n) steps.

Without memorization, to compute nth element, must compute (n-1)th and (n-2)th element first.
Assuming compute nth element requires A(n) additions, then A(n) = A(n-1) + A(n-2), number of additions grow exponentially 
with respect to n.


; ----------------- old ----------------- 
(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (+ x 1))))


; ----------------- new ----------------- 
(define x 10)

(define s (make-serializer))

(parallel-execute 
  (lambda () 
    (set! x ((s (lambda () 
		  (* x x))))))

  (s (lambda () (set! x (+ x 1)))))


x=10    p1->compute 100
	p1->set x to 100
	p2->set x to 101

x=10	p1->compute 100
	p2->set x to 11
	p1->set x to 100

x=10    p2->set x to 11
	p1->compute 100
	p1->set x to 121

Three possible outcomes: 100,101,121

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      ((stream-null? (stream-cdr (car argstreams)))
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc 
                    (map stream-cdr
                         argstreams))))))

(define (cons-stream a b) (cons a (delay b)))
(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))



(define s1 (cons 1 (delay 2)))
(define s2 (cons 3 (delay 4)))
(define s3 (cons 5 (delay 6)))

(stream-map + (cons 1 (delay 2))
	      (cons 3 (delay 4))
	      (cons 5 (delay 6)))

(cons 9 (delay 12))

(map list 
     '(1 2)
     '(3 4))

(map car '(1 2) '(3 4))

(map car '((1 2) (3 4)))

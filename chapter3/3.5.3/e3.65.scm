(load "stream.scm")
(load "infinite-streams.scm")

(define (partial-sums S) 
  (cons-stream 
    (stream-car S)
    (add-streams (stream-cdr S)
		 (partial-sums S))))


(first-10-elements integers)

(define (log2-summands n) 
  (cons-stream (/ 1.0 n)
	       (stream-map - (log2-summands (+ n 1)))))

; (first-10-elements (log2-summands 1))

(define log2-stream 
  (partial-sums (log2-summands 1)))

(first-10-elements log2-stream)
(first-n-elements log2-stream 20)

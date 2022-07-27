(define (queens board-size)
  (define (queen-cols k) ; returns all ways to place queens in the first k columns of the board
    (if (= k 0)
      (list empty-board)
      (filter
        (lambda (positions) (safe? k positions))
        (flatmap
          (lambda (rest-of-queens) ; arg: a way to place k-1 queens in the first k-1 columns
            (map (lambda (new-row) ; a proposed row in which to place the queen for the kth column
                   (adjoin-position new-row k rest-of-queens)) ; adjoins a new row-column position to a set of positions
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board '())

(queens 5)
;--------- safe? ---------
; one solution 
; ((1 1) (2 2) (3 3))
(define positions '((3 3)
                    (2 2)
                    (1 3)))

(define (safe? k positions)
  (let ((all-row-numbers (map cadr positions)))
    (not (in? (car all-row-numbers) 
              (cdr all-row-numbers)))))

(define (all-row-numbers positions)
  (map cadr positions))


(define (in? a l)
  (cond ((null? l) #f)
        ((= a (car l)) #t)
        (else (in? a (cdr l)))))
;-------------------------------------------------

;-------------------- adjoin-position ------------
(define (adjoin-position new-row k rest-of-queens)
  (cons (list k new-row) rest-of-queens))
;-------------------------------------------------

;----------------- utitlites ---------------------
(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low 
          (enumerate-interval (+ low 1) high))))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))))

(define (flatmap proc seq)
    (accumulate append '() (map proc seq)))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))
;-------------------------------------------------

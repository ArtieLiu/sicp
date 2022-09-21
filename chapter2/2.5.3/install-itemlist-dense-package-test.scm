(load "tag.scm")
(load "put-get.scm")

(load "install-itemlist-dense-package.scm")
(install-itemlist-dense-package)

; ----------------- testing ----------------- 

(define add +)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error
	  "No method for these types: 
	  APPLY-GENERIC"
	  (list op type-tags))))))


(define L-regular (make-termlist-dense '( 2 1 0 )))
(first-term L-regular)
(rest-terms L-regular)

(define L-hollow (make-termlist-dense '(4 0 0 0 1)))
(first-term L-hollow)
(rest-terms L-hollow)

(define L-simple (make-termlist-dense '(1)))
(rest-terms L-simple)

(adjoin-term '(term 3 3)
	     '(termlist-dense -1))

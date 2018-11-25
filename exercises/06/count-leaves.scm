(require rackunit rackunit/text-ui)

(define root car)
(define left cadr)
(define right caddr)
(define empty? null?)

(define (leaf? tree)
  (and (not (empty? tree))
       (empty? (left tree))
       (empty? (right tree))))

(define (count-leaves tree)
  (cond ((empty? tree) 0)
        ((leaf? tree) 1)
        (else (+ (count-leaves (left tree))
                 (count-leaves (right tree))))))

(define count-leaves-tests
  (test-suite
   "Tests for count-leaves"

   (check = (count-leaves '()) 0)
   (check = (count-leaves '(1 () ())) 1)
   (check = (count-leaves '(1 (2 (4 () ()) (5 () ())) (3 () ()))) 3)))

(run-tests count-leaves-tests)

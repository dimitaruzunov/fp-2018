(require rackunit rackunit/text-ui)

(define (make-tree root left right)
  (list root left right))

(define root car)
(define left cadr)
(define right caddr)
(define empty? null?)

(define (map-tree fn tree)
  (if (null? tree)
      '()
      (make-tree (fn (root tree))
                 (map-tree fn (left tree))
                 (map-tree fn (right tree)))))

(define (square x) (* x x))
(define (cube x) (* x x x))

(define map-tree-tests
  (test-suite
   "Tests for map-tree"

   (check-equal? (map-tree square '()) '())
   (check-equal? (map-tree square '(4 () ())) '(16 () ()))
   (check-equal? (map-tree square '(1 (2 (4 () ()) (5 () ())) (3 () ())))
                 '(1 (4 (16 () ()) (25 () ())) (9 () ())))
   (check-equal? (map-tree cube '(1 (2 (4 () ()) (5 () ())) (3 () ())))
                 '(1 (8 (64 () ()) (125 () ())) (27 () ())))))

(run-tests map-tree-tests)

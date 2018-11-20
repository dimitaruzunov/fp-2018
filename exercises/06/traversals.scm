(require rackunit rackunit/text-ui)

(define root car)
(define left cadr)
(define right caddr)
(define empty? null?)

(define (pre-order tree)
  (if (empty? tree)
      '()
      (append (list (root tree))
              (pre-order (left tree))
              (pre-order (right tree)))))

(define (in-order tree)
  (if (empty? tree)
      '()
      (append (in-order (left tree))
              (list (root tree))
              (in-order (right tree)))))

(define (post-order tree)
  (if (empty? tree)
      '()
      (append (post-order (left tree))
              (post-order (right tree))
              (list (root tree)))))

(define traversals-tests
  (test-suite
   "Tests for traversals"

   (check-equal? (pre-order '(1 (2 (4 () ()) (5 () ())) (3 () ())))
                 '(1 2 4 5 3))
   (check-equal? (in-order '(1 (2 (4 () ()) (5 () ())) (3 () ()))) '(4 2 5 1 3))
   (check-equal? (post-order '(1 (2 (4 () ()) (5 () ())) (3 () ())))
                 '(4 5 2 3 1))))

(run-tests traversals-tests)

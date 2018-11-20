(require rackunit rackunit/text-ui)

(define root car)
(define left cadr)
(define right caddr)
(define empty? null?)

(define (level n tree)
  (cond ((empty? tree) '())
        ((= n 0) (list (root tree)))
        (else (append (level (- n 1) (left tree))
                      (level (- n 1) (right tree))))))

(define level-tests
  (test-suite
   "Tests for level"

   (check-equal? (level 0 '(1 (2 (4 () ()) (5 () ())) (3 () ()))) '(1))
   (check-equal? (level 1 '(1 (2 (4 () ()) (5 () ())) (3 () ()))) '(2 3))
   (check-equal? (level 2 '(1 (2 (4 () ()) (5 () ())) (3 () ()))) '(4 5))))

(run-tests level-tests)

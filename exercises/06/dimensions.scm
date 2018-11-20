(require rackunit rackunit/text-ui)

(define get-rows length)
(define (get-columns matrix) (length (car matrix)))

(define (dimensions matrix)
  (cons (get-rows matrix)
        (get-columns matrix)))

(define dimensions-tests
  (test-suite
   "Tests for dimensions"

   (check-equal? (dimensions '((1))) '(1 . 1))
   (check-equal? (dimensions '((1) (2))) '(2 . 1))
   (check-equal? (dimensions '((1 2 3) (4 5 6))) '(2 . 3))
   (check-equal? (dimensions '((1 2 3) (4 5 6) (7 8 9))) '(3 . 3))))

(run-tests dimensions-tests)

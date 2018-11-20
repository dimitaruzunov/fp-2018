(require rackunit rackunit/text-ui)

(define (reverse-columns matrix)
  (map reverse matrix))

(define reverse-columns-tests
  (test-suite
   "Tests for reverse-columns"

   (check-equal? (reverse-columns '((1))) '((1)))
   (check-equal? (reverse-columns '((1) (2))) '((1) (2)))
   (check-equal? (reverse-columns '((1 2 3))) '((3 2 1)))
   (check-equal? (reverse-columns '((1 2 3) (4 5 6))) '((3 2 1) (6 5 4)))
   (check-equal? (reverse-columns '((1 2 3) (4 5 6) (7 8 9)))
                 '((3 2 1) (6 5 4) (9 8 7)))))

(run-tests reverse-columns-tests)

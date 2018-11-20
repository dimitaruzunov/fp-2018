(require rackunit rackunit/text-ui)

(define (nth-column matrix n)
  (map (lambda (row) (list-ref row (- n 1)))
       matrix))

(define nth-column-tests
  (test-suite
   "Tests for nth-column"

   (check-equal? (nth-column '((1)) 1) '(1))
   (check-equal? (nth-column '((1) (2)) 1) '(1 2))
   (check-equal? (nth-column '((1 2 3)) 1) '(1))
   (check-equal? (nth-column '((1 2 3)) 2) '(2))
   (check-equal? (nth-column '((1 2 3)) 3) '(3))
   (check-equal? (nth-column '((1 2 3) (4 5 6)) 1) '(1 4))
   (check-equal? (nth-column '((1 2 3) (4 5 6)) 2) '(2 5))
   (check-equal? (nth-column '((1 2 3) (4 5 6)) 3) '(3 6))
   (check-equal? (nth-column '((1 2 3) (4 5 6) (7 8 9)) 3) '(3 6 9))
   (check-equal? (nth-column '((1 2 3 4) (5 6 7 8)) 4) '(4 8))))

(run-tests nth-column-tests)

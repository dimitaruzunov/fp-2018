(require rackunit rackunit/text-ui)

(define (quicksort l)
  (if (null? l)
      '()
      (let ((pivot (car l))
            (others (cdr l)))
        (append (quicksort (filter (lambda (x) (< x pivot)) others))
                (list pivot)
                (quicksort (filter (lambda (x) (>= x pivot)) others))))))

(define quicksort-tests
  (test-suite
   "Tests for quicksort"

   (check-equal? (quicksort '()) '())
   (check-equal? (quicksort '(42)) '(42))
   (check-equal? (quicksort '(6 6 6)) '(6 6 6))
   (check-equal? (quicksort '(1 2 3 4 5 6)) '(1 2 3 4 5 6))
   (check-equal? (quicksort '(6 5 4 3 2 1)) '(1 2 3 4 5 6))
   (check-equal? (quicksort '(3 1 4 6 2 5)) '(1 2 3 4 5 6))
   (check-equal? (quicksort '(5 2 5 1 5 2 3)) '(1 2 2 3 5 5 5))))

(run-tests quicksort-tests)

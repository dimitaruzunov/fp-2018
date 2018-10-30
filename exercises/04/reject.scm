(require rackunit rackunit/text-ui)

(define reject-tests
  (test-suite
   "Tests for reject"

   (check-equal? (reject even? '()) '())
   (check-equal? (reject even? '(42)) '())
   (check-equal? (reject odd? '(42)) '(42))
   (check-equal? (reject (lambda (x) (> x 0)) '(1 2 3 4)) '())
   (check-equal? (reject (lambda (x) (< x 0)) '(1 2 3 4)) '(1 2 3 4))
   (check-equal? (reject (lambda (x) (< x 0)) '(1 2 -42 3 4)) '(1 2 3 4))
   (check-equal? (reject even? '(8 4 92 82 8 13)) '(13))
   (check-equal? (reject odd? '(8 4 92 82 8 13)) '(8 4 92 82 8))))

(run-tests reject-tests)

(require rackunit rackunit/text-ui)

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(define accumulate-tests
  (test-suite
   "Tests for accumulate"

   (check = (accumulate + 0 square '()) 0)
   (check = (accumulate + 2 identity '(40)) 42)
   (check = (accumulate + 0 1+ '(1 2 3 4)) 14)
   (check = (accumulate * 1 square '(1 2 3 4 5)) 14400)
   (check = (accumulate * 0 square '(8 4 92 82 8 13)) 0)))

(define map-tests
  (test-suite
   "Tests for map"

   (check-equal? (map square '()) '())
   (check-equal? (map identity '(42)) '(42))
   (check-equal? (map 1+ '(41)) '(42))
   (check-equal? (map 1+ '(1 2 3 4)) '(2 3 4 5))
   (check-equal? (map square '(1 2 3 4 5)) '(1 4 9 16 25))
   (check-equal? (map identity '(8 4 92 82 8 13)) '(8 4 92 82 8 13))
   (check-equal? (map 1+ '(8 4 92 82 8 13)) '(9 5 93 83 9 14))))

(define filter-tests
  (test-suite
   "Tests for filter"

   (check-equal? (filter even? '()) '())
   (check-equal? (filter even? '(42)) '(42))
   (check-equal? (filter odd? '(42)) '())
   (check-equal? (filter (lambda (x) (> x 0)) '(1 2 3 4)) '(1 2 3 4))
   (check-equal? (filter (lambda (x) (< x 0)) '(1 2 3 4)) '())
   (check-equal? (filter (lambda (x) (< x 0)) '(1 2 -42 3 4)) '(-42))
   (check-equal? (filter even? '(8 4 92 82 8 13)) '(8 4 92 82 8))
   (check-equal? (filter odd? '(8 4 92 82 8 13)) '(13))))

(run-tests accumulate-tests)
(run-tests map-tests)
(run-tests filter-tests)

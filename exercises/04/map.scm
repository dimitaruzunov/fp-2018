(require rackunit rackunit/text-ui)

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

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

(run-tests map-tests)

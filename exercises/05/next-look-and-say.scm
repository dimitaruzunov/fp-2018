(require rackunit rackunit/text-ui)

(define next-look-and-say-tests
  (test-suite
   "Tests for next-look-and-say"

   (check-equal? (next-look-and-say '()) '())
   (check-equal? (next-look-and-say '(1)) '(1 1))
   (check-equal? (next-look-and-say '(1 1 2 3 3)) '(2 1 1 2 2 3))
   (check-equal? (next-look-and-say '(1 1 2 2 3 3 3 3)) '(2 1 2 2 4 3))))

(run-tests next-look-and-say-tests)

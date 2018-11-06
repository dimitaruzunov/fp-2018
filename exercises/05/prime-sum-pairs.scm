(require rackunit rackunit/text-ui)

(define prime-sum-pairs-tests
  (test-suite
   "Tests for prime-sum-pairs"

   (check-equal? (prime-sum-pairs 1) '())
   (check-equal? (prime-sum-pairs 2) '((2 1 3)))
   (check-equal? (prime-sum-pairs 6) '((2 1 3)
                                       (3 2 5)
                                       (4 1 5)
                                       (4 3 7)
                                       (5 2 7)
                                       (6 1 7)
                                       (6 5 11)))))

(run-tests prime-sum-pairs-tests)

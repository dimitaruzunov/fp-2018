(require rackunit rackunit/text-ui)

(define endomorphism?-tests
  (test-suite
   "Tests for endomorphism?"

   (check-true (endomorphism? '() + (lambda (x) (remainder x 3))))
   (check-true (endomorphism? '(0 1 4 6) + (lambda (x) x)))
   (check-true (endomorphism? '(0 1 4 6) + (lambda (x) (remainder x 3))))
   (check-false (endomorphism? '(0 1 4 5 6) + (lambda (x) (remainder x 3))))
   (check-false (endomorphism? '(0 1 4 6) expt (lambda (x) (+ x 1))))))

(run-tests endomorphism?-tests)

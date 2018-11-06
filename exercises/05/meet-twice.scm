(require rackunit rackunit/text-ui)

(define meet-twice?-tests
  (test-suite
   "Tests for meet-twice?"

   (check-true (meet-twice? (lambda (x) x) (lambda (x) x) 0 5))
   (check-true (meet-twice? (lambda (x) x) sqrt 0 5))
   (check-false (meet-twice? (lambda (x) x) (lambda (x) x) 42 42))
   (check-false (meet-twice? (lambda (x) x) (lambda (x) (- x)) -3 1))))

(run-tests meet-twice?-tests)

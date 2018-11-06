(require rackunit rackunit/text-ui)

(define middle-digit-tests
  (test-suite
   "Tests for middle-digit"

   (check = (middle-digit 0) 0)
   (check = (middle-digit 1) 1)
   (check = (middle-digit 42) -1)
   (check = (middle-digit 452) 5)
   (check = (middle-digit 4712) -1)
   (check = (middle-digit 47124) 1)
   (check = (middle-digit 1892364) 2)
   (check = (middle-digit 38912734) -1)))

(run-tests middle-digit-tests)

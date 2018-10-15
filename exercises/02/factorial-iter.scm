(require rackunit rackunit/text-ui)

(define factorial-iter-tests
  (test-suite
   "Tests for factorial-iter"

   (check = (factorial-iter 0) 1)
   (check = (factorial-iter 1) 1)
   (check = (factorial-iter 2) 2)
   (check = (factorial-iter 3) 6)
   (check = (factorial-iter 4) 24)
   (check = (factorial-iter 5) 120)
   (check = (factorial-iter 6) 720)
   (check = (factorial-iter 7) 5040)))

(run-tests factorial-iter-tests)

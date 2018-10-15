(require rackunit rackunit/text-ui)

(define fast-expt-iter-tests
  (test-suite
   "Tests for fast-expt-iter"

   (check = (fast-expt-iter -2 -11) -1/2048)
   (check = (fast-expt-iter -2 -10) 1/1024)
   (check = (fast-expt-iter 2 -10) 1/1024)
   (check = (fast-expt-iter 5 -3) 1/125)
   (check = (fast-expt-iter 3 -2) 1/9)
   (check = (fast-expt-iter 2 -2) 1/4)
   (check = (fast-expt-iter 2 -1) 1/2)
   (check = (fast-expt-iter 2 0) 1)
   (check = (fast-expt-iter 2 1) 2)
   (check = (fast-expt-iter 2 2) 4)
   (check = (fast-expt-iter 3 2) 9)
   (check = (fast-expt-iter 5 3) 125)
   (check = (fast-expt-iter 2 10) 1024)
   (check = (fast-expt-iter -2 10) 1024)
   (check = (fast-expt-iter -2 11) -2048)))

(run-tests fast-expt-iter-tests)
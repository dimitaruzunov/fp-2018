(require rackunit rackunit/text-ui)

(define expt-tests
  (test-suite
   "Tests for expt"

   (check = (expt -2 -11) -1/2048)
   (check = (expt -2 -10) 1/1024)
   (check = (expt 2 -10) 1/1024)
   (check = (expt 5 -3) 1/125)
   (check = (expt 3 -2) 1/9)
   (check = (expt 2 -2) 1/4)
   (check = (expt 2 -1) 1/2)
   (check = (expt 2 0) 1)
   (check = (expt 2 1) 2)
   (check = (expt 2 2) 4)
   (check = (expt 3 2) 9)
   (check = (expt 5 3) 125)
   (check = (expt 2 10) 1024)
   (check = (expt -2 10) 1024)
   (check = (expt -2 11) -2048)))

(run-tests expt-tests)

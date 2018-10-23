(require rackunit rackunit/text-ui)

(define (sum-digits n)
  (if (= n 0)
      0
      (+ (remainder n 10)
         (sum-digits (quotient n 10)))))

(define (sum-digits-iter n)
  (define (iter sum n)
    (if (= n 0)
        sum
        (iter (+ (remainder n 10) sum)
              (quotient n 10))))

  (iter 0 n))

(define sum-digits-tests
  (test-suite
   "Tests for sum-digits"

   (check = (sum-digits 0) 0)
   (check = (sum-digits 3) 3)
   (check = (sum-digits 12) 3)
   (check = (sum-digits 42) 6)
   (check = (sum-digits 666) 18)
   (check = (sum-digits 1337) 14)
   (check = (sum-digits 65510) 17)
   (check = (sum-digits 8833443388) 52)
   (check = (sum-digits 100000000000) 1)))

(run-tests sum-digits-tests)

(define sum-digits-iter-tests
  (test-suite
   "Tests for sum-digits-iter"

   (check = (sum-digits-iter 0) 0)
   (check = (sum-digits-iter 3) 3)
   (check = (sum-digits-iter 12) 3)
   (check = (sum-digits-iter 42) 6)
   (check = (sum-digits-iter 666) 18)
   (check = (sum-digits-iter 1337) 14)
   (check = (sum-digits-iter 65510) 17)
   (check = (sum-digits-iter 8833443388) 52)
   (check = (sum-digits-iter 100000000000) 1)))

(run-tests sum-digits-iter-tests)

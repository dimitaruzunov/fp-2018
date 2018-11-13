(require rackunit rackunit/text-ui)

(define (last-digit n)
  (remainder n 10))

(define (without-last-digit n)
  (quotient n 10))

(define (count-digits n)
  (if (< n 10)
      1
      (+ 1
         (count-digits (without-last-digit n)))))

(define (middle-digit n)
  (define (kth-digit-from-last k n)
    (if (= k 0)
        (last-digit n)
        (kth-digit-from-last (- k 1) (without-last-digit n))))

  (define digit-count (count-digits n))

  (if (even? digit-count)
      -1
      (kth-digit-from-last (quotient digit-count 2) n)))

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

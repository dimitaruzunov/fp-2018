(require rackunit rackunit/text-ui)

(define (prime? n)
  (define (count-divisors n)
    (define (divides? k n)
      (= (remainder n k) 0))

    (define (divisors-up-to k)
      (cond ((= k 0) 0)
            ((divides? k n)
             (+ 1 (divisors-up-to (- k 1))))
            (else (divisors-up-to (- k 1)))))

    (divisors-up-to n))

  (= (count-divisors n) 2))

(define prime?-tests
  (test-suite
   "Tests for prime?"

   (check-true (prime? 3))
   (check-true (prime? 19))
   (check-true (prime? 599))
   (check-true (prime? 661))
   (check-true (prime? 2221))
   (check-true (prime? 7879))

   (check-false (prime? 1))
   (check-false (prime? 12))
   (check-false (prime? 15))
   (check-false (prime? 42))
   (check-false (prime? 666))
   (check-false (prime? 1337))
   (check-false (prime? 65515))
   (check-false (prime? 1234567))))

(run-tests prime?-tests)

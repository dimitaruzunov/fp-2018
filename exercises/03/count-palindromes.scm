(require rackunit rackunit/text-ui)

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (accumulate combiner
                  (combiner (term a) null-value)
                  term
                  (next a)
                  next
                  b)))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (count predicate a b)
  (sum (lambda (a)
         (if (predicate a)
             1
             0))
       a
       (lambda (a) (+ a 1))
       b))

(define (count-palindromes a b)
  (define (reverse-digits n)
    (define (iter reversed n)
      (if (= n 0)
          reversed
          (iter (+ (* reversed 10)
                   (remainder n 10))
                (quotient n 10))))

    (iter 0 n))

  (define (palindrome? n)
    (= n (reverse-digits n)))

  (count palindrome? a b))

(define count-palindromes-tests
  (test-suite
   "Tests for count-palindromes"

   (check = (count-palindromes 1 5) 5)
   (check = (count-palindromes 0 10) 10)
   (check = (count-palindromes 11 100) 9)
   (check = (count-palindromes 101 1000) 90)))

(run-tests count-palindromes-tests)

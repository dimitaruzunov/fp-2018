(require rackunit rackunit/text-ui)

(define (partial-right fn . args)
  (lambda rest-args
    (apply fn (append rest-args args))))

(define (partial fn . args)
  (lambda rest-args
    (apply fn (append args rest-args))))

(define sum (partial foldl + 0))

(define (digits number)
  (define (iter number digits)
    (if (< number 10)
        (cons number digits)
        (iter (quotient number 10)
              (cons (remainder number 10) digits))))

  (iter number '()))

(define (narcissistic? number)
  (define digits-list (digits number))
  (define digits-count (length digits-list))
  (= number
     (sum
       (map (partial-right expt digits-count)
            digits-list))))

(define narcissistic?-tests
  (test-suite
   "Tests for narcissistic?"

   (check-true (narcissistic? 1))
   (check-true (narcissistic? 8))
   (check-true (narcissistic? 153))
   (check-false (narcissistic? 154))  
   (check-false (narcissistic? 42))))

(run-tests narcissistic?-tests)

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (divides? divisor divident)
  (= (remainder divident divisor) 0))

(define (divisors number)
  (filter (partial-right divides? number)
          (enumerate-interval 1 (quotient number 2))))

(define (friendly? a b)
  (and (= (sum (divisors a)) b)
       (= (sum (divisors b)) a)))

(define friendly?-tests
  (test-suite
   "Tests for friendly?-tests"

   (check-true (friendly? 0 0))
   (check-true (friendly? 220 284))
   (check-true (friendly? 284 220))
   (check-false (friendly? 1 1))
   (check-false (friendly? 2 2))))

(run-tests friendly?-tests)

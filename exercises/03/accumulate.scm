(require rackunit rackunit/text-ui)

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner
                            null-value
                            term
                            (next a)
                            next
                            b))))

(define (accumulate-iter combiner null-value term a next b)
  (if (> a b)
      null-value
      (accumulate-iter combiner
                       (combiner (term a) null-value)
                       term
                       (next a)
                       next
                       b)))

(define (sum term a next b)
  (accumulate-iter + 0 term a next b))

(define (product term a next b)
  (accumulate-iter * 1 term a next b))

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(define accumulate-tests
  (test-suite
   "Tests for accumulate"

   (check = (accumulate + 0 identity 1 1+ 5) 15)
   (check = (accumulate + 0 square 1 1+ 5) 55)

   (check = (accumulate * 0 identity 1 1+ 5) 0)
   (check = (accumulate * 1 identity 0 1+ 5) 0)
   (check = (accumulate * 1 identity 1 1+ 5) 120)

   (check = (accumulate (lambda (x acc)
                          (if (even? x) (1+ acc) acc))
                        0
                        identity
                        0 1+ 10)
          6)
   (check = (accumulate +
                        0
                        (lambda (x)
                          (if (even? x) 1 0))
                        0 1+ 10)
          6)))

(define accumulate-iter-tests
  (test-suite
   "Tests for accumulate-iter"

   (check = (accumulate-iter + 0 identity 1 1+ 5) 15)
   (check = (accumulate-iter + 0 square 1 1+ 5) 55)

   (check = (accumulate-iter * 0 identity 1 1+ 5) 0)
   (check = (accumulate-iter * 1 identity 0 1+ 5) 0)
   (check = (accumulate-iter * 1 identity 1 1+ 5) 120)

   (check = (accumulate-iter (lambda (x acc)
                               (if (even? x) (1+ acc) acc))
                             0
                             identity
                             0 1+ 10)
          6)
   (check = (accumulate-iter +
                             0
                             (lambda (x)
                               (if (even? x) 1 0))
                             0 1+ 10)
          6)))

(define sum-tests
  (test-suite
   "Tests for sum"

   (check = (sum identity 1 1+ 5) 15)
   (check = (sum square 1 1+ 5) 55)
   (check = (sum (lambda (x)
                   (if (even? x) 1 0))
                 0 1+ 10)
          6)))

(define product-tests
  (test-suite
   "Tests for product"

   (check = (product identity 0 1+ 5) 0)
   (check = (product identity 1 1+ 5) 120)
   (check = (product (lambda (x)
                       (if (even? x) x 1))
                     1 1+ 10)
          3840)))

(run-tests accumulate-tests)
(run-tests accumulate-iter-tests)
(run-tests sum-tests)
(run-tests product-tests)

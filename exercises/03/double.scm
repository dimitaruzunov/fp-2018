(require rackunit rackunit/text-ui)

(define (double f)
  (lambda (x)
    (f (f x))))

(define (1+ x) (+ x 1))
(define (square x) (* x x))

(define double-tests
  (test-suite
   "Tests for double"

   (check = ((double 1+) 0) 2)
   (check = ((double square) 2) 16)
   (check = ((double (double 1+)) 0) 4)
   (check = (((double double) 1+) 0) 4)
   (check = (((double (double double)) 1+) 0) 16)
   (check = (((double (double double)) 1+) 5) 21)))

(run-tests double-tests)

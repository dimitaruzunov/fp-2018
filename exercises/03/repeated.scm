(require rackunit rackunit/text-ui)

(define (repeated f n)
  (lambda (x)
    (if (= n 0)
        x
        (f ((repeated f (- n 1)) x)))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (lambda (x)
    (if (= n 0)
        x
        ((compose f (repeated f (- n 1))) x))))

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (lambda (x)
        (f ((repeated f (- n 1)) x)))))

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))

(define (identity x) x)
(define (1+ x) (+ x 1))
(define (square x) (* x x))

(define repeated-tests
  (test-suite
   "Tests for repeated"

   (check = ((repeated identity 0) 0) 0)
   (check = ((repeated identity 5) 1) 1)

   (check = ((repeated 1+ 0) 5) 5)
   (check = ((repeated 1+ 5) 0) 5)
   (check = ((repeated 1+ 5) 5) 10)

   (check = ((repeated square 0) 5) 5)
   (check = ((repeated square 1) 5) 25)
   (check = ((repeated square 2) 5) 625)))

(run-tests repeated-tests)

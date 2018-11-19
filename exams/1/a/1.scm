(require rackunit rackunit/text-ui)

(define (reverse-number n)
  (define (iter reversed n)
    (if (= n 0)
        reversed
        (iter (+ (* reversed 10)
                 (remainder n 10))
              (quotient n 10))))

  (iter 0 n))

(define (diff-reverse n)
  (- n (reverse-number n)))

(define diff-reverse-tests
  (test-suite
   "Tests for diff-reverse"

   (check = (diff-reverse 0) 0)
   (check = (diff-reverse 8) 0)
   (check = (diff-reverse 42) 18)
   (check = (diff-reverse 7641) 6174)
   (check = (diff-reverse 760410) 746343)))

(run-tests diff-reverse-tests)

(define (identity x) x)

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

(define (partial f . args)
  (lambda rest-args
    (apply f (append args rest-args))))

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (digit-count digit n)
  (if (< n 10)
      (if (= n digit) 1 0)
      (let ((last-digit (remainder n 10))
            (without-last-digit (quotient n 10)))
        (if (= last-digit digit)
            (+ 1 (digit-count digit without-last-digit))
            (digit-count digit without-last-digit)))))

(define (sort-digits n)
  (define (append-digit digit n)
    (+ (* 10 n) digit))

  (define (repeated-append-digit digit n times)
    ((repeated (partial append-digit digit) times) n))

  (foldl (lambda (digit sorted)
           (repeated-append-digit digit sorted (digit-count digit n)))
         0
         (reverse (enumerate-interval 0 9))))

(define sort-digits-tests
  (test-suite
   "Tests for sort-digits"

   (check = (sort-digits 0) 0)
   (check = (sort-digits 8) 8)
   (check = (sort-digits 42) 42)
   (check = (sort-digits 24) 42)
   (check = (sort-digits 6174) 7641)
   (check = (sort-digits 610704110) 764111000)))

(run-tests sort-digits-tests)

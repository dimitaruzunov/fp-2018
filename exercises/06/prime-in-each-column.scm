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

(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (any? p l)
  (not (every? (compose not p) l)))

(define (transpose matrix)
  (apply map list matrix))

(define (for-all-columns? p matrix)
  (every? p (transpose matrix)))

(define (prime-in-each-column? matrix)
  (define (prime-exists? l)
    (any? prime? l))

  (for-all-columns? prime-exists? matrix))

(define prime-in-each-column?-tests
  (test-suite
   "Tests for prime-in-each-column?"

   (check-false (prime-in-each-column? '((1))))
   (check-true (prime-in-each-column? '((1) (2))))
   (check-false (prime-in-each-column? '((1 2 3))))
   (check-true (prime-in-each-column? '((1 2 3) (2 3 4))))
   (check-true (prime-in-each-column? '((17 2 16) (4 5 3))))
   (check-true (prime-in-each-column? '((1 2 3) (4 5 6) (7 8 9))))
   (check-false (prime-in-each-column? '((1 2 3) (4 5 6) (42 8 9))))))

(run-tests prime-in-each-column?-tests)

(require rackunit rackunit/text-ui)

(define (identity x) x)

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

(define (permutable? a b f g)
  (define (alternate f g n)
    (repeated (compose f g) n))

  (every? (lambda (x)
            (= ((alternate f g (/ x 2)) x)
               ((alternate g f (/ x 2)) x)))
          (filter even? (enumerate-interval a b))))

(define (square x) (* x x))
(define (cube x) (* x x x))
(define (const-42 x) 42)
(define (2^ x) (expt 2 x))

(define permutable?-tests
  (test-suite
   "Tests for permutable?"

   (check-true (permutable? 2 1 square cube))
   (check-true (permutable? 1 1 square cube))
   (check-true (permutable? 0 1 square cube))
   (check-true (permutable? 1 9 square cube))
   (check-true (permutable? 1 2 square 2^))  
   (check-true (permutable? 0 0 square const-42))  
   (check-false (permutable? 1 4 square 2^))))

(run-tests permutable?-tests)

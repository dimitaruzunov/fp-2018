(require rackunit rackunit/text-ui)

(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (endomorphism? l op f)
  (define (is-image-in-l? x)
    (member (f x) l))

  (define (f-preserves-op? x y)
    (= (+ (f x) (f y))
       (f (+ x y))))

  (and (every? is-image-in-l? l)
       (every? (lambda (x)
                 (every? (lambda (y)
                           (f-preserves-op? x y))
                         l))
               l)))

(define endomorphism?-tests
  (test-suite
   "Tests for endomorphism?"

   (check-true (endomorphism? '() + (lambda (x) (remainder x 3))))
   (check-true (endomorphism? '(0 1 4 6) + (lambda (x) x)))
   (check-true (endomorphism? '(0 1 4 6) + (lambda (x) (remainder x 3))))
   (check-false (endomorphism? '(0 1 4 5 6) + (lambda (x) (remainder x 3))))
   (check-false (endomorphism? '(0 1 4 6) expt (lambda (x) (+ x 1))))))

(run-tests endomorphism?-tests)

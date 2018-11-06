(require rackunit rackunit/text-ui)

(define (endomorphism? l op f)
  (define (every? p l)
    (foldl (lambda (x acc)
             (and x acc))
           #t
           (map p l)))

  (define (is-in-l? x)
    (member x l))

  (define (f-preserves-op? x y)
    (= (+ (f x) (f y))
       (f (+ x y))))

  (and (every? is-in-l? (map f l))
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

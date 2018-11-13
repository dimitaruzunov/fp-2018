(require rackunit rackunit/text-ui)

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (any? p l)
  (and (not (null? l))
       (or (p (car l))
           (any? p (cdr l)))))

(define (meet-twice? f g a b)
  (define interval (enumerate-interval a b))

  (any? (lambda (x)
          (any? (lambda (y)
                  (and (not (= x y))
                       (= (f x) (g x))
                       (= (f y) (g y))))
                interval))
        interval))

(define meet-twice?-tests
  (test-suite
   "Tests for meet-twice?"

   (check-true (meet-twice? (lambda (x) x) (lambda (x) x) 0 5))
   (check-true (meet-twice? (lambda (x) x) sqrt 0 5))
   (check-false (meet-twice? (lambda (x) x) (lambda (x) x) 42 42))
   (check-false (meet-twice? (lambda (x) x) (lambda (x) (- x)) -3 1))))

(run-tests meet-twice?-tests)

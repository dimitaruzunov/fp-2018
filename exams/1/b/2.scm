(require rackunit rackunit/text-ui)

(define (partial fn . args)
  (lambda rest-args
    (apply fn (append args rest-args))))

(define (flatmap f l)
  (apply append (map f l)))

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (find-max f a b)
  (define (iterate f i j)
    (foldr f j (enumerate-interval i (- j 1))))

  (define pairs
    (flatmap (lambda (i)
               (map (partial list i)
                    (enumerate-interval (+ i 1) b)))
             (enumerate-interval a (- b 1))))

  (apply max
         (map (lambda (pair)
                (iterate f (car pair) (cadr pair)))
              pairs)))

(define find-max-tests
  (test-suite
   "Tests for find-max"

   (check = (find-max + 0 1) 1)
   (check = (find-max + 0 2) 3)
   (check = (find-max + -1 2) 3)
   (check = (find-max - -1 2) 1)
   (check = (find-max - 1 5) 4)
   (check = (find-max - -6 -1) -1)
   (check = (find-max (lambda (x y) (- (max x y))) -1 3) 1)))

(run-tests find-max-tests)

(require rackunit rackunit/text-ui)

(define (partial-right f . args)
  (lambda rest-args
    (apply f (append rest-args args))))

(define (max-by comparing l)
  (define (comparator x y)
    (if (>= (comparing x) (comparing y))
        x
        y))

  (foldl comparator (car l) (cdr l)))

(define (sort-by comparing l)
  (define (insert x l)
    (cond ((null? l)
           (list x))
          ((<= (comparing x) (comparing (car l)))
           (cons x l))
          (else (cons (car l)
                      (insert x (cdr l))))))

  (foldl insert '() l))

(define (longest-interval-subsets intervals)
  (define (length interval)
    (- (cdr interval) (car interval)))

  (define (subset? x y)
    (<= (car y) (car x) (cdr x) (cdr y)))

  (if (null? intervals)
      '()
      (let ((longest-interval (max-by length intervals)))
        (sort-by car
                 (filter (partial-right subset? longest-interval) intervals)))))

(define longest-interval-subsets-tests
  (test-suite
   "Tests for longest-interval-subsets"

   (check-equal? (longest-interval-subsets '()) '())
   (check-equal? (longest-interval-subsets '((1 . 3))) '((1 . 3)))
   (check-equal? (longest-interval-subsets '((1 . 1))) '((1 . 1)))
   (check-equal? (longest-interval-subsets '((24 . 25) (90 . 110) (0 . 100)
                                             (10 . 109) (1 . 3) (-4 . 2)))
                 '((0 . 100) (1 . 3) (24 . 25)))))

(run-tests longest-interval-subsets-tests)

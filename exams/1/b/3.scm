(require rackunit rackunit/text-ui)

(define (partial f . args)
  (lambda rest-args
    (apply f (append args rest-args))))

(define (min-by comparing l)
  (define (comparator x y)
    (if (<= (comparing x) (comparing y))
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

(define (shortest-interval-supersets intervals)
  (define (length interval)
    (- (cdr interval) (car interval)))

  (define (subset? x y)
    (<= (car y) (car x) (cdr x) (cdr y)))

  (if (null? intervals)
      '()
      (let ((shortest-interval (min-by length intervals)))
        (sort-by cdr
                 (filter (partial subset? shortest-interval) intervals)))))

(define shortest-interval-supersets-tests
  (test-suite
   "Tests for shortest-interval-supersets"

   (check-equal? (shortest-interval-supersets '()) '())
   (check-equal? (shortest-interval-supersets '((1 . 3))) '((1 . 3)))
   (check-equal? (shortest-interval-supersets '((1 . 1))) '((1 . 1)))
   (check-equal? (shortest-interval-supersets '((24 . 26) (90 . 110) (0 . 100)
                                                (10 . 89) (1 . 5) (-4 . 25)))
                 '((24 . 26) (10 . 89) (0 . 100)))))

(run-tests shortest-interval-supersets-tests)

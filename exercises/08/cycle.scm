(require rackunit rackunit/text-ui)

(define the-empty-stream '())

(define-syntax cons-stream
  (syntax-rules ()
                ((cons-stream h t)
                 (cons h (delay t)))))

(define (empty-stream? s)
  (equal? s the-empty-stream))

(define head car)

(define (tail s)
  (force (cdr s)))

(define (cycle l)
  (define (iter remaining)
    (if (null? remaining)
        (iter l)
        (cons-stream (car remaining)
                     (iter (cdr remaining)))))

  (if (null? l)
      the-empty-stream
      (iter l)))

(define (stream-take n s)
  (if (or (= n 0)
          (empty-stream? s))
      '()
      (cons (head s)
            (stream-take (- n 1) (tail s)))))

(define cycle-tests
  (test-suite
   "Tests for cycle"

   (check-equal? (stream-take 5 (cycle '())) '())
   (check-equal? (stream-take 5 (cycle '(1))) '(1 1 1 1 1))
   (check-equal? (stream-take 3 (cycle '(6))) '(6 6 6))
   (check-equal? (stream-take 2 (cycle '(1 2 3))) '(1 2))
   (check-equal? (stream-take 5 (cycle '(1 2 3))) '(1 2 3 1 2))
   (check-equal? (stream-take 7 (cycle '(1 2 3))) '(1 2 3 1 2 3 1))))

(run-tests cycle-tests)

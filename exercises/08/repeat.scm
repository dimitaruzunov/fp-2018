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

(define (repeat value)
  (cons-stream value (repeat value)))

(define (stream-take n s)
  (if (or (= n 0)
          (empty-stream? s))
      '()
      (cons (head s)
            (stream-take (- n 1) (tail s)))))

(define repeat-tests
  (test-suite
   "Tests for repeat"

   (check-equal? (stream-take 5 (repeat 1)) '(1 1 1 1 1))
   (check-equal? (stream-take 3 (repeat 6)) '(6 6 6))
   (check-equal? (stream-take 6 (repeat '())) '(() () () () () ()))
   (check-equal? (stream-take 3 (repeat '(1 2 3))) '((1 2 3) (1 2 3) (1 2 3)))))

(run-tests repeat-tests)

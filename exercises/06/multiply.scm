(require rackunit rackunit/text-ui)

(define (multiply-vectors u v)
  (apply + (map * u v)))

(define (transpose matrix)
  (apply map list matrix))

(define (multiply a b)
  (let ((b-transposed (transpose b)))
    (map (lambda (row)
           (map (lambda (column)
                  (multiply-vectors row column))
                b-transposed))
         a)))

(define multiply-tests
  (test-suite
   "Tests for multiply"

   (check-equal? (multiply '((2)) '((21))) '((42)))
   (check-equal? (multiply '((1) (2)) '((21))) '((21) (42)))
   (check-equal? (multiply '((0 21)) '((1) (2))) '((42)))
   (check-equal? (multiply '((1 2 3) (3 2 1) (1 2 3))
                           '((4 5 6) (6 5 4) (4 6 5)))
                 '((28 33 29) (28 31 31) (28 33 29)))))

(run-tests multiply-tests)

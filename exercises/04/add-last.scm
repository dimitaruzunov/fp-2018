(require rackunit rackunit/text-ui)

(define (add-last l x)
  (if (null? l)
      (cons x '())
      (cons (car l)
            (add-last (cdr l) x))))

(define (add-last l x)
  (reverse (cons x (reverse l))))

(define (add-last l x)
  (append l (cons x '())))

(define add-last-tests
  (test-suite
   "Tests for add-last"

   (check-equal? (add-last '() 42) '(42))
   (check-equal? (add-last '(42) 1) '(42 1))
   (check-equal? (add-last '(1 2 3 4) 42) '(1 2 3 4 42))
   (check-equal? (add-last '(1 2 3 4) 4) '(1 2 3 4 4))
   (check-equal? (add-last '(8 4 92 82 8 13) 0) '(8 4 92 82 8 13 0))))

(run-tests add-last-tests)

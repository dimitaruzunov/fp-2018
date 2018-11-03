(require rackunit rackunit/text-ui)

(define (filter p l)
  (cond ((null? l) '())
        ((p (car l)) (cons (car l)
                           (filter p (cdr l))))
        (else (filter p (cdr l)))))

(define filter-tests
  (test-suite
   "Tests for filter"

   (check-equal? (filter even? '()) '())
   (check-equal? (filter even? '(42)) '(42))
   (check-equal? (filter odd? '(42)) '())
   (check-equal? (filter (lambda (x) (> x 0)) '(1 2 3 4)) '(1 2 3 4))
   (check-equal? (filter (lambda (x) (< x 0)) '(1 2 3 4)) '())
   (check-equal? (filter (lambda (x) (< x 0)) '(1 2 -42 3 4)) '(-42))
   (check-equal? (filter even? '(8 4 92 82 8 13)) '(8 4 92 82 8))
   (check-equal? (filter odd? '(8 4 92 82 8 13)) '(13))))

(run-tests filter-tests)

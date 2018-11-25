(require rackunit rackunit/text-ui)

(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (any? p l)
  (not (every? (compose not p) l)))

(define (transpose matrix)
  (apply map list matrix))

(define (count-columns matrix)
  (define (subset? column row)
    (every? (lambda (x) (member x row))
            column))

  (define (subset-of-row? column)
    (any? (lambda (row) (subset? column row))
          matrix))

  (length (filter subset-of-row?
                  (transpose matrix))))

(define count-columns-tests
  (test-suite
   "Tests for count-columns"

   (check = (count-columns '((1))) 1)
   (check = (count-columns '((1 2))) 2)
   (check = (count-columns '((1) (2))) 0)
   (check = (count-columns '((1 3 5 7) (2 5 3 4))) 2)
   (check = (count-columns '((1 3 5 7) (2 5 3 7))) 3)
   (check = (count-columns '((1 4 3) (4 5 6) (7 4 9))) 1)
   (check = (count-columns '((1 4 3) (4 5 6) (7 3 9))) 0)))

(run-tests count-columns-tests)

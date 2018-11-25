(require rackunit rackunit/text-ui)

(define (enumerate-interval from to)
  (if (> from to)
      '()
      (cons from
            (enumerate-interval (+ from 1) to))))

(define (get-columns matrix) (length (car matrix)))

(define (nth-column matrix n)
  (map (lambda (row) (list-ref row (- n 1)))
       matrix))

(define (transpose matrix)
  (map (lambda (i) (nth-column matrix i))
       (enumerate-interval 1 (get-columns matrix))))

; Или по-кратко:
(define (transpose matrix)
  (apply map list matrix))

(define transpose-tests
  (test-suite
   "Tests for transpose"

   (check-equal? (transpose '((1))) '((1)))
   (check-equal? (transpose '((1) (2))) '((1 2)))
   (check-equal? (transpose '((1 2 3))) '((1) (2) (3)))
   (check-equal? (transpose '((1 2 3) (4 5 6))) '((1 4) (2 5) (3 6)))
   (check-equal? (transpose '((1 2 3) (4 5 6) (7 8 9)))
                 '((1 4 7) (2 5 8) (3 6 9)))))

(run-tests transpose-tests)

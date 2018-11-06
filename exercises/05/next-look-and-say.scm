(require rackunit rackunit/text-ui)

(define (next-look-and-say l)
  (define (take-while p l)
    (if (or (null? l)
            (not (p (car l))))
        '()
        (cons (car l)
              (take-while p (cdr l)))))

  (define (drop-while p l)
    (if (or (null? l)
            (not (p (car l))))
        l
        (drop-while p (cdr l))))

  (define (take-first-equals l)
    (take-while (lambda (x)
                  (= x (car l)))
                l))

  (define (drop-first-equals l)
    (drop-while (lambda (x)
                  (= x (car l)))
                l))

  (if (null? l)
      '()
      (cons (length (take-first-equals l))
            (cons (car l)
                  (next-look-and-say (drop-first-equals l))))))

(define next-look-and-say-tests
  (test-suite
   "Tests for next-look-and-say"

   (check-equal? (next-look-and-say '()) '())
   (check-equal? (next-look-and-say '(1)) '(1 1))
   (check-equal? (next-look-and-say '(1 1 2 3 3)) '(2 1 1 2 2 3))
   (check-equal? (next-look-and-say '(1 1 2 2 3 3 3 3)) '(2 1 2 2 4 3))))

(run-tests next-look-and-say-tests)

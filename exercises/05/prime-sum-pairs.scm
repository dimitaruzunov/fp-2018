(require rackunit rackunit/text-ui)

(define (enumerate-interval a b)
  (if (< b a)
      '()
      (cons a
            (enumerate-interval (+ a 1) b))))

(define (flatmap f l)
  (foldr append '() (map f l)))

(define (prime? n)
  (define (count-divisors n)
    (define (divides? k n)
      (= (remainder n k) 0))

    (define (divisors-up-to k)
      (cond ((= k 0) 0)
            ((divides? k n)
             (+ 1 (divisors-up-to (- k 1))))
            (else (divisors-up-to (- k 1)))))

    (divisors-up-to n))

  (= (count-divisors n) 2))

(define (prime-sum-pairs n)
  (define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))

  (define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

  (map make-pair-sum
       (filter prime-sum?
               (flatmap (lambda (i)
                          (map (lambda (j) (list i j))
                               (enumerate-interval 1 (- i 1))))
                        (enumerate-interval 1 n)))))

(define prime-sum-pairs-tests
  (test-suite
   "Tests for prime-sum-pairs"

   (check-equal? (prime-sum-pairs 1) '())
   (check-equal? (prime-sum-pairs 2) '((2 1 3)))
   (check-equal? (prime-sum-pairs 6) '((2 1 3)
                                       (3 2 5)
                                       (4 1 5)
                                       (4 3 7)
                                       (5 2 7)
                                       (6 1 7)
                                       (6 5 11)))))

(run-tests prime-sum-pairs-tests)

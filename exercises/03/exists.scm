(require rackunit rackunit/text-ui)

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (accumulate combiner
                  (combiner (term a) null-value)
                  term
                  (next a)
                  next
                  b)))

; Тъй като or е специална форма, не можем да подадем or директно като аргумент
; на accumulate. Затова използваме lambda, която изпълнява or над двата си
; аргумента. При това решение винаги минаваме през целия интервал [a, b],
; независимо дали преди края му има цяло число, удовлетворяващо predicate.
(define (exists? predicate a b)
  (accumulate (lambda (current acc)
                (or current acc))
              #f
              predicate
              a
              (lambda (a) (+ a 1))
              b))

; По-ефикасно решение, тъй като or е специална форма и след първото срещане на
; цяло число n, което удовлетворява predicate, няма да бъде разгледан
; подинтервала [n + 1, b].
(define (exists? predicate a b)
  (and (<= a b)
       (or (predicate a)
           (exists? predicate (+ a 1) b))))

(define exists?-tests
  (test-suite
   "Tests for exists?"

   (check-true (exists? (lambda (x) (= x 3)) 1 5))
   (check-true (exists? (lambda (x) (< x 0)) -3 9))
   (check-true (exists? (lambda (x) (= 0 (* x 0))) -3 15))

   (check-false (exists? (lambda (x) (= x 13)) 1 5))
   (check-false (exists? (lambda (x) (< x 3)) 10 42))
   (check-false (exists? (lambda (x) (< x 0)) 3 8))
   (check-false (exists? (lambda (x) (= 0 (* x 0))) 2 1))))

(run-tests exists?-tests)

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

(define (sum term a next b)
  (accumulate + 0 term a next b))

; Можем да изразим процедурата count чрез сума от нули и единици. Идеята е да
; добавяме 1 за всяко цяло число, което удовлетворява predicate, и 0 за всяко
; цяло число, което не удовлетворява predicate.
(define (count predicate a b)
  (sum (lambda (a)
         (if (predicate a)
             1
             0))
       a
       (lambda (a) (+ a 1))
       b))

; Друг вариант: изразяваме count чрез натрупване на единици само за целите
; числа, които удовлетворяват predicate. Добавяме 1 към акумулатора (acc) само
; ако текущото цяло число от интервала (current) удовлетворява predicate, иначе
; не променяме acc.
(define (count predicate a b)
  (accumulate (lambda (current acc)
                (if (predicate current)
                    (+ acc 1)
                    acc))
              0
              (lambda (a) a)
              a
              (lambda (a) (+ a 1))
              b))

(define count-tests
  (test-suite
   "Tests for count"

   (check = (count even? 1 5) 2)
   (check = (count even? 0 10) 6)

   (check = (count odd? 1 5) 3)
   (check = (count odd? 0 10) 5)))

(run-tests count-tests)

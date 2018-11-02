(require rackunit rackunit/text-ui)

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2
            (f (- n 2)))
         (* 3
            (f (- n 3))))))

(define (f-iter n)
  (define (iter current next after-next counter)
    (if (= counter n)
        current
        (iter next
              after-next
              (+ after-next
                 (* 2 next)
                 (* 3 current))
              (+ counter 1))))

  (iter 0 1 2 0))

(define f-tests
  (test-suite
   "Tests for f"

   (check = (f 0) 0)
   (check = (f 1) 1)
   (check = (f 2) 2)
   (check = (f 3) 4)
   (check = (f 4) 11)
   (check = (f 5) 25)
   (check = (f 6) 59)
   (check = (f 7) 142)))

(define f-iter-tests
  (test-suite
   "Tests for f-iter"

   (check = (f-iter 0) 0)
   (check = (f-iter 1) 1)
   (check = (f-iter 2) 2)
   (check = (f-iter 3) 4)
   (check = (f-iter 4) 11)
   (check = (f-iter 5) 25)
   (check = (f-iter 6) 59)
   (check = (f-iter 7) 142)))

(run-tests f-tests)
(run-tests f-iter-tests)

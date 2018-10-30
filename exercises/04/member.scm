(require rackunit rackunit/text-ui)

(define member?-tests
  (test-suite
   "Tests for member?"

   (check-true (member? 2 '(2)))
   (check-true (member? 1 '(1 2)))
   (check-true (member? 2 '(1 2)))
   (check-true (member? 8 '(8 4 82 12 31 133)))
   (check-true (member? 4 '(8 4 82 12 31 133)))
   (check-true (member? 82 '(8 4 82 12 31 133)))
   (check-true (member? 12 '(8 4 82 12 31 133)))
   (check-true (member? 31 '(8 4 82 12 31 133)))
   (check-true (member? 133 '(8 4 82 12 31 133)))
   (check-true (member? 33 (range 0 42)))

   (check-false (member? 42 '()))
   (check-false (member? 1 '(2)))
   (check-false (member? 3 '(1 2)))
   (check-false (member? 42 '(8 4 82 12 31 133)))
   (check-false (member? 3 '(8 4 82 12 31 133)))
   (check-false (member? 1000 '(8 4 82 12 31 133)))
   (check-false (member? 42 (range 0 42)))))

(run-tests member?-tests)

(require rackunit rackunit/text-ui)

(define the-empty-stream '())

(define-syntax cons-stream
  (syntax-rules ()
                ((cons-stream h t)
                 (cons h (delay t)))))

(define (empty-stream? s)
  (equal? s the-empty-stream))

(define head car)

(define (tail s)
  (force (cdr s)))

(define (range-stream from to)
  (if (> from to)
      the-empty-stream
      (cons-stream from
                   (range-stream (+ from 1) to))))

(define (integers-from n)
  (cons-stream n (integers-from (+ n 1))))

(define (map-stream f s)
  (if (empty-stream? s)
      the-empty-stream
      (cons-stream (f (head s))
                   (map-stream f (tail s)))))

(define (filter-stream p s)
  (cond ((empty-stream? s)
         the-empty-stream)
        ((p (head s))
         (cons-stream (head s)
                      (filter-stream p (tail s))))
        (else (filter-stream p (tail s)))))

(define (append-streams s1 s2)
  (if (empty-stream? s1)
      s2
      (cons-stream (head s1)
                   (append-streams (tail s1) s2))))

(define (concat-streams ss)
  (cond ((empty-stream? ss) the-empty-stream)
        ((empty-stream? (head ss)) (concat-streams (tail ss)))
        (else (cons-stream (head (head ss))
                           (append-streams (tail (head ss))
                                           (concat-streams (tail ss)))))))

(define (flatmap-stream f s)
  (concat-streams (map-stream f s)))

(define triples
  (flatmap-stream (lambda (c)
                    (flatmap-stream (lambda (b)
                                      (map-stream (lambda (a)
                                                    (list a b c))
                                                  (range-stream 1 b)))
                                    (range-stream 1 c)))
                  (integers-from 1)))

(define (square x) (* x x))

(define pythagorean-triples
  (filter-stream (lambda (triple)
                   (= (+ (square (car triple)) (square (cadr triple)))
                      (square (caddr triple))))
                 triples))

(define (stream-take n s)
  (if (or (= n 0)
          (empty-stream? s))
      '()
      (cons (head s)
            (stream-take (- n 1) (tail s)))))

(define pythagorean-triples-tests
  (test-suite
   "Tests for pythagorean-triples"

   (check-equal? (stream-take 5 pythagorean-triples)
                 '((3 4 5) (6 8 10) (5 12 13) (9 12 15) (8 15 17)))))

(run-tests pythagorean-triples-tests)

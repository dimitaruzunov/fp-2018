(require rackunit rackunit/text-ui)

(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (flatmap fn l)
  (apply append (map fn l)))

(define (search p l)
  (and (not (null? l))
       (or (p (car l))
           (search p (cdr l)))))

(define (add-if-missing x l)
  (if (member x l)
      l
      (cons x l)))

(define (keys alist)
  (map car alist))

(define (assoc key alist)
  (search (lambda (key-value-pair)
            (and (equal? (car key-value-pair) key)
                 key-value-pair))
          alist))

(define (del-assoc key alist)
  (filter (lambda (key-value-pair)
            (not (equal? (car key-value-pair) key)))
          alist))

(define (add-assoc key value alist)
  (cons (cons key value)
        (del-assoc key alist)))

(define (empty-graph) '())

(define vertices keys)

(define (children v g)
  (cdr (assoc v g)))

(define (edge? u v g)
  (member v (children u g)))

(define (add-vertex v g)
  (if (assoc v g)
      g
      (add-assoc v '() g)))

(define (add-edge u v g)
  (let ((g-with-u-v (add-vertex v (add-vertex u g))))
    (add-assoc u
               (add-if-missing v (children u g-with-u-v))
               g-with-u-v)))

(define (edges g)
  (flatmap (lambda (vertex)
             (map (lambda (child) (list vertex child))
                  (children vertex g)))
           (vertices g)))

(define (symmetric? g)
  (every? (lambda (edge)
            (edge? (cadr edge) (car edge) g))
          (edges g)))

(define graph
  (add-vertex
   'd
   (add-edge
    'c 'b
    (add-edge
     'b 'c
     (add-edge
      'a 'c
      (add-edge
       'a 'b
       (empty-graph)))))))

(define symmetric-graph
  (add-edge
   'c 'a
   (add-edge
    'b 'a
    graph)))

(define symmetric?-tests
  (test-suite
   "Tests for symmetric?"

   (check-false (symmetric? graph))
   (check-true (symmetric? symmetric-graph))))

(run-tests symmetric?-tests)

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

(define (make-alist fn keys)
  (map (lambda (key) (cons key (fn key)))
       keys))

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

(define (make-graph vs)
  (make-alist (lambda (_) '())
              vs))

(define vertices keys)

(define (children v g)
  (cdr (assoc v g)))

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

(define (invert g)
  (foldl (lambda (edge g-inverted)
           (add-edge (cadr edge) (car edge) g-inverted))
         (make-graph (vertices g))
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

(define graph-inverted
  (add-vertex
   'd
   (add-edge
    'b 'c
    (add-edge
     'c 'b
     (add-edge
      'c 'a
      (add-edge
       'b 'a
       (empty-graph)))))))

(define (subset? s1 s2)
  (every? (lambda (x) (member x s2))
          s1))

(define (set-equal? s1 s2)
  (and (subset? s1 s2)
       (subset? s2 s1)))

(define (graphs-equal? g1 g2)
  (define (vertices-equal? g1 g2)
    (set-equal? (vertices g1) (vertices g2)))

  (define (edges-equal? g1 g2)
    (set-equal? (edges g1) (edges g2)))

  (and (vertices-equal? g1 g2)
       (edges-equal? g1 g2)))

(define invert-tests
  (test-suite
   "Tests for invert"

   (check graphs-equal? (invert graph) graph-inverted)))

(run-tests invert-tests)

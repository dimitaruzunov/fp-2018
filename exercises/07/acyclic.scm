(require rackunit rackunit/text-ui)

(define (search p l)
  (and (not (null? l))
       (or (p (car l))
           (search p (cdr l)))))

(define (add-if-missing x l)
  (if (member x l)
      l (cons x l)))

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

(define (search-child v p g)
  (search p (children v g)))

(define (add-vertex v g)
  (if (assoc v g)
      g
      (add-assoc v '() g)))

(define (add-edge u v g)
  (let ((g-with-u-v (add-vertex v (add-vertex u g))))
    (add-assoc u
               (add-if-missing v (children u g-with-u-v))
               g-with-u-v)))

(define (remove-edge u v g)
  (add-assoc u
             (remove v (children u g))
             g))

(define (acyclic? g)
  (define (dfs path)
    (let ((current (car path)))
      (or (member current (cdr path))
          (search-child current
                        (lambda (child)
                          (dfs (cons child path)))
                        g))))

  (not (search (lambda (vertex)
                 (dfs (list vertex)))
               (vertices g))))

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

(define acyclic-graph
  (remove-edge 'c 'b graph))

(define acyclic?-tests
  (test-suite
   "Tests for acyclic?"

   (check-true (acyclic? acyclic-graph))
   (check-false (acyclic? graph))))

(run-tests acyclic?-tests)

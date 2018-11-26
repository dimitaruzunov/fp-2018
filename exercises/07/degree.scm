(require rackunit rackunit/text-ui)

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

(define (add-vertex v g)
  (if (assoc v g)
      g
      (add-assoc v '() g)))

(define (add-edge u v g)
  (let ((g-with-u-v (add-vertex v (add-vertex u g))))
    (add-assoc u
               (add-if-missing v (children u g-with-u-v))
               g-with-u-v)))

(define (degree v g)
  (define (degree- v g)
    (length (children v g)))

  (define (degree+ v g)
    (length (filter (lambda (u)
                      (member v (children u g)))
                    (vertices g))))

  (+ (degree- v g)
     (degree+ v g)))

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

(define degree-tests
  (test-suite
   "Tests for degree"

   (check = (degree 'a graph) 2)
   (check = (degree 'b graph) 3)
   (check = (degree 'c graph) 3)
   (check = (degree 'd graph) 0)))

(run-tests degree-tests)

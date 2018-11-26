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

; constructors
(define (empty-graph) '())

(define (make-graph vs)
  (make-alist (lambda (_) '())
              vs))

; selectors
(define vertices keys)

(define (children v g)
  (cdr (assoc v g)))

(define (edge? u v g)
  (member v (children u g)))

(define (map-children v fn g)
  (map fn (children v g)))

(define (search-child v p g)
  (search p (children v g)))

; transformations
(define (add-vertex v g)
  (if (assoc v g)
      g
      (add-assoc v '() g)))

(define (remove-vertex v g)
  (map (lambda (vertex-children-pair)
         (remove v (cdr vertex-children-pair)))
       (del-assoc v g)))

(define (add-edge u v g)
  (let ((g-with-u-v (add-vertex v (add-vertex u g))))
    (add-assoc u
               (add-if-missing v (children u g-with-u-v))
               g-with-u-v)))

(define (remove-edge u v g)
  (add-assoc u
             (remove v (children u g))
             g))

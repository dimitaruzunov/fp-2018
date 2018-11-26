(define (search p l)
  (and (not (null? l))
       (or (p (car l))
           (search p (cdr l)))))

; constructor
(define (make-alist fn keys)
  (map (lambda (key) (cons key (fn key)))
       keys))

; selectors
(define (keys alist)
  (map car alist))

(define (values alist)
  (map cdr alist))

(define (assoc key alist)
  (search (lambda (key-value-pair)
            (and (equal? (car key-value-pair) key)
                 key-value-pair))
          alist))

; transformations
(define (del-assoc key alist)
  (filter (lambda (key-value-pair)
            (not (equal? (car key-value-pair) key)))
          alist))

(define (add-assoc key value alist)
  (cons (cons key value)
        (del-assoc key alist)))

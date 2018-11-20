(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3)
           (tree? (cadr t))
           (tree? (caddr t)))))

(define (make-tree root left right)
  (list root left right))

(define root car)
(define left cadr)
(define right caddr)
(define empty? null?)

(define (leaf? tree)
  (and (not (empty? tree))
       (empty? (left tree))
       (empty? (right tree))))

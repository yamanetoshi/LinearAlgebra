(define (accumulate op initial sequence) 
  (if (null? sequence) 
      initial 
      (op (car sequence) 
	  (accumulate op initial (cdr sequence))))) 

(define (accumulate-n op init sequence) 
  (if (null? (car sequence)) 
      '()
      (cons (accumulate op init (map car sequence)) 
	    (accumulate-n op init (map cdr sequence))))) 

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (m-*-v m v) 
  (map (lambda (row-m) (dot-product row-m v)) m))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (m-*-m m n)
  (let ((cols (transpose n)))
    (map (lambda (row-m)
	   (map (lambda (row-cols)
		  (dot-product row-m row-cols))
		cols))
	 m)))

(define (trA l)
  (let trA-inner ((idx 0) (rslt 0) (l l))
    (if (null? l)
	rslt
	(trA-inner (+ 1 idx) (+ rslt (list-ref (car l) idx)) (cdr l))))
  )

(define (detA-2 l)
  (- (* (car (car l)) (cadr (cadr l)))
     (* (car (cadr l)) (cadr (car l)))))

(define (scalar-*-v s v)
  (map (lambda (x) (* s x)) v))

(define (scalar-*-m s m)
  (map (lambda (x) (scalar-*-v s x)) m))

(define (inverse-2 m)
  (let ((detA (detA-2 m))
	(lst (list (list (cadr (cadr m)) (- (cadr (car m))))
		   (list (- (car (cadr m))) (car (car m))))))
    (if (= 0 detA)
	#f
	(scalar-*-m (/ 1 detA) lst))))

(define (enum-0-list n)
  (if (= 0 n)
      '()
      (cons 0 (enum-0-list (- n 1)))))

(define (enum-0-m n)
  (let f ((deg n) (n n))
    (if (= 0 n)
	'()
	(cons (enum-0-list deg) (f deg (- n 1))))))

(define (enum-1-list n pos)
  (if (= 0 n)
      '()
      (cons (if (= 0 (- n pos)) 1 0) (enum-1-list (- n 1) pos))))

(define (enum-I-m n)
  (let f ((deg n) (n n))
    (if (= 0 n)
	'()
	(cons (enum-1-list deg n) (f deg (- n 1))))))

(define (F-i-lambda row n l)
  (let f ((i 1) (l l))
    (if (null? l)
	'()
	(cons (if (= row i)
		  (scalar-*-v n (car l))
		  (car l))
	      (f (+ i 1) (cdr l))))))

(define (getRow row l)
  (let f ((i 1) (l l))
    (cond ((null? l) #f)
	  ((= i row) (car l))
	  (else
	   (f (+ i 1) (cdr l))))))

(define (F-i-j i j l)
  (let ((row-i (getRow i l))
	(row-j (getRow j l)))
    (let f ((now 1)
	    (l l))
      (if (null? l)
	  '()
	  (cons (cond ((= now i) row-j)
		      ((= now j) row-i)
		      (else (car l)))
		(f (+ now 1) (cdr l)))))))

(define (v-+-v v1 v2)
  (if (null? v1)
      '()
      (cons (+ (car v1) (car v2))
	    (v-+-v (cdr v1) (cdr v2)))))

(define (F-i-j-lambda i j n l)
  (let f ((row (v-+-v (scalar-*-v n (getRow j l))
		      (getRow i l)))
	  (now 1)
	  (l l))
    (if (null? l)
	'()
	(cons (if (= now i)
		  row
		  (car l))
	      (f row (+ now 1) (cdr l))))))


;  (let* ((sw (< i j))
;	 (row (v-+-v (scalar-*-v n (getRow (if sw j i) l))
;		     (getRow (if sw i j) l))))
;    (let f ((now 1)
;	    (l l))
;      (if (null? l)
;	  '()
;	  (cons (if (= now (if sw i j))
;		    row
;		    (car l))
;		(f (+ now 1) (cdr l)))))))

;  (let f ((row (v-+-v (scalar-*-v n (getRow (if (< i j) j i) l))
;		      (getRow (if (< i j) i j) l)))
;	  (now 1)
;	  (l l))
;    (if (null? l)
;	'()
;	(cons (if (= now (if (< i j) i j))
;		  row
;		  (car l))
;	      (f row (+ now 1) (cdr l))))))

(use gauche.test)

(add-load-path ".")
(load "2.37")

(test-start "dot-product")
(test-section "dot-product")
(test* "(dot-product '(0 9) '(2 0))"
       0
       (dot-product '(0 9) '(2 0)))

(test* "(dot-product '(2 0) '(2 0))"
       4
       (dot-product '(2 0) '(2 0)))

(test* "(dot-product '(1 1) '(3 1))"
       4
       (dot-product '(1 1) '(3 1)))

(test-section "m-*-v")
(test* "(m-*-v '((1 2 3) (4 5 6)) '(1 2 3))"
       '(14 32)
       (m-*-v '((1 2 3) (4 5 6)) '(1 2 3)))
(test* "(m-*-v '((1 2) (0 -1)) '(3 4))"
       '(11 -4)
       (m-*-v '((1 2) (0 -1)) '(3 4)))

(test-section "transpose")
(test* "(transpose '((1 2 3) (4 5 6) (7 8 9)))"
       '((1 4 7) (2 5 8) (3 6 9))
       (transpose '((1 2 3) (4 5 6) (7 8 9))))

(test-section "m-*-m")
(test* "(m-*-m '((1 3) (2 4)) '((4 2) (3 1)))"
       '((13 5) (20 8))
       (m-*-m '((1 3) (2 4)) '((4 2) (3 1))))

(test* "(m-*-m '((4 2) (3 1)) '((1 3) (2 4)))"
       '((8 20) (5 13))
       (m-*-m '((4 2) (3 1)) '((1 3) (2 4))))

(test* "(m-*-m '((1 2) (0 -1)) '((3) (4)))"
       '((11) (-4))
       (m-*-m '((1 2) (0 -1)) '((3) (4))))

(test* "(m-*-m '((2 1) (-1 3)) '((0 1) (1 -2)))"
       '((1 0) (3 -7))
       (m-*-m '((2 1) (-1 3)) '((0 1) (1 -2))))

(test-section "trA")
(test* "(trA '((1 2 3) (4 5 6) (7 8 9)))"
       15
       (trA '((1 2 3) (4 5 6) (7 8 9))))

(test-section "detA-2")
(test* "(detA-2 '((1 2) (3 4)))"
       -2
       (detA-2 '((1 2) (3 4))))
(test* "(detA-2 '((2 3) (2 3)))"
       0
       (detA-2 '((2 3) (2 3))))

(test-section "scalar-*-v")
(test* "(scalar-*-v 2 '(1 2))"
       '(2 4)
       (scalar-*-v 2 '(1 2)))

(test-section "scalar-*-m")
(test* "(scalar-*-m 2 '((1 2) (3 4)))"
       '((2 4) (6 8))
       (scalar-*-m 2 '((1 2) (3 4))))

(test-section "inverse-2")
(test* "(inverse-2 '((2 3) (2 3)))"
       #f
       (inverse-2 '((2 3) (2 3))))

(test* "(inverse-2 '((2 5) (1 2)))"
       '((-2 5) (1 -2))
       (inverse-2 '((2 5) (1 2))))

(test* "(inverse-2 '((-2 6) (2 -4)))"
       '((1 3/2) (1/2 1/2))
       (inverse-2 '((-2 6) (2 -4))))

(test-section "enum-0-list")
(test* "(enum-0-list 0)"
       '()
       (enum-0-list 0))

(test* "(enum-0-list 1)"
       '(0)
       (enum-0-list 1))

(test* "(enum-0-list 2)"
       '(0 0)
       (enum-0-list 2))

(test-section "enum-0-m")
(test* "(enum-0-m 2)"
       '((0 0) (0 0))
       (enum-0-m 2))

(test* "(enum-0-m 3)"
       '((0 0 0) (0 0 0) (0 0 0))
       (enum-0-m 3))

(test* "(enum-0-m 4)"
       '((0 0 0 0) (0 0 0 0) (0 0 0 0) (0 0 0 0))
       (enum-0-m 4))

(test-section "enum-1-list")
(test* "(enum-1-list 2 2)"
       '(1 0)
       (enum-1-list 2 2))

(test* "(enum-1-list 2 1)"
       '(0 1)
       (enum-1-list 2 1))

(test* "(enum-1-list 3 3)"
       '(1 0 0)
       (enum-1-list 3 3))

(test* "(enum-1-list 3 2)"
       '(0 1 0)
       (enum-1-list 3 2))

(test* "(enum-1-list 3 1)"
       '(0 0 1)
       (enum-1-list 3 1))

(test-section "enum-I-m")
(test* "(enum-I-m 2)"
       '((1 0) (0 1))
       (enum-I-m 2))

(test* "(enum-I-m 3)"
       '((1 0 0) (0 1 0) (0 0 1))
       (enum-I-m 3))

(test* "(enum-I-m 4)"
       '((1 0 0 0) (0 1 0 0) (0 0 1 0) (0 0 0 1))
       (enum-I-m 4))

(test* "(enum-I-m 5)"
       '((1 0 0 0 0) (0 1 0 0 0) (0 0 1 0 0) (0 0 0 1 0) (0 0 0 0 1))
       (enum-I-m 5))

(test-section "Fi(lambda)")
(test* "(F-i-lambda 1 2 '((1 0) (0 1)))"
       '((2 0) (0 1))
       (F-i-lambda 1 2 '((1 0) (0 1))))

(test* "(F-i-lambda 2 1/2 '((1 0 0) (0 1 0) (0 0 1)))"
       '((1 0 0) (0 1/2 0) (0 0 1))
       (F-i-lambda 2 1/2 '((1 0 0) (0 1 0) (0 0 1))))

(test-section "getRow")
(test* "(getRow 3 '((1 0) (0 1)))"
       #f
       (getRow 3 '((1 0) (0 1))))

(test* "(getRow 2 '((1 0) (0 1)))"
       '(0 1)
       (getRow 2 '((1 0) (0 1))))

(test* "(getRow 1 '((1 0) (0 1)))"
       '(1 0)
       (getRow 1 '((1 0) (0 1))))

(test-section "Fij")
(test* "(F-i-j 1 2 '((1 0 0) (0 1 0) (0 0 1)))"
       '((0 1 0) (1 0 0) (0 0 1))
       (F-i-j 1 2 '((1 0 0) (0 1 0) (0 0 1))))

(test-section "v-+-v")
(test* "(v-+-v '(1 0) '(0 1))"
       '(1 1)
       (v-+-v '(1 0) '(0 1)))

(test-section "Fij-lambda")
(test* "(F-i-j-lambda 1 2 -3 '((1 0) (0 1)))"
       '((1 -3) (0 1))
       (F-i-j-lambda 1 2 -3 '((1 0) (0 1))))

(test* "(F-i-j-lambda 2 1 -3 '((1 0) (0 1)))"
       '((1 0) (-3 1))
       (F-i-j-lambda 2 1 -3 '((1 0) (0 1))))
       
(test* "(F-i-j-lambda 1 2 1/2 '((1 0 0) (0 1 0) (0 0 1)))"
       '((1 1/2 0) (0 1 0) (0 0 1))
       (F-i-j-lambda 1 2 1/2 '((1 0 0) (0 1 0) (0 0 1))))

(test* "(F-i-j-lambda 2 1 1/2 '((1 0 0) (0 1 0) (0 0 1)))"
       '((1 0 0) (1/2 1 0) (0 0 1))
       (F-i-j-lambda 2 1 1/2 '((1 0 0) (0 1 0) (0 0 1))))

(test-end)

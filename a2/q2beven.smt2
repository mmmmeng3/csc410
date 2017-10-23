(declare-fun prefa (Int) Int)
(declare-fun prefb (Int) Int)
(declare-fun prefc (Int) Int)
(declare-fun prefd (Int) Int)
(declare-const ac Int)
(declare-const ab Int)
(declare-const ad Int)

(declare-const bc Int)
(declare-const bd Int)

(declare-const cd Int)

(declare-const a Int)
(declare-const b Int)
(declare-const c Int)
(declare-const d Int)



(assert (and (>= a 0) (>= b 0) (>= c 0) (>= d 0)))
(assert (and (<= ab 1) (<= ac 1) (<= ad 1) (<= bc 1) (<= bd 1) (<= cd 1)))
(assert (and (>= ab 0) (>= ac 0) (>= ad 0) (>= bc 0) (>= bd 0) (>= cd 0)))

(assert(and (= a b) (= b c) (= c d)))

(assert (or (and (> ab ac) (= a ac ad)) (and (> ac ab) (= ab ad a)) (and (> ad ab) (= ab ac a))))  

(assert (or (and (> ab bc) (= b bc bd)) (and (> bc ab) (= ab bd b)) (and (> bd ab) (= ab bc b))))

(assert (or (and (> ac bc) (= c bc cd)) (and (> bc ac) (= ac cd c)) (and (> cd ac) (= ac bc c))))

(assert (or (and (> ad bd) (= d bd cd)) (and (> bd ad) (= ad cd d)) (and (> cd ad) (= ad bd d))))



(assert (and (= (prefa a) ad) ))
(assert (and (= (prefd d) ad) ))
(assert (and (= (prefc c) ac) ))
(assert (and (= (prefb b) ab) ))

(maximize (+ (prefa a) (prefb b) (prefc c) (prefd d)))




(check-sat)
(get-objectives)
(get-model)
(declare-fun prefa (Int) Int)
(declare-fun prefb (Int) Int)
(declare-fun prefc (Int) Int)
(declare-fun prefd (Int) Int)
(declare-fun prefe (Int) Int)
(declare-const ac Int)
(declare-const ab Int)
(declare-const ad Int)
(declare-const ae Int)
(declare-const bc Int)
(declare-const bd Int)
(declare-const be Int)
(declare-const cd Int)
(declare-const ce Int)
(declare-const de Int)
(declare-const a Int)
(declare-const b Int)
(declare-const c Int)
(declare-const d Int)
(declare-const e Int)


(assert (and (>= a 0) (>= b 0) (>= c 0) (>= d 0) (>= e 0) (>= ab 0) (>= ac 0) (>= ad 0) (>= bc 0) (>= bd 0) (>= cd 0) (>= ae 0) (>= be 0) (>= ce 0) (>= de 0)))
(assert (and (<= ab 1) (<= ac 1) (<= ad 1) (<= bc 1) (<= bd 1) (<= cd 1) (<= ae 1) (<= be 1) (<= ce 1) (<= de 1) (<= a 1) (<= b 1) (<= c 1) (<= e 1)))


(assert (or (and (> ab ac) (= ac a ad ae)) (and (> ac ab) (= ab ad ae a)) (and (> ad ab) (= ab ac ae a)) (and (> ae ab) (= ab ac ad a)) (and (> a ab) (= ab ac ad ae))))  


(assert (or (and (> ab bc) (= bc b bd be)) (and (> bc ab) (= ab bd be b)) (and (> bd ab) (= ab bc be b)) (and (> be ab) (= ab bc bd b)) (and (> b ab) (= ab bc bd be))))


(assert (or (and (> ac bc) (= bc c cd ce)) (and (> bc ac) (= ac cd ce c)) (and (> cd ac) (= ac bc ce c)) (and (> ce ac) (= ac bc cd c)) (and (> c ac) (= ac bc cd ce))))


(assert (or (and (> ad bd) (= bd d cd de)) (and (> bd ad) (= ad cd de d)) (and (> cd ad) (= ad bd de d)) (and (> de bd) (= ad bd cd d)) (and (> d ad) (= ad bd cd de))))


(assert (or (and (> ae be) (= be e ce de)) (and (> be ae) (= ae ce de e)) (and (> ce ae) (= ae be de e)) (and (> de ae) (= ae be ce e)) (and (> e ae) (= ae be ce de))))

(assert (or (and (> a b) (= b c d e)) (and (> b a) (= a c d e)) (and (> c a) (= a b d e)) (and (> d a) (= a b c e)) (and (> e a) (= a b c d))))



(assert (or (= (prefa a) ab) (= (prefa a) ac) (= (prefa a) ad)))

(assert (or (= (prefb b) ab) (= (prefb b) bc) (= (prefb b) be)))

(assert (or (= (prefc c) ac) (= (prefc c) bc)))

(assert (= (prefd d) ad))

(assert (= (prefe e) be))

(maximize (+ (prefa a) (prefb b) (prefc c) (prefd d) (prefe e)))




(check-sat)
(get-objectives)
(get-model)
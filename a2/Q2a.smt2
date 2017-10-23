(declare-const ac Bool)
(declare-const ab Bool)
(declare-const ad Bool)
(declare-const ae Bool)
(declare-const bc Bool)
(declare-const bd Bool)
(declare-const be Bool)
(declare-const cd Bool)
(declare-const ce Bool)
(declare-const de Bool)
(declare-const a Bool)
(declare-const b Bool)
(declare-const c Bool)
(declare-const d Bool)
(declare-const e Bool)





(assert (or (and  a (not b) (not c) (not d) (not e)) (and  b (not a) (not c) (not d) (not e)) (and  c (not b) (not a) (not d) (not e)) (and  d (not b) (not c) (not a) (not e)) (and  e (not b) (not c) (not d) (not a))))


(assert (or (and  ab (not ac) (not ad) (not ae)(not a)) (and  ac (not ab) (not ad) (not ae)(not a)) (and  ad (not ab) (not ac) (not ae)(not a)) (and  ae (not ab) (not ac) (not ad)(not a)) (and  a (not ab) (not ac) (not ad)(not ae))))


(assert (or (and  ab (not bc) (not bd) (not be)(not b)) (and  bc (not ab) (not bd) (not be)(not b)) (and  bd (not ab) (not bc) (not be)(not b)) (and  be (not ab) (not bc) (not bd)(not b)) (and  b (not ab) (not bc) (not bd)(not be))))

(assert (or (and  ac (not bc) (not cd) (not ce)(not c)) (and  bc (not ac) (not cd) (not ce)(not c)) (and  cd (not ac) (not bc) (not ce)(not c)) (and  ce (not ac) (not bc) (not cd)(not c)) (and  c (not ac) (not bc) (not cd)(not ce))))

(assert (or (and  ad (not bd) (not cd) (not de)(not d)) (and  bd (not ad) (not cd) (not de)(not d)) (and  cd (not ad) (not bd) (not de)(not d)) (and  de (not ad) (not bd) (not cd)(not d)) (and  d (not ad) (not bd) (not cd)(not de))))

(assert (or (and  ae (not be) (not ce) (not de)(not e)) (and  be (not ae) (not ce) (not de)(not e)) (and  ce (not ae) (not be) (not de)(not e)) (and  de (not ae) (not be) (not ce)(not e)) (and  e (not ae) (not be) (not ce)(not de))))


(assert-soft (or (and ab (not ac) (not ad)) (and ac (not ab) (not ad)) (and ad (not ac) (not ab))) :weight 2)

(assert-soft (or (and ab (not bc) (not be)) (and bc (not ab) (not be)) (and be (not ab) (not bc))) :weight 2)

(assert-soft (or (and ac (not ab) ) (and ab (not ac))) :weight 2)

(assert-soft ad :weight 2)

(assert-soft be :weight 2)




(check-sat)
(get-objectives)
(get-model)
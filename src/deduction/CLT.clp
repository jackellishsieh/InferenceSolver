/*
* ======================================================================
* LARGE COUNTS
* ======================================================================
*/

(deftemplate CLT (slot which) (slot value))     ; Boolean for if passes CLT
(do-backward-chaining CLT)

/*
* Check if CLT applies
*/
(defrule CLT
    (need-CLT (which ?which) (value ?value))

    (sampleSize (which ?which) (value ?sampleSize))
    =>
    (assert (CLT (which ?which) (value (>= ?sampleSize 30))))
)


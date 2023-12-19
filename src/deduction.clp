/*
* Rules for logical inferences and error checking
*/

(batch src/deduction/calculation.clp)
(batch src/deduction/CLT.clp)
(batch src/deduction/largeCounts.clp)

/*
* ======================================================================
* DEDUCTION
* ======================================================================
*/
/*
* Always use a z-test or z-interval for proportions
*/
(defrule proportionZTest
    (need-testType ?)
    
    (parameterType "proportion")
    =>
    (assert (testType "z"))
)

/*
* For a two-proportion test, the hypothesis proportion difference is always 0
*/
(defrule twoProportionTest-hypothesisProportionDifference
    (need-hypothesisProportionDifference ?)

    ; Technically unnecessary since these only happen when a hypothesis proportion difference is needed
    (procedureType "test")
    (parameterType "proportion")
    (numSamples "two")

    =>
    (assert (hypothesisProportionDifference 0))
)

/*
* For a two-mean test, the hypothesis mean difference will now always be 0
*/
(defrule twoProportionTest-hypothesisMeanDifference
    (need-hypothesisMeanDifference ?)

    ; Technically unnecessary since these only happen when a hypothesis proportion difference is needed
    (procedureType "test")
    (parameterType "mean")
    (numSamples "two")

    =>
    (assert (hypothesisMeanDifference 0))
)

; /*
; * ======================================================================
; * ERRORS
; * ======================================================================
; */
; /*
; * If a mean is used, the sample is too small, the population is not normally distributed, 
; * z is used, throw an error
; */
; (defrule nonNormalSamplingDistribution-mean-z
;     (declare (salience 1))

;     (parameterType "mean")
;     (CLT FALSE)
;     (populationNormality "not normal")
;     (testType "z")

;     =>

;     (printout t crlf crlf "ERROR: Sampling distribution is not normal. No inference procedures are possible.")
;     (bind ?exception (new java.lang.Exception))
;     (throw ?exception)
; )

; /*
; * If a mean is used, the sample is too small, the population is not normally distributed, 
; * t is used, and the sample distribution is not balanced, throw an error
; */
; (defrule nonNormalSamplingDistribution-mean-t
;     (declare (salience 1))

;     (parameterType "mean")
;     (CLT FALSE)
;     (populationNormality "not normal")
;     (testType "t")
;     (sampleBalance "not balanced")

;     =>

;     (printout t crlf crlf "ERROR: Sampling distribution is not normal. No inference procedures are possible.")
;     (bind ?exception (new java.lang.Exception))
;     (throw ?exception)
; )

; /*
; * If a proportion is used and the sample is too small, throw an error
; */
; (defrule nonNormalSamplingDistribution-proportion
;     (declare (salience 1))

;     (parameterType "proportion")
;     (LargeCounts FALSE)

;     =>

;     (printout t crlf crlf "ERROR: Sampling distribution is not normal. No inference procedures are possible.")
;     (bind ?exception (new java.lang.Exception))
;     (throw ?exception)
; )
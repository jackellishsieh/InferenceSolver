/*
* ======================================================================
* CALCULATION
* Only for values that are calculated for multiple variants
* Any calculation for just one variant should be located in the appropriate section alone
* ======================================================================
*/
(do-backward-chaining significant)                  ; Boolean for if the test result is significant. Not user queried.
(do-backward-chaining degreesOfFreedom)             ; Integer for degrees of freedom
(do-backward-chaining confidencePercentage)         ; Float for confidence level as a percentage (*100), derived from alpha value

; (do-backward-chaining pooledProportion)             ; Pooled proportion for pooled proportion tests


; (do-backward-chaining sampleProportionDifference)   ; Proportion difference for two-sample proportion intervals
; (do-backward-chaining sampleMeanDifference)         ; Sample mean difference for two-sample mean intervals

/* 
* Check if a p-value is significant
*/
(defrule significant
    (need-significant ?)
    
    (pValue ?pValue)
    (alpha ?alpha)

    =>
    (assert (significant (<= ?pValue ?alpha)))
)

/* 
* For a one-sample t-test, degrees of freedom = sample size - 1
*/
(defrule degreesOfFreedom-one
    (need-degreesOfFreedom ?)

    (numSamples "one")

    (sampleSize (which ?*ONLY*) (value ?sampleSize))

    =>
    (bind ?degreesOfFreedom (- ?sampleSize 1))
    (assert (degreesOfFreedom ?degreesOfFreedom))
)

/* 
* For a two-sample t-test, degrees of freedom = sample size - 1
*/
(defrule degreesOfFreedom-two-t
    (need-degreesOfFreedom ?)

    (numSamples "two")

    (sampleSize (which ?*FIRST*) (value ?sample1Size))
    (sampleSize (which ?*SECOND*) (value ?sample2Size))

    (sampleStandardDeviation (which ?*FIRST*) (value ?sample1StandardDeviation))
    (sampleStandardDeviation (which ?*SECOND*) (value ?sample2StandardDeviation))

    =>
    ; BOGO: use formula to calculate df
    ; (bind ?degreesOfFreedom (- (min ?sample1Size ?sample2Size) 1))

    ; Calculate degrees of freedom
    (bind ?variance1 (/ (* ?sample1StandardDeviation ?sample1StandardDeviation) ?sample1Size))
    (bind ?variance2 (/ (* ?sample2StandardDeviation ?sample2StandardDeviation) ?sample2Size))

    (bind ?degreesOfFreedom1 (/ 1 (- ?sample1Size 1)))
    (bind ?degreesOfFreedom2 (/ 1 (- ?sample2Size 1)))

    (bind ?numerator (* (+ ?variance1 ?variance2) (+ ?variance1 ?variance2)))
    (bind ?denominator (+ (* ?degreesOfFreedom1 ?variance1 ?variance1) (* ?degreesOfFreedom2 ?variance2 ?variance2)))

    (bind ?degreesOfFreedom (/ ?numerator ?denominator))

    (assert (degreesOfFreedom ?degreesOfFreedom))
)

/*
* Confidence percentage = 100 * (1 - alpha)
*/
(defrule confidencePercentage
    (need-confidencePercentage ?)

    (alpha ?alpha)

    =>

    (bind ?confidencePercentage (* 100 (- 1 ?alpha)))
    (assert (confidencePercentage ?confidencePercentage))
)

; /*
; * For a two-sample test, pooled proportion = (p1n1 + p2n2)/(n1 + n2)
; */
; (defrule pooledProportion
;     (need-pooledProportion ?)

;     (sampleProportion (which ?*FIRST*) (value ?sample1Proportion))
;     (sampleProportion (which ?*SECOND*) (value ?sample2Proportion))

;     (sampleSize (which ?*FIRST*) (value ?sample1Size))
;     (sampleSize (which ?*SECOND*) (value ?sample2Size))

;     =>

;     (bind ?numerator (+ (* ?sample1Proportion ?sample1Size) (* ?sample2Proportion ?sample2Size)))
;     (bind ?denominator (+ ?sample1Size ?sample2Size))

;     (bind ?pooledProportion (/ ?numerator ?denominator))
;     (assert (pooledProportion ?pooledProportion))
; )

; /*
; * For a two-sample proportion interval, calculate the sample proportion difference
; */
; (defrule sampleProportionDifference
;     (need-sampleProportionDifference ?)

;     (sampleProportion (which ?*FIRST*) (value ?sample1Proportion))
;     (sampleProportion (which ?*SECOND*) (value ?sample2Proportion))

;     =>

;     (bind ?sampleProportionDifference (- ?sample1Proportion ?sample2Proportion))
;     (assert (sampleProportionDifference ?sampleProportionDifference))
; )

; /*
; * For a two-sample mean interval, calculate the sample mean difference
; */
; (defrule sampleMeanDifference
;     (need-sampleMeanDifference ?)

;     (sampleMean (which ?*FIRST*) (value ?sample1Mean))
;     (sampleMean (which ?*SECOND*) (value ?sample2Mean))

;     =>

;     (bind ?sampleMeanDifference (- ?sample1Mean ?sample2Mean))
;     (assert (sampleMeanDifference ?sampleMeanDifference))
; )
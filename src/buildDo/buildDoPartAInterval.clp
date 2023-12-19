/*
* ======================================================================
* PART A
* ======================================================================
*/
/*
* Builds doPartA for procedureType = interval, parameterType = proportion, numSamples = one
*/
(defrule build-doPartA-interval-proportion-one
    (need-doPartA ?)

    (procedureType "interval")
    (parameterType "proportion")
    (numSamples "one")

    (alpha ?alpha)
    (sampleProportion (which ?*ONLY*) (value ?sampleProportion))
    (sampleSize (which ?*ONLY*) (value ?sampleSize))

    =>

    (bind ?zStar (invNorm (- 1 (/ ?alpha 2))))
    (bind ?standardError (sqrt (/ (* ?sampleProportion (- 1 ?sampleProportion)) ?sampleSize)))
    (bind ?marginOfError (* ?zStar ?standardError))

    (assert (marginOfError ?marginOfError))

    (bind ?doPartA 
        (str-cat 
            "$$z^*_{\\alpha = "
            (roundTo ?alpha 4)
            "} = "
            (roundTo ?zStar 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{SE} = \\sqrt{\\frac{\\hat{p}(1-\\hat{p})}{n}} = "
            "\\sqrt{\\frac{"
            (roundTo ?sampleProportion 3)
            "(1 - "
            (roundTo ?sampleProportion 3)
            ")}{"
            ?sampleSize
            "}} = "
            (roundTo ?standardError 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{ME} = z^* \\textrm{SE} = "
            (roundTo ?marginOfError 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = interval, parameterType = proportion, numSamples = two
*/
(defrule build-doPartA-interval-proportion-two
    (need-doPartA ?)

    (procedureType "interval")
    (parameterType "proportion")
    (numSamples "two")

    (alpha ?alpha)
    
    (sampleProportion (which ?*FIRST*) (value ?sample1Proportion))
    (sampleSize (which ?*FIRST*) (value ?sample1Size))

    (sampleProportion (which ?*SECOND*) (value ?sample2Proportion))
    (sampleSize (which ?*SECOND*) (value ?sample2Size))

    =>

    (bind ?zStar (invNorm (- 1 (/ ?alpha 2))))

    (bind ?variance1 (/ (* ?sample1Proportion (- 1 ?sample1Proportion)) ?sample1Size))
    (bind ?variance2 (/ (* ?sample2Proportion (- 1 ?sample2Proportion)) ?sample2Size))

    (bind ?standardError (sqrt (+ ?variance1 ?variance2)))
    (bind ?marginOfError (* ?zStar ?standardError))

    (assert (marginOfError ?marginOfError))

    (bind ?doPartA 
        (str-cat 
            "$$z^*_{\\alpha = "
            (roundTo ?alpha 4)
            "} = "
            (roundTo ?zStar 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{SE} = \\sqrt{\\frac{\\hat{p}_1(1-\\hat{p}_1)}{n_1} + \\frac{\\hat{p}_2(1-\\hat{p}_2)}{n_2}} = "
            "\\sqrt{\\frac{"
            (roundTo ?sample1Proportion 3)
            "(1 - "
            (roundTo ?sample1Proportion 3)
            ")}{"
            ?sample1Size
            "} + \\frac{"
            (roundTo ?sample2Proportion 3)
            "(1 - "
            (roundTo ?sample2Proportion 3)
            ")}{"
            ?sample2Size
            "}} = "
            (roundTo ?standardError 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{ME} = z^* \\textrm{SE} = "
            (roundTo ?marginOfError 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = interval, parameterType = mean, testType = z, numSamples = one
*/
(defrule build-doPartA-interval-mean-z-one
    (need-doPartA ?)

    (procedureType "interval")
    (parameterType "mean")
    (testType "z")
    (numSamples "one")

    (alpha ?alpha)
    (sampleSize (which ?*ONLY*) (value ?sampleSize))
    (populationStandardDeviation (which ?*ONLY*) (value ?populationStandardDeviation))

    =>

    (bind ?zStar (invNorm (- 1 (/ ?alpha 2))))
    (bind ?standardError (/ ?populationStandardDeviation (sqrt ?sampleSize)))
    (bind ?marginOfError (* ?zStar ?standardError))

    (assert (marginOfError ?marginOfError))

    (bind ?doPartA 
        (str-cat 
            "$$z^*_{\\alpha = "
            (roundTo ?alpha 4)
            "} = "
            (roundTo ?zStar 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{SE} = \\frac{\\sigma_x}{\\sqrt{n}} = "
            "\\frac{"
            ?populationStandardDeviation
            "}{\\sqrt{"
            ?sampleSize
            "}} ="
            (roundTo ?standardError 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{ME} = z^* \\textrm{SE} = "
            (roundTo ?marginOfError 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = interval, parameterType = mean, testType = z, numSamples = two
*/
(defrule build-doPartA-interval-mean-z-two
    (need-doPartA ?)

    (procedureType "interval")
    (parameterType "mean")
    (testType "z")
    (numSamples "two")

    (alpha ?alpha)

    (sampleSize (which ?*FIRST*) (value ?sample1Size))
    (sampleSize (which ?*SECOND*) (value ?sample2Size))

    (populationStandardDeviation (which ?*FIRST*) (value ?population1StandardDeviation))
    (populationStandardDeviation (which ?*SECOND*) (value ?population2StandardDeviation))

    =>

    (bind ?zStar (invNorm (- 1 (/ ?alpha 2))))

    (bind ?variance1 (/ (* ?population1StandardDeviation ?population1StandardDeviation) ?sample1Size))
    (bind ?variance2 (/ (* ?population2StandardDeviation ?population2StandardDeviation) ?sample2Size))
    
    (bind ?standardError (sqrt (+ ?variance1 ?variance2)))
    (bind ?marginOfError (* ?zStar ?standardError))

    (assert (marginOfError ?marginOfError))

    (bind ?doPartA 
        (str-cat 
            "$$z^*_{\\alpha = "
            (roundTo ?alpha 4)
            "} = "
            (roundTo ?zStar 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{SE} = \\sqrt{ \\frac{\\sigma_1^2}{n_1} + \\frac{\\sigma_2^2}{n_2} } = "
            "\\sqrt{ \\frac{"
            ?population1StandardDeviation
            "^2}{"
            ?sample1Size
            "} + \\frac{"
            ?population2StandardDeviation
            "^2}{"
            ?sample2Size
            "} } = "
            (roundTo ?standardError 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{ME} = z^* \\textrm{SE} = "
            (roundTo ?marginOfError 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = interval, parameterType = mean, testType = t, numSamples = one
*/
(defrule build-doPartA-interval-mean-t-one
    (need-doPartA ?)

    (procedureType "interval")
    (parameterType "mean")
    (testType "t")
    (numSamples "one")

    (alpha ?alpha)
    (sampleSize (which ?*ONLY*) (value ?sampleSize))
    (sampleStandardDeviation (which ?*ONLY*) (value ?sampleStandardDeviation))
    (degreesOfFreedom ?degreesOfFreedom)

    =>

    (bind ?tStar (invT (- 1 (/ ?alpha 2)) ?degreesOfFreedom))
    (bind ?standardError (/ ?sampleStandardDeviation (sqrt ?sampleSize)))
    (bind ?marginOfError (* ?tStar ?standardError))

    (assert (marginOfError ?marginOfError))

    (bind ?doPartA 
        (str-cat 
            "$$t^{*\\mathrm{df} = "
            (roundTo ?degreesOfFreedom 3)
            "}_{\\alpha = "
            (roundTo ?alpha 4)
            "} = "
            (roundTo ?tStar 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{SE} = \\frac{s_x}{\\sqrt{n}} ="
            "\\frac{"
            ?sampleStandardDeviation
            "}{\\sqrt{"
            ?sampleSize
            "}} = "
            (roundTo ?standardError 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{ME} = t^* \\textrm{SE} = "
            (roundTo ?marginOfError 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = interval, parameterType = mean, testType = t, numSamples = two
*/
(defrule build-doPartA-interval-mean-t-two
    (need-doPartA ?)

    (procedureType "interval")
    (parameterType "mean")
    (testType "t")
    (numSamples "two")

    (alpha ?alpha)

    (sampleSize (which ?*FIRST*) (value ?sample1Size))
    (sampleSize (which ?*SECOND*) (value ?sample2Size))

    (sampleStandardDeviation (which ?*FIRST*) (value ?sample1StandardDeviation))
    (sampleStandardDeviation (which ?*SECOND*) (value ?sample2StandardDeviation))

    (degreesOfFreedom ?degreesOfFreedom)

    =>

    (bind ?tStar (invT (- 1 (/ ?alpha 2)) ?degreesOfFreedom))

    (bind ?variance1 (/ (* ?sample1StandardDeviation ?sample1StandardDeviation) ?sample1Size))
    (bind ?variance2 (/ (* ?sample2StandardDeviation ?sample2StandardDeviation) ?sample2Size))
    
    (bind ?standardError (sqrt (+ ?variance1 ?variance2)))
    (bind ?marginOfError (* ?tStar ?standardError))

    (assert (marginOfError ?marginOfError))

    (bind ?doPartA 
        (str-cat 
            "$$t^{*\\mathrm{df} = "
            (roundTo ?degreesOfFreedom 3)
            "}_{\\alpha = "
            (roundTo ?alpha 4)
            "} = "
            (roundTo ?tStar 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{SE} = \\sqrt{ \\frac{s_1^2}{n_1} + \\frac{s_2^2}{n_2} } = "
            "\\sqrt{ \\frac{"
            ?sample1StandardDeviation
            "^2}{"
            ?sample1Size
            "} + \\frac{"
            ?sample2StandardDeviation
            "^2}{"
            ?sample2Size
            "} } = "
            (roundTo ?standardError 3)
            "$$"
            ?*NEWLINE*
            "$$\\textrm{ME} = t^* \\textrm{SE} = "
            (roundTo ?marginOfError 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

; /*
; * Builds doPartA for procedureType = interval, parameterType = mean, testType = t
; */
; (defrule build-doPartA-interval-mean-t
;     (need-doPartA ?)

;     (procedureType "interval")
;     (parameterType "mean")
;     (testType "t")

;     (alpha ?alpha)
;     (sampleSize ?sampleSize)
;     (sampleStandardDeviation ?sampleStandardDeviation)
;     (degreesOfFreedom ?degreesOfFreedom)

;     =>

;     (bind ?tStar (invT (- 1 (/ ?alpha 2)) ?degreesOfFreedom))
;     (bind ?standardError (/ ?sampleStandardDeviation (sqrt ?sampleSize)))
;     (bind ?marginOfError (* ?tStar ?standardError))

;     (assert (marginOfError ?marginOfError))

;     (bind ?doPartA 
;         (str-cat 
;             ?*NEWLINE*
;             "$$t^*_{\\alpha = "
;             (roundTo ?alpha 4)
;             "} = "
;             (roundTo ?tStar 3)
;             "$$"
;             ?*NEWLINE*
;             "$$\\textrm{SE} = \\frac{s_x}{\\sqrt{n}} ="
;             "\\frac{"
;             ?sampleStandardDeviation
;             "}{\\sqrt{"
;             ?sampleSize
;             "}} = "
;             (roundTo ?standardError 3)
;             "$$"
;             ?*NEWLINE*
;             "$$\\textrm{ME} = t^* \\textrm{SE} = "
;             (roundTo ?marginOfError 3)
;             "$$"
;         )
;     )

;     ; ; (printout t crlf ?doPartA)
;     (assert (doPartA ?doPartA))
; )

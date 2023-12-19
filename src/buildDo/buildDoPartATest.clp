/*
* ======================================================================
* PART A
* ======================================================================
*/
/*
* Builds doPartA for procedureType = test, parameterType = proportion, numSamples = one
*/
(defrule build-doPartA-test-proportion-one
    (need-doPartA ?)

    (procedureType "test")
    (parameterType "proportion")
    (numSamples "one")

    (sampleProportion (which ?*ONLY*) (value ?sampleProportion))
    (hypothesisProportion ?hypothesisProportion)
    (sampleSize (which ?*ONLY*) (value ?sampleSize))

    =>

    (bind ?standardError (sqrt (/ (* ?hypothesisProportion (- 1 ?hypothesisProportion)) ?sampleSize)))
    (bind ?zStat (/ (- ?sampleProportion ?hypothesisProportion) ?standardError))

    (assert (zStat ?zStat))

    (bind ?doPartA 
        (str-cat 
            "$$\\textrm{SE} = \\sqrt{\\frac{p_0(1-p_0)}{n}} ="
            "\\sqrt{\\frac{"
            ?hypothesisProportion 
            "(1 - "
            ?hypothesisProportion
            ")}{"
            ?sampleSize
            "}} = "
            (roundTo ?standardError 3)
            "$$"
        ?*NEWLINE*
            "$$z\\textrm{-stat} = \\frac{\\hat{p} - p_0}{\\textrm{SE}}"
            " = \\frac{"
            (roundTo ?sampleProportion 3)
            " - "
            ?hypothesisProportion
            "}{"
            (roundTo ?standardError 3)
            "} = "
            (roundTo ?zStat 3)
            "$$"
        )
    )

    (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = test, parameterType = proportion, numSamples = two
*/
(defrule build-doPartA-test-proportion-two
    (need-doPartA ?)

    (procedureType "test")
    (parameterType "proportion")
    (numSamples "two")

    (hypothesisProportionDifference ?hypothesisProportionDifference)

    (sampleProportion (which ?*FIRST*) (value ?sample1Proportion))
    (sampleProportion (which ?*SECOND*) (value ?sample2Proportion))

    (sampleSize (which ?*FIRST*) (value ?sample1Size))
    (sampleSize (which ?*SECOND*) (value ?sample2Size))

    =>

    ; Calculate the pooled proportion
    (bind ?numerator (+ (* ?sample1Proportion ?sample1Size) (* ?sample2Proportion ?sample2Size)))
    (bind ?denominator (+ ?sample1Size ?sample2Size))
    (bind ?pooledProportion (/ ?numerator ?denominator))

    (bind ?doPartA
        (str-cat
            "$$"
            "p_c"
            "= \\frac{\\hat{p}_1 n_1 + \\hat{p}_2 n_2}{n_1 + n_2}"
            " = "
            "\\frac{(" (roundTo ?sample1Proportion 3) ")(" ?sample1Size ") + (" (roundTo ?sample2Proportion 3) ")(" ?sample2Size ")}{" ?sample1Size " + " ?sample2Size "}"
            " = "
            (roundTo ?pooledProportion 3)
            "$$"
        )
    )

    ; Calculate the standard error
    (bind ?standardError (sqrt (* ?pooledProportion (- 1 ?pooledProportion) (+ (/ 1 ?sample1Size) (/ 1 ?sample2Size)) ) ) )

    (bind ?doPartA
        (str-cat
            ?doPartA
            ?*NEWLINE*
            "$$"
            "\\textrm{SE}"
            " = "
            "\\sqrt{ p_c (1-p_c) \\left( \\frac{1}{n_1} + \\frac{1}{n_2} \\right) }"
            " = "
            "\\sqrt{ " (roundTo ?pooledProportion 3) " (1-" (roundTo ?pooledProportion 3) ") \\left( \\frac{1}{" ?sample1Size "} + \\frac{1}{" ?sample2Size "} \\right) }"
            " = "
            (roundTo ?standardError 3)
            "$$"
        )
    )

    ; Calculate the zStat
    (bind ?zStat (/ (- (- ?sample1Proportion ?sample2Proportion) ?hypothesisProportionDifference) ?standardError))
    (assert (zStat ?zStat))

    (bind ?doPartA 
        (str-cat 
            ?doPartA
            ?*NEWLINE*
            "$$"
            "z\\textrm{stat}"
            " = "
            "\\frac{ ( \\hat{p}_1 - \\hat{p}_2 ) - (p_1 - p_2) }{\\textrm{SE}}"
            " = "
            "\\frac{ ( " (roundTo ?sample1Proportion 3) " - " (roundTo ?sample2Proportion 3) " ) - " ?hypothesisProportionDifference "}{" (roundTo ?standardError 3) "}"
            " = "
            (roundTo ?zStat 3)
            "$$"
        )
    )

    (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = test, parameterType = mean, testType = z, numSamples = one
*/
(defrule build-doPartA-test-mean-z-one
    (need-doPartA ?)

    (procedureType "test")
    (parameterType "mean")
    (testType "z")
    (numSamples "one")

    (populationStandardDeviation (which ?*ONLY*) (value ?populationStandardDeviation))
    (sampleMean (which ?*ONLY*) (value ?sampleMean))
    (hypothesisMean ?hypothesisMean)
    (sampleSize (which ?*ONLY*) (value ?sampleSize))

    =>

    ; Calculate the standard error
    (bind ?standardError (/ ?populationStandardDeviation (sqrt ?sampleSize)))

    (bind ?doPartA 
        (str-cat 
            "$$"
            "\\textrm{SE}" 
            " = "
            "\\frac{\\sigma}{\\sqrt{n}}"
            " = "
            "\\frac{" ?populationStandardDeviation "}{\\sqrt{" ?sampleSize "}}"
            " = "
            (roundTo ?standardError 3)
            "$$"
        )
    )

    ; Calculate the z-stat
    (bind ?zStat (/ (- ?sampleMean ?hypothesisMean) ?standardError))
    (assert (zStat ?zStat))

    (bind ?doPartA
        (str-cat
            ?doPartA
            ?*NEWLINE*
            "$$"
            "z\\textrm{-stat}"
            " = "
            "\\frac{\\bar{x} - \\mu_0}{\\textrm{SE}}"
            " = "
            "\\frac{" ?sampleMean " - " ?hypothesisMean "}{" (roundTo ?standardError 3) "}"
            " = "
            (roundTo ?zStat 3)
            "$$"
        )
    )


    (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = test, parameterType = mean, testType = z, numSamples = two
*/
(defrule build-doPartA-test-mean-z-two
    (need-doPartA ?)

    (procedureType "test")
    (parameterType "mean")
    (testType "z")
    (numSamples "two")

    (populationStandardDeviation (which ?*FIRST*) (value ?population1StandardDeviation))
    (populationStandardDeviation (which ?*SECOND*) (value ?population2StandardDeviation))

    (sampleMean (which ?*FIRST*) (value ?sample1Mean))
    (sampleMean (which ?*SECOND*) (value ?sample2Mean))

    (sampleSize (which ?*FIRST*) (value ?sample1Size))
    (sampleSize (which ?*SECOND*) (value ?sample2Size))

    (hypothesisMeanDifference ?hypothesisMeanDifference)

    =>

    ; Calculate the standard error
    (bind ?variance1 (/ (* ?population1StandardDeviation ?population1StandardDeviation) ?sample1Size))
    (bind ?variance2 (/ (* ?population2StandardDeviation ?population2StandardDeviation) ?sample2Size))
    (bind ?standardError (sqrt (+ ?variance1 ?variance2)))

    (bind ?doPartA 
        (str-cat 
            "$$"
            "\\textrm{SE}" 
            " = "
            "\\sqrt{ \\frac{\\sigma_1 ^2}{n_1} + \\frac{\\sigma_2 ^2}{n_2} }"
            " = "
            "\\sqrt{ \\frac{" ?population1StandardDeviation "^2}{" ?sample1Size "} + \\frac{" ?population2StandardDeviation "^2}{" ?sample2Size "} }"
            " = "
            (roundTo ?standardError 3)
            "$$"
        )
    )

    ; Calculate the z-stat
    (bind ?zStat (/ (- (- ?sample1Mean ?sample2Mean) ?hypothesisMeanDifference) ?standardError))
    (assert (zStat ?zStat))

    (bind ?doPartA
        (str-cat
            ?doPartA
            ?*NEWLINE*
            "$$"
            "z\\textrm{-stat}"
            " = "
            "\\frac{ (\\bar{x}_1 - \\bar{x}_2) - (\\mu_1 - \\mu_2) }{\\textrm{SE}}"
            " = "
            "\\frac{ (" ?sample1Mean " - " ?sample2Mean ") - " ?hypothesisMeanDifference "}{" (roundTo ?standardError 3) "}"
            " = "
            (roundTo ?zStat 3)
            "$$"
        )
    )

    (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = test, parameterType = mean, testType = t, numSamples = one
*/
(defrule build-doPartA-test-mean-t-one
    (need-doPartA ?)

    (procedureType "test")
    (parameterType "mean")
    (testType "t")
    (numSamples "one")

    (sampleStandardDeviation (which ?*ONLY*) (value ?sampleStandardDeviation))
    (sampleMean (which ?*ONLY*) (value ?sampleMean))
    (sampleSize (which ?*ONLY*) (value ?sampleSize))

    (hypothesisMean ?hypothesisMean)

    =>

    ; Calculate the standard error
    (bind ?standardError (/ ?sampleStandardDeviation (sqrt ?sampleSize)))

    (bind ?doPartA 
        (str-cat 
            "$$"
            "\\textrm{SE}" 
            " = "
            "\\frac{s}{\\sqrt{n}}"
            " = "
            "\\frac{" ?sampleStandardDeviation "}{\\sqrt{" ?sampleSize "}}"
            " = "
            (roundTo ?standardError 3)
            "$$"
        )
    )

    ; Calculate the t-stat
    (bind ?tStat (/ (- ?sampleMean ?hypothesisMean) ?standardError))
    (assert (tStat ?tStat))

    (bind ?doPartA
        (str-cat
            ?doPartA
            ?*NEWLINE*
            "$$"
            "t\\textrm{-stat}"
            " = "
            "\\frac{\\bar{x} - \\mu_0}{\\textrm{SE}}"
            " = "
            "\\frac{" ?sampleMean " - " ?hypothesisMean "}{" (roundTo ?standardError 3) "}"
            " = "
            (roundTo ?tStat 3)
            "$$"
        )
    )

    (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)

/*
* Builds doPartA for procedureType = test, parameterType = mean, testType = t, numSamples = two
*/
(defrule build-doPartA-test-mean-t-two
    (need-doPartA ?)

    (procedureType "test")
    (parameterType "mean")
    (testType "t")
    (numSamples "two")

    (sampleStandardDeviation (which ?*FIRST*) (value ?sample1StandardDeviation))
    (sampleStandardDeviation (which ?*SECOND*) (value ?sample2StandardDeviation))

    (sampleMean (which ?*FIRST*) (value ?sample1Mean))
    (sampleMean (which ?*SECOND*) (value ?sample2Mean))

    (sampleSize (which ?*FIRST*) (value ?sample1Size))
    (sampleSize (which ?*SECOND*) (value ?sample2Size))

    (hypothesisMeanDifference ?hypothesisMeanDifference)

    =>

    ; Calculate the standard error
    (bind ?variance1 (/ (* ?sample1StandardDeviation ?sample1StandardDeviation) ?sample1Size))
    (bind ?variance2 (/ (* ?sample2StandardDeviation ?sample2StandardDeviation) ?sample2Size))
    (bind ?standardError (sqrt (+ ?variance1 ?variance2)))

    (bind ?doPartA 
        (str-cat 
            "$$"
            "\\textrm{SE}" 
            " = "
            "\\sqrt{ \\frac{s_1 ^2}{n_1} + \\frac{s_2 ^2}{n_2} }"
            " = "
            "\\sqrt{ \\frac{" ?sample1StandardDeviation "^2}{" ?sample1Size "} + \\frac{" ?sample2StandardDeviation "^2}{" ?sample2Size "} }"
            " = "
            (roundTo ?standardError 3)
            "$$"
        )
    )

    ; Calculate the tstat
    (bind ?tStat (/ (- (- ?sample1Mean ?sample2Mean) ?hypothesisMeanDifference) ?standardError))
    (assert (tStat ?tStat))

    (bind ?doPartA
        (str-cat
            ?doPartA
            ?*NEWLINE*
            "$$"
            "t\\textrm{-stat}"
            " = "
            "\\frac{ (\\bar{x}_1 - \\bar{x}_2) - (\\mu_1 - \\mu_2) }{\\textrm{SE}}"
            " = "
            "\\frac{ (" ?sample1Mean " - " ?sample2Mean ") - " ?hypothesisMeanDifference "}{" (roundTo ?standardError 3) "}"
            " = "
            (roundTo ?tStat 3)
            "$$"
        )
    )

    (printout t crlf ?doPartA)
    (assert (doPartA ?doPartA))
)
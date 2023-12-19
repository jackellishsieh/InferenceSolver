/*
* ======================================================================
* PART B
* ======================================================================
*/
/*
* Builds doPartB for procedureType = interval, parameterType = proportion, numSamples = one
*/
(defrule build-doPartB-interval-proportion-one
    (need-doPartB ?)

    (procedureType "interval")
    (parameterType "proportion")
    (numSamples "one")

    (alpha ?alpha)
    (sampleProportion (which ?*ONLY*) (value ?sampleProportion))
    (marginOfError ?marginOfError)

    =>

    (bind ?lowerBound (- ?sampleProportion ?marginOfError))
    (bind ?upperBound (+ ?sampleProportion ?marginOfError))
    
    (assert (lowerBound ?lowerBound))
    (assert (upperBound ?upperBound))

    (bind ?confidencePercentage (* 100 (- 1 ?alpha)))

    (bind ?doPartB
        (str-cat 
            (roundTo ?confidencePercentage 1)
            "\\% Confidence Interval = "
            "\\(\\hat{p} \\pm \\textrm{ME} = "
            (roundTo ?sampleProportion 3) "\\pm" (roundTo ?marginOfError 3) " = "
            "("
            (roundTo ?lowerBound 3)
            ", "
            (roundTo ?upperBound 3)
            ")\\)."
        )
    )

    (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)

/*
* Builds doPartB for procedureType = interval, parameterType = proportion, numSamples = two
*/
(defrule build-doPartB-interval-proportion-two
    (need-doPartB ?)

    (procedureType "interval")
    (parameterType "proportion")
    (numSamples "two")

    (alpha ?alpha)
    (sampleProportion (which ?*FIRST*) (value ?sample1Proportion))
    (sampleProportion (which ?*SECOND*) (value ?sample2Proportion))

    (marginOfError ?marginOfError)

    =>

    (bind ?sampleProportionDifference (- ?sample1Proportion ?sample2Proportion))
    (bind ?lowerBound (- ?sampleProportionDifference ?marginOfError))
    (bind ?upperBound (+ ?sampleProportionDifference ?marginOfError))
    
    (assert (lowerBound ?lowerBound))
    (assert (upperBound ?upperBound))

    (bind ?confidencePercentage (* 100 (- 1 ?alpha)))

    (bind ?doPartB
        (str-cat 
            (roundTo ?confidencePercentage 1)
            "\\% Confidence Interval = "
            "\\( (\\hat{p}_1 - \\hat{p}_2) \\pm \\textrm{ME} = ("
            (roundTo ?sample1Proportion 3) " - " (roundTo ?sample2Proportion 3)
            ") \\pm " (roundTo ?marginOfError 3) " = ("
            (roundTo ?lowerBound 3)
            ", "
            (roundTo ?upperBound 3)
            ")\\)."
        )
    )

    (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)

/*
* Builds doPartB for procedureType = interval, parameterType = mean, numSamples = one
*/
(defrule build-doPartB-interval-mean-one
    (need-doPartB ?)

    (procedureType "interval")
    (parameterType "mean")
    (numSamples "one")

    (alpha ?alpha)
    (sampleMean (which ?*ONLY*) (value ?sampleMean))
    (marginOfError ?marginOfError)

    =>

    (bind ?lowerBound (- ?sampleMean ?marginOfError))
    (bind ?upperBound (+ ?sampleMean ?marginOfError))
    
    (assert (lowerBound ?lowerBound))
    (assert (upperBound ?upperBound))

    (bind ?confidencePercentage (* 100 (- 1 ?alpha)))

    (bind ?doPartB
        (str-cat 
            (roundTo ?confidencePercentage 1)
            "\\% Confidence Interval = "
            "\\(\\bar{x} \\pm \\textrm{ME} = "
            (roundTo ?sampleMean 3) "\\pm" (roundTo ?marginOfError 3) " = "
            "("
            (roundTo ?lowerBound 3)
            ", "
            (roundTo ?upperBound 3)
            ")\\)."
        )
    )

    (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)

/*
* Builds doPartB for procedureType = interval, parameterType = mean, numSamples = two
*/
(defrule build-doPartB-interval-mean-two
    (need-doPartB ?)

    (procedureType "interval")
    (parameterType "mean")
    (numSamples "two")

    (alpha ?alpha)
    (sampleMean (which ?*FIRST*) (value ?sample1Mean))
    (sampleMean (which ?*SECOND*) (value ?sample2Mean))
    (marginOfError ?marginOfError)

    =>

    (bind ?sampleMeanDifference (- ?sample1Mean ?sample2Mean))
    (bind ?lowerBound (- ?sampleMeanDifference ?marginOfError))
    (bind ?upperBound (+ ?sampleMeanDifference ?marginOfError))
    
    (assert (lowerBound ?lowerBound))
    (assert (upperBound ?upperBound))

    (bind ?confidencePercentage (* 100 (- 1 ?alpha)))

    (bind ?doPartB
        (str-cat 
            (roundTo ?confidencePercentage 1)
            "\\% Confidence Interval = "
            "\\( (\\bar{x}_1 - \\bar{x}_2) \\pm \\textrm{ME} = ("
            (roundTo ?sample1Mean 3) " - " (roundTo ?sample2Mean 3)
            ") \\pm " (roundTo ?marginOfError 3) " = ("
            (roundTo ?lowerBound 3)
            ", "
            (roundTo ?upperBound 3)
            ")\\)."
        )
    )

    (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)
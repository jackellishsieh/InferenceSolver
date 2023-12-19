/*
* ======================================================================
* PART A
* ======================================================================
*/
/*
* Builds concludePartA for procedureType = interval, parameterType = proportion, numSamples = one
*/
(defrule build-concludePartA-interval-proportion-one
    (need-concludePartA ?)

    (procedureType "interval")
    (parameterType "proportion")
    (numSamples "one")

    (confidencePercentage ?confidencePercentage)
    (parameterDescription ?parameterDescription)  

    (populationDescription (which ?*ONLY*) (value ?populationDescription)) 

    (lowerBound ?lowerBound)
    (upperBound ?upperBound)

    =>

    (bind ?concludePartA
        (str-cat
            "We are "
            (roundTo ?confidencePercentage 1)
            "\\% confident that the interval ("
            (roundTo ?lowerBound 3)
            ", "
            (roundTo ?upperBound 3)
            ") captures the true proportion of "
            ?parameterDescription
            " among "
            ?populationDescription
            "."
        )
    )

    (printout t crlf ?concludePartA)
    (assert (concludePartA ?concludePartA))
)

/*
* Builds concludePartA for procedureType = interval, parameterType = proportion, numSamples = two
*/
(defrule build-concludePartA-interval-proportion-two
    (need-concludePartA ?)

    (procedureType "interval")
    (parameterType "proportion")
    (numSamples "two")

    (confidencePercentage ?confidencePercentage)
    (parameterDescription ?parameterDescription)  

    (populationDescription (which ?*FIRST*) (value ?population1Description)) 
    (populationDescription (which ?*SECOND*) (value ?population2Description)) 

    (lowerBound ?lowerBound)
    (upperBound ?upperBound)

    =>

    (bind ?concludePartA
        (str-cat
            "We are "
            (roundTo ?confidencePercentage 1)
            "\\% confident that the interval ("
            (roundTo ?lowerBound 3)
            ", "
            (roundTo ?upperBound 3)
            ") captures the difference in the true proportion of "
            ?parameterDescription
            " among "
            ?population1Description
            " and the true proportion of "
            ?parameterDescription
            " among "
            ?population2Description
            "."
        )
    )

    (printout t crlf ?concludePartA)
    (assert (concludePartA ?concludePartA))
)

/*
* Builds concludePartA for procedureType = interval, parameterType = mean, numSamples = one
*/
(defrule build-concludePartA-interval-mean-one
    (need-concludePartA ?)
    
    (procedureType "interval")
    (parameterType "mean")
    (numSamples "one")

    (confidencePercentage ?confidencePercentage)
    (parameterDescription ?parameterDescription)
    
    (populationDescription (which ?which) (value ?populationDescription))

    (lowerBound ?lowerBound)
    (upperBound ?upperBound)

    =>

    (bind ?concludePartA
        (str-cat
            "We are "
            (roundTo ?confidencePercentage 1)
            "\\% confident that the interval ("
            (roundTo ?lowerBound 3)
            ", "
            (roundTo ?upperBound 3)
            ") captures the true mean "
            ?parameterDescription
            " of "
            ?populationDescription
            "."
        )
    )

    (printout t crlf ?concludePartA)
    (assert (concludePartA ?concludePartA))
)

/*
* Builds concludePartA for procedureType = interval, parameterType = mean, numSamples = two
*/
(defrule build-concludePartA-interval-mean-two
    (need-concludePartA ?)

    (procedureType "interval")
    (parameterType "mean")
    (numSamples "two")

    (confidencePercentage ?confidencePercentage)
    (parameterDescription ?parameterDescription)  

    (populationDescription (which ?*FIRST*) (value ?population1Description)) 
    (populationDescription (which ?*SECOND*) (value ?population2Description)) 

    (lowerBound ?lowerBound)
    (upperBound ?upperBound)

    =>

    (bind ?concludePartA
        (str-cat
            "We are "
            (roundTo ?confidencePercentage 1)
            "\\% confident that the interval ("
            (roundTo ?lowerBound 3)
            ", "
            (roundTo ?upperBound 3)
            ") captures the difference in the true mean "
            ?parameterDescription
            " of "
            ?population1Description
            " and the true mean of "
            ?parameterDescription
            " of "
            ?population2Description
            "."
        )
    )

    (printout t crlf ?concludePartA)
    (assert (concludePartA ?concludePartA))
)

/*
* Builds concludePartA for procedureType = test, significance = TRUE
*/
(defrule build-concludePartA-test-significant
    (need-concludePartA ?)

    (procedureType "test")
    (significant TRUE)

    (pValue ?pValue)
    (alpha ?alpha)
    =>

    (bind ?concludePartA
        (str-cat
            "Since \\(p\\)-value = \\("
            (roundTo ?pValue 3)
            " \\leq "
            ?alpha
            " = \\alpha\\), we reject \\(H_0\\) at significance level \\(\\alpha = "
            ?alpha
            "\\)."
        )
    )

    (printout t crlf ?concludePartA)
    (assert (concludePartA ?concludePartA))
)

/*
* Builds concludePartA for procedureType = test, significance = FALSE
*/
(defrule build-concludePartA-test-notSignificant
    (need-concludePartA ?)

    (procedureType "test")
    (significant FALSE)

    (pValue ?pValue)
    (alpha ?alpha)
    =>

    (bind ?concludePartA
        (str-cat
            "Since \\(p\\)-value = \\("
            (roundTo ?pValue 3)
            " > "
            ?alpha
            " = \\alpha\\), we fail to reject \\(H_0\\) at significance level \\(\\alpha = "
            ?alpha
            "\\)."
        )
    )

    (printout t crlf ?concludePartA)
    (assert (concludePartA ?concludePartA))
)

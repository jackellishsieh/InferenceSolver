/*
* ======================================================================
* PART A
* ======================================================================
*/
/*
* Builds statePartA if numSamples = one, parameterType = proportion
*/
(defrule build-statePartA-one-proportion
    (need-statePartA ?)

    (numSamples "one")
    (parameterType "proportion")

    (parameterDescription ?parameterDescription)

    (populationDescription (which ?*ONLY*) (value ?populationDescription))
    =>
    (bind ?statePartA
        (str-cat
            "We are interested in the true proportion of "
            ?parameterDescription
            " (\\(p\\)) among "
            ?populationDescription
            "."
        )
    )

    ; (printout t crlf ?statePartA)
    (assert (statePartA ?statePartA))
)

/*
* Builds statePartA if numSamples = two, parameterType = proportion
*/
(defrule build-statePartA-two-proportion
    (need-statePartA ?)

    (numSamples "two")
    (parameterType "proportion")

    (parameterDescription ?parameterDescription)
    
    (populationDescription (which ?*FIRST*) (value ?population1Description))
    (populationDescription (which ?*SECOND*) (value ?population2Description))

    =>
    (bind ?statePartA
        (str-cat
            "We are interested in the difference in the true proportion of "
            ?parameterDescription
            " among "
            ?population1Description
            " (\\(p_1\\)) and the true proportion of "
            ?parameterDescription
            " among "
            ?population2Description
            " (\\(p_2\\))."
        )
    )

    ; (printout t crlf ?statePartA)
    (assert (statePartA ?statePartA))
)

/*
* Builds statePartA if numSamples = one, parameterType = mean
*/
(defrule build-statePartA-one-mean
    (need-statePartA ?)

    (numSamples "one")
    (parameterType "mean")

    (parameterDescription ?parameterDescription)

    (populationDescription (which ?*ONLY*) (value ?populationDescription))
    =>
    (bind ?statePartA
        (str-cat
            "We are interested in the true mean "
            ?parameterDescription
            " (\\(\\mu\\)) of "
            ?populationDescription
            "."
        )
    )

    ; (printout t crlf ?statePartA)
    (assert (statePartA ?statePartA))
)

/*
* Builds statePartA if numSamples = two, parameterType = mean
*/
(defrule build-statePartA-two-mean
    (need-statePartA ?)

    (numSamples "two")
    (parameterType "mean")

    (parameterDescription ?parameterDescription)
    
    (populationDescription (which ?*FIRST*) (value ?population1Description))
    (populationDescription (which ?*SECOND*) (value ?population2Description))

    =>
    (bind ?statePartA
        (str-cat
            "We are interested in the difference in the true mean "
            ?parameterDescription
            " of "
            ?population1Description
            " (\\(\\mu_1\\)) and the true mean "
            ?parameterDescription
            " of "
            ?population2Description
            " (\\(\\mu_2\\))."
        )
    )

    ; (printout t crlf ?statePartA)
    (assert (statePartA ?statePartA))
)
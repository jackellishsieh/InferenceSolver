/*
* ======================================================================
* PART B
* ======================================================================
*/
/*
* Builds statePartB if testType = interval
*/
(defrule build-statePartB-interval
    (need-statePartB ?)

    (procedureType "interval")
    =>
    (assert (statePartB ""))
)

/*
* Builds statePartB if numSamples = one, testType = test, parameterType = proportion
*/
(defrule build-statePartB-one-test-proportion
    (need-statePartB ?)

    (numSamples "one")
    (procedureType "test")
    (parameterType "proportion")

    (comparison ?comparison)
    (hypothesisProportion ?hypothesisProportion)
    
    =>

    (bind ?statePartB
        (str-cat
            ?*TAB*
            "$$H_0: p = "
            ?hypothesisProportion
            "$$"
            ?*NEWLINE*
            ?*TAB*
            "$$H_a: p "
            ?comparison
            " "
            ?hypothesisProportion
            "$$ "
        )
    )

    ; (printout t crlf ?statePartB)
    (assert (statePartB ?statePartB))
)

/*
* Builds statePartB if numSamples = two, testType = test, parameterType = proportion
*/
(defrule build-statePartB-two-test-proportion
    (need-statePartB ?)

    (numSamples "two")
    (procedureType "test")
    (parameterType "proportion")

    (comparison ?comparison)
    (hypothesisProportionDifference ?hypothesisProportionDifference)
    
    =>

    (bind ?statePartB
        (str-cat
            ?*TAB*
            "$$H_0: p_1 - p_2 = "
            ?hypothesisProportionDifference
            "$$"
            ?*NEWLINE*
            ?*TAB*
            "$$H_a: p_1 - p_2 "
            ?comparison
            " "
            ?hypothesisProportionDifference
            "$$ "
        )
    )

    ; (printout t crlf ?statePartB)
    (assert (statePartB ?statePartB))
)

/*
* Builds statePartB if numSamples = one, testType = test, parameterType = mean
*/
(defrule build-statePartB-one-test-mean
    (need-statePartB ?)

    (numSamples "one")
    (procedureType "test")
    (parameterType "mean")

    (comparison ?comparison)
    (hypothesisMean ?hypothesisMean)
    
    =>

    (bind ?statePartB
        (str-cat
            ?*TAB*
            "$$H_0: \\mu = "
            ?hypothesisMean
            "$$"
            ?*NEWLINE*
            ?*TAB*
            "$$H_a: \\mu "
            ?comparison
            " "
            ?hypothesisMean
            "$$"
        )
    )

    ; (printout t crlf ?statePartB)
    (assert (statePartB ?statePartB))
)

/*
* Builds statePartB if numSamples = two, testType = test, parameterType = mean
*/
(defrule build-statePartB-two-test-mean
    (need-statePartB ?)

    (numSamples "two")
    (procedureType "test")
    (parameterType "mean")

    (comparison ?comparison)
    (hypothesisMeanDifference ?hypothesisMeanDifference)
    
    =>

    (bind ?statePartB
        (str-cat
            ?*TAB*
            "$$H_0: \\mu_1 - \\mu_2 = "
            ?hypothesisMeanDifference
            "$$"
            ?*NEWLINE*
            ?*TAB*
            "$$H_a: \\mu_1 - \\mu_2 "
            ?comparison
            " "
            ?hypothesisMeanDifference
            "$$"
        )
    )

    ; (printout t crlf ?statePartB)
    (assert (statePartB ?statePartB))
)
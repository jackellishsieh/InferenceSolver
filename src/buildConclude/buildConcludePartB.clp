/*
* ======================================================================
* PART B
* ======================================================================
*/
/*
* No concludePartB for an interval
*/
(defrule build-concludePartB-interval
    (need-concludePartB ?)

    (procedureType "interval")
    =>
    (assert (concludePartB ""))
)

/*
* Builds concludePartB for procedureType = test, parameterType = proportion, numSamples = one
* Cheating a little bit with an IF statement on the significance and comparison,
* but this is very minor and easily replaceable
*/
(defrule build-concludePartB-test-proportion-one
    (need-concludePartB ?)

    (procedureType "test")
    (parameterType "proportion")
    (numSamples "one")
    
    (significant ?significant)
    (parameterDescription ?parameterDescription)

    (populationDescription (which ?*ONLY*) (value ?populationDescription))
     
    (comparison ?comparison)
    (hypothesisProportion ?hypothesisProportion)

    =>

    (bind ?significancePhrase "")
    (if (not ?significant) then
        (bind ?significancePhrase "do not ")
    )

    (bind ?comparisonPhrase "differs from")
    (if (eq ?comparison ">") then
        (bind ?comparisonPhrase "is greater than")
    )
    (if (eq ?comparison "<") then
        (bind ?comparisonPhrase "is less than")
    )

    (bind ?concludePartB
        (str-cat
            "We therefore "
            ?significancePhrase
            "have convincing evidence that the true proportion of "
            ?parameterDescription
            " among "
            ?populationDescription
            " "
            ?comparisonPhrase            
            " "
            ?hypothesisProportion
            "."
        )
    )

    (printout t crlf ?concludePartB)
    (assert (concludePartB ?concludePartB))
)

/*
* Builds concludePartB for procedureType = test, parameterType = proportion, numSamples = two
* Cheating a little bit with an IF statement on the significance and comparison,
* but this is very minor and easily replaceable
*/
(defrule build-concludePartB-test-proportion-two
    (need-concludePartB ?)

    (procedureType "test")
    (parameterType "proportion")
    (numSamples "two")
    
    (significant ?significant)
    (parameterDescription ?parameterDescription)

    (populationDescription (which ?*FIRST*) (value ?population1Description))
    (populationDescription (which ?*SECOND*) (value ?population2Description))

    (comparison ?comparison)
    
    ; BOGO!
    ; (hypothesisProportionDifference ?hypothesisProportionDifference)

    =>

    (bind ?significancePhrase "")
    (if (not ?significant) then
        (bind ?significancePhrase "do not ")
    )

    (bind ?comparisonPhrase "differs from")
    (if (eq ?comparison ">") then
        (bind ?comparisonPhrase "is greater than")
    )
    (if (eq ?comparison "<") then
        (bind ?comparisonPhrase "is less than")
    )

    (bind ?concludePartB
        (str-cat
            "We therefore "
            ?significancePhrase
            "have convincing evidence that the true proportion of "
            ?parameterDescription
            " among "
            ?population1Description
            " "
            ?comparisonPhrase            
            " the true proportion of "
            ?parameterDescription
            " among "
            ?population2Description
            "."
        )
    )

    (printout t crlf ?concludePartB)
    (assert (concludePartB ?concludePartB))
)

/*
* Builds concludePartB for procedureType = test, parameterType = mean, numSamples = one
* Cheating a little bit with an IF statement on the significance and comparison,
* but this is very minor and easily replaceable
*/
(defrule build-concludePartB-test-mean-one
    (need-concludePartB ?)

    (procedureType "test")
    (parameterType "mean")
    (numSamples "one")
    
    (significant ?significant)
    (parameterDescription ?parameterDescription)

    (populationDescription (which ?*ONLY*) (value ?populationDescription))
    
    (comparison ?comparison)
    (hypothesisMean ?hypothesisMean)

    =>

    (bind ?significancePhrase "")
    (if (not ?significant) then
        (bind ?significancePhrase "do not ")
    )

    (bind ?comparisonPhrase "differs from")
    (if (eq ?comparison ">") then
        (bind ?comparisonPhrase "is greater than")
    )
    (if (eq ?comparison "<") then
        (bind ?comparisonPhrase "is less than")
    )

    (bind ?concludePartB
        (str-cat
            "We therefore "
            ?significancePhrase
            "have convincing evidence that the true mean "
            ?parameterDescription
            " of "
            ?populationDescription
            " "
            ?comparisonPhrase            
            " "
            ?hypothesisMean
            "."
        )
    )

    (printout t crlf ?concludePartB)
    (assert (concludePartB ?concludePartB))
)

/*
* Builds concludePartB for procedureType = test, parameterType = mean, numSamples = two
* Cheating a little bit with an IF statement on the significance and comparison,
* but this is very minor and easily replaceable
*/
(defrule build-concludePartB-test-mean-two
    (need-concludePartB ?)

    (procedureType "test")
    (parameterType "mean")
    (numSamples "two")
    
    (significant ?significant)
    (parameterDescription ?parameterDescription)

    (populationDescription (which ?*FIRST*) (value ?population1Description))
    (populationDescription (which ?*SECOND*) (value ?population2Description))

    (comparison ?comparison)
    
    ; BOGO!
    ; (hypothesisMeanDifference ?hypothesisMeanDifference)

    =>

    (bind ?significancePhrase "")
    (if (not ?significant) then
        (bind ?significancePhrase "do not ")
    )

    (bind ?comparisonPhrase "differs from")
    (if (eq ?comparison ">") then
        (bind ?comparisonPhrase "is greater than")
    )
    (if (eq ?comparison "<") then
        (bind ?comparisonPhrase "is less than")
    )

    (bind ?concludePartB
        (str-cat
            "We therefore "
            ?significancePhrase
            "have convincing evidence that the true mean "
            ?parameterDescription
            " of "
            ?population1Description
            " "
            ?comparisonPhrase            
            " the true mean "
            ?parameterDescription
            " of "
            ?population2Description
            "."
        )
    )

    (printout t crlf ?concludePartB)
    (assert (concludePartB ?concludePartB))
)
/*
* ======================================================================
* PART D
* ======================================================================
*/
(deftemplate planPartDComponent (slot value) (slot which))
(do-backward-chaining planPartDComponent)

/*
* Builds planPartD for one sample
*/
(defrule build-planPartD-one
    (need-planPartD ?)

    (numSamples "one")

    (planPartDComponent (which ?*ONLY*) (value ?planPartDComponent))

    =>

    (bind ?planPartD
        (str-cat
            ?planPartDComponent
        )
    )

    ; (printout t crlf ?planPartD)
    (assert (planPartD ?planPartD))
)

/*
* Builds planPartD for two samples
*/
(defrule build-planPartD-two
    (need-planPartD ?)

    (numSamples "two")

    (planPartDComponent (which ?*FIRST*) (value ?planPartDComponent1))
    (planPartDComponent (which ?*SECOND*) (value ?planPartDComponent2))
    =>

    (bind ?planPartD
        (str-cat
            ?planPartDComponent1
                ?*NEWLINE*
            ?planPartDComponent2
        )
    )

    ; (printout t crlf ?planPartD)
    (assert (planPartD ?planPartD))
)


/*
* ======================================================================
* SAMPLE MEAN
* ======================================================================
*/
/*
* Builds component for planPartD for parameterType = mean and CLT = TRUE
* Must use if: can't perform test on sampleSize with backward-chaining
*/
(defrule build-planPartDComponent-mean-CLT
    (need-planPartDComponent (which ?which) (value ?))

    (parameterType "mean")
    (CLT (which ?which) (value TRUE))

    (sampleSize (which ?which) (value ?sampleSize))

    =>

    ; n/x, n/x1, or n/x2
    (bind ?whichPhrase "")
    (if (eq ?which ?*FIRST*) then (bind ?whichPhrase "_1"))
    (if (eq ?which ?*SECOND*) then (bind ?whichPhrase "_2"))

    (bind ?planPartDComponent
        (str-cat
            "Since \\(n"
            ?whichPhrase 
            " = "
            ?sampleSize
            " \\geq 30\\), by CLT, \\(\\bar{x}"
            ?whichPhrase
            "\\) is approximately normally distributed." 
        )
    )

    ; (printout t crlf ?planPartDComponent)
    (assert (planPartDComponent (which ?which) (value ?planPartDComponent)))
)

/*
* Builds a component for planPartD for parameterType = mean, CLT = FALSE, and populationNormality = normal
*/
(defrule build-planPartDComponent-mean-notCLT-normal
    (need-planPartDComponent (which ?which) (value ?))

    (parameterType "mean")
    (CLT (which ?which) (value FALSE))
    (populationNormality (which ?which) (value "normal"))

    =>

    ; n/x, n/x1, or n/x2
    (bind ?whichPhrase "")
    (if (eq ?which ?*FIRST*) then (bind ?whichPhrase "_1"))
    (if (eq ?which ?*SECOND*) then (bind ?whichPhrase "_2"))

    (bind ?planPartDComponent
        (str-cat
            "Since \\(x"
            ?whichPhrase
            "\\) is normally distributed, \\(\\bar{x}"
            ?whichPhrase
            "\\) is normally distributed." 
        )
    )

    ; (printout t crlf ?planPartDComponent)
    (assert (planPartDComponent (which ?which) (value ?planPartDComponent)))
)

/*
* Builds a component for planPartD for parameterType = mean, CLT = FALSE, populationNormality = not normal, 
* testType = t, sampleBalance = balance
*/
(defrule build-planPartDComponent-mean-notCLT-notNormal-t-sampleBalance
    (need-planPartDComponent (which ?which) (value ?))

    (parameterType "mean")
    (CLT (which ?which) (value FALSE))
    (populationNormality (which ?which) (value "not normal"))
    (testType "t")
    (sampleBalance (which ?which) (value "balanced"))

    (populationDescription (which ?which) (value ?populationDescription))
    =>

    ; n/x, n/x1, or n/x2
    (bind ?whichPhrase "")
    (if (eq ?which ?*FIRST*) then (bind ?whichPhrase "_1"))
    (if (eq ?which ?*SECOND*) then (bind ?whichPhrase "_2"))

    (bind ?planPartDComponent
        (str-cat
            "While \\(n"
            ?whichPhrase
            "<30\\), since the histogram of the sample distribution for the "
            ?populationDescription
            " shows neither strong skew nor outliers, \\(\\bar{x}"
            ?whichPhrase
            "\\) can be assumed to be approximately normally distributed." 
        )
    )

    ; (printout t crlf ?planPartDComponent)
    (assert (planPartDComponent (which ?which) (value ?planPartDComponent)))
)



/*
* ======================================================================
* PROPORTION
* ======================================================================
*/
/*
* Builds a component for planPartD for parameterType = proportion, procedureType = interval,
* largeCounts = TRUE
* OR two-sample proportion test
*
* Works for either one sample or two for interval
* Works also for a two-sample proportion-test
*/
(defrule build-planPartDComponent-proportion-interval-or-two-largeCounts
    (need-planPartDComponent (which ?which) (value ?))

    (parameterType "proportion")
    (or 
        (procedureType "interval")
        (and
            (procedureType "test")
            (numSamples "two")
        )
    )

    (largeCounts (which ?which) (value TRUE))

    (sampleSize (which ?which) (value ?sampleSize))
    (sampleProportion (which ?which) (value ?sampleProportion))

    =>

    (bind ?sampleCount (* ?sampleSize ?sampleProportion))

    ; n/x, n/x1, or n/x2
    (bind ?whichPhrase "")
    (if (eq ?which ?*FIRST*) then (bind ?whichPhrase "_1"))
    (if (eq ?which ?*SECOND*) then (bind ?whichPhrase "_2"))

    (bind ?planPartDComponent
        (str-cat
            "Since \\(n"
            ?whichPhrase
            "\\hat{p}"
            ?whichPhrase
            " = "
            ?sampleSize
            "("
            ?sampleProportion
            ") = "
            (roundTo ?sampleCount 3)
            ", n"
            ?whichPhrase
            "(1-\\hat{p}"
            ?whichPhrase
            ") = " 
            ?sampleSize
            "(1- "
            ?sampleProportion
            ") = " 
            (roundTo (- ?sampleSize ?sampleCount) 3)
            "\\geq 10 \\), by the Large Counts Rule, \\(\\hat{p}"
            ?whichPhrase
            "\\) is approximately normally distributed."
        )
    )

    ; (printout t crlf ?planPartDComponent)
    (assert (planPartDComponent (which ?which) (value ?planPartDComponent)))
)

/*
* Builds a component for planPartD for parameterType = proportion, procedureType = test, largeCounts = TRUE, numSamples = one
*/
(defrule build-planPartDComponent-proportion-test-largeCounts-one
    (need-planPartDComponent (which ?which) (value ?))

    (parameterType "proportion")
    (procedureType "test")
    (largeCounts (which ?which) (value TRUE))
    (numSamples "one")

    (sampleSize (which ?which) (value ?sampleSize))
    (hypothesisProportion ?hypothesisProportion)

    =>

    (bind ?sampleCount (* ?sampleSize ?hypothesisProportion))

    (bind ?planPartDComponent
        (str-cat
            "Since \\(np_0 = "
            ?sampleSize
            "("
            ?hypothesisProportion
            ") = "
            (roundTo ?sampleCount 3)
            ", n(1-p_0) = " 
            ?sampleSize
            "(1- "
            ?hypothesisProportion
            ") = " 
            (roundTo (- ?sampleSize ?sampleCount) 3)
            "\\geq 10 \\), by the Large Counts Rule, \\(\\hat{p}\\) is approximately normally distributed."
        )
    )

    ; (printout t crlf ?planPartDComponent)
    (assert (planPartDComponent (which ?which) (value ?planPartDComponent)))
)
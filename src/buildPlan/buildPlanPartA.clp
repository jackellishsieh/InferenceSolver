/*
* ======================================================================
* PART A
* ======================================================================
*/
/*
* Builds planPartA for procedureType = interval, testType = z
* Technically cheating a bit with the IF statement for numSamples, but this is one phrase
*/
(defrule build-planPartA-interval-z
    (need-planPartA ?)

    (procedureType "interval")
    (testType "z")

    (numSamples ?numSamples)
    (parameterType ?parameterType)  
    (alpha ?alpha)

    =>

    (bind ?numSamplesPhrase "")
    (if (eq ?numSamples "two") then
        (bind ?numSamplesPhrase " difference")
    )

    (bind ?planPartA 
        (str-cat 
            "We construct a "
            ?numSamples
            "-sample \\(z\\)-interval for a population "
            ?parameterType
            ?numSamplesPhrase
            " at confidence level \\(C = "
            (- 1 ?alpha)
            "\\)."
        )
    )

    ; (printout t crlf ?planPartA)
    (assert (planPartA ?planPartA))
)

/*
* Builds planPartA for procedureType = interval, testType = t, numSamples = one
*/
(defrule build-planPartA-interval-t-one
    (need-planPartA ?)

    (procedureType "interval")
    (testType "t")
    (numSamples "one")

    (parameterType ?parameterType)  
    (alpha ?alpha)
    (degreesOfFreedom ?degreesOfFreedom)

    =>

    (bind ?planPartA 
        (str-cat 
            "We construct a one-sample \\(t\\)-interval for a population "
            ?parameterType
            " at confidence level \\(C = "
            (- 1 ?alpha)
            "\\) with \\(\\textrm{df} = n-1 = "
            ?degreesOfFreedom
            "\\)."
        )
    )

    ; (printout t crlf ?planPartA)
    (assert (planPartA ?planPartA))
)

/*
* Builds planPartA for procedureType = interval, testType = t, numSamples = two
*/
(defrule build-planPartA-interval-t-two
    (need-planPartA ?)

    (procedureType "interval")
    (testType "t")
    (numSamples "two")

    (parameterType ?parameterType)  
    (alpha ?alpha)
    (degreesOfFreedom ?degreesOfFreedom)

    (sampleStandardDeviation (which ?*FIRST*) (value ?sample1StandardDeviation))
    (sampleStandardDeviation (which ?*SECOND*) (value ?sample2StandardDeviation))

    (sampleSize (which ?*FIRST*) (value ?sample1Size))
    (sampleSize (which ?*SECOND*) (value ?sample2Size))

    =>

    (bind ?planPartA 
        (str-cat 
            "We construct a two-sample \\(t\\)-interval for a population "
            ?parameterType
            " difference at confidence level \\(C = "
            (- 1 ?alpha)
            "\\) with \\(\\textrm{df} = \\frac{"
            "\\left( \\mathrm{Var}[\\bar{x}_1] + \\mathrm{Var}[\\bar{x}_2] \\right)^2}"
            "{ \\mathrm{df}_1 \\mathrm{Var}[\\bar{x}_1]^2 + \\mathrm{df}_2 \\mathrm{Var}[\\bar{x}_2]^2}"
            " = "
            (roundTo ?degreesOfFreedom 3)
            "\\)."
        )
    )

    ; (printout t crlf ?planPartA)
    (assert (planPartA ?planPartA))
)

/*
* Builds planPartA for procedureType = test, testType = z
* Cheats a bit with numSamples
*/
(defrule build-planPartA-test-z
    (need-planPartA ?)

    (procedureType "test")
    (testType "z")

    (numSamples ?numSamples)
    (parameterType ?parameterType)  
    (alpha ?alpha)

    =>

    (bind ?numSamplesPhrase "")
    (if (eq ?numSamples "two") then
        (bind ?numSamplesPhrase " difference")
    )

    (bind ?planPartA 
        (str-cat 
            "We use a "
            ?numSamples
            "-sample \\(z\\)-test for a population "
            ?parameterType
            ?numSamplesPhrase
            " at significance level \\(\\alpha = "
            ?alpha
            "\\)."
        )
    )

    ; (printout t crlf ?planPartA)
    (assert (planPartA ?planPartA))
)

/*
* Builds planPartA for procedureType = test, testType = t
* Cheats a bit with numSamples
*/
(defrule build-planPartA-test-t
    (need-planPartA ?)

    (procedureType "test")
    (testType "t")

    (numSamples ?numSamples)
    (parameterType ?parameterType)  
    (alpha ?alpha)
    (degreesOfFreedom ?degreesOfFreedom)

    =>

    (bind ?planPartA 
        (str-cat 
            "We use a "
            ?numSamples
            "-sample \\(t\\)-test for a population "
            ?parameterType
            " difference at confidence level \\(C = "
            (- 1 ?alpha)
            "\\) with \\(\\textrm{df} = \\frac{"
            "\\left( \\mathrm{Var}[\\bar{x}_1] + \\mathrm{Var}[\\bar{x}_2] \\right)^2}"
            "{ \\mathrm{df}_1 \\mathrm{Var}[\\bar{x}_1]^2 + \\mathrm{df}_2 \\mathrm{Var}[\\bar{x}_2]^2}"
            " = "
            (roundTo ?degreesOfFreedom 3)
            "\\)."
        )
    )

    ; (printout t crlf ?planPartA)
    (assert (planPartA ?planPartA))
)
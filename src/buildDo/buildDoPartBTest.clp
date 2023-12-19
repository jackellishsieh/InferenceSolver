/*
* ======================================================================
* PART B
* ======================================================================
*/
/*
* Builds doPartB for procedureType = test, testType = z, comparison = >
*/
(defrule build-doPartB-test-z-greater
    (need-doPartB ?)

    (procedureType "test")
    (testType "z")
    (comparison ">")

    (zStat ?zStat)

    =>

    (bind ?pValue (- 1 (normalCDF ?zStat)))

    (assert (pValue ?pValue))

    (bind ?doPartB
        (str-cat 
            "$$p\\textrm{-value} = P(z > "
            (roundTo ?zStat 3)
            ") = 1 - P(z < "
            (roundTo ?zStat 3)
            ") = "
            (roundTo ?pValue 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)

/*
* Builds doPartB for procedureType = test, testType = z, comparison = <
*/
(defrule build-doPartB-test-proportion-less
    (need-doPartB ?)

    (procedureType "test")
    (testType "z")
    (comparison "<")

    (zStat ?zStat)

    =>

    (bind ?pValue (normalCDF ?zStat))

    (assert (pValue ?pValue))

    (bind ?doPartB
        (str-cat 
            "$$p\\textrm{-value} = P(z < "
            (roundTo ?zStat 3)
            ") ="
            (roundTo ?pValue 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)

/*
* Builds doPartB for procedureType = test, testType = z, comparison = \\neq
*/
(defrule build-doPartB-test-proportion-notEqual
    (need-doPartB ?)

    (procedureType "test")
    (testType "z")
    (comparison "\\neq")

    (zStat ?zStat)

    =>

    (bind ?pValue (* 2 (normalCDF (- 0 (abs ?zStat)))))

    (assert (pValue ?pValue))

    (bind ?doPartB
        (str-cat 
            "$$p\\textrm{-value} = P(|z| > |"
            (roundTo ?zStat 3)
            "|) = 2P(z < -"
            (abs (roundTo ?zStat 3))
            ") = "
            (roundTo ?pValue 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)

/*
* Builds doPartB for procedureType = test, parameterType = mean, testType = t, comparison = >
*/
(defrule build-doPartB-test-t-greater
    (need-doPartB ?)

    (procedureType "test")
    (testType "t")
    (comparison ">")

    (tStat ?tStat)
    (degreesOfFreedom ?degreesOfFreedom)

    =>

    (bind ?pValue (- 1 (tCDF ?tStat ?degreesOfFreedom)))

    (assert (pValue ?pValue))

    (bind ?doPartB
        (str-cat 
            "$$p\\textrm{-value} = P(t > "
            (roundTo ?tStat 3)
            ") = 1 - P(t < "
            (roundTo ?tStat 3)
            ") = "
            (roundTo ?pValue 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)

/*
* Builds doPartB for procedureType = test, testType = t, comparison = <
*/
(defrule build-doPartB-test-t-less
    (need-doPartB ?)

    (procedureType "test")
    (testType "t")
    (comparison "<")

    (tStat ?tStat)
    (degreesOfFreedom ?degreesOfFreedom)

    =>

    (bind ?pValue (tCDF ?tStat ?degreesOfFreedom))

    (assert (pValue ?pValue))

    (bind ?doPartB
        (str-cat 
            "$$p\\textrm{-value} = P(t < "
            (roundTo ?tStat 3)
            ") ="
            (roundTo ?pValue 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)

/*
* Builds doPartB for procedureType = test, testType = t, comparison = \\neq
*/
(defrule build-doPartB-test-t-notEqual
    (need-doPartB ?)

    (procedureType "test")
    (testType "t")
    (comparison "\\neq")

    (tStat ?tStat)
    (degreesOfFreedom ?degreesOfFreedom)

    =>

    (bind ?pValue (* 2 (tCDF (- 0 (abs ?tStat)) ?degreesOfFreedom)))

    (assert (pValue ?pValue))

    (bind ?doPartB
        (str-cat 
            "$$p\\textrm{-value} = P(|t| > |"
            (roundTo ?tStat 3)
            "|) = 2P(t < -"
            (abs (roundTo ?tStat 3))
            ") = "
            (roundTo ?pValue 3)
            "$$"
        )
    )

    ; (printout t crlf ?doPartB)
    (assert (doPartB ?doPartB))
)
/*
* ======================================================================
* PART C
* ======================================================================
*/
(deftemplate planPartCComponent (slot value) (slot which))
(do-backward-chaining planPartCComponent)

/*
* Builds planPartC for one sample
*/
(defrule build-planPartC-one
    (need-planPartC ?)

    (numSamples "one")

    (planPartCComponent (which ?*ONLY*) (value ?planPartCComponent))

    =>

    (bind ?planPartC
        (str-cat
            "Since "
            ?planPartCComponent
            ", by the 10\\% rule, independence can be assumed."
        )
    )

    ; (printout t crlf ?planPartC)
    (assert (planPartC ?planPartC))
)

/*
* Builds planPartC for two samples
*/
(defrule build-planPartC-two
    (need-planPartC ?)

    (numSamples "two")

    (planPartCComponent (which ?*FIRST*) (value ?planPartCComponent1))
    (planPartCComponent (which ?*SECOND*) (value ?planPartCComponent2))
    =>

    (bind ?planPartC
        (str-cat
            "Since "
            ?planPartCComponent1
            " and "
            ?planPartCComponent2
            ", by the 10\\% rule, independence can be assumed."
        )
    )

    ; (printout t crlf ?planPartC)
    (assert (planPartC ?planPartC))
)


/*
* Builds a component of planPartC
*/
(defrule build-planPartCComponent
    (need-planPartCComponent (which ?which) (value ?value))

    (populationDescription (which ?which) (value ?populationDescription))
    (sampleSize (which ?which) (value ?sampleSize))

    =>

    ; n/x, n/x1, or n/x2
    (bind ?whichPhrase "")
    (if (eq ?which ?*FIRST*) then (bind ?whichPhrase "_1"))
    (if (eq ?which ?*SECOND*) then (bind ?whichPhrase "_2"))
    

    (bind ?planPartCComponent
        (str-cat
            "the number of "
            ?populationDescription
            " \\(\\geq 10n"
            ?whichPhrase
            "= 10("
            ?sampleSize
            ") = " 
            (* 10 ?sampleSize)
            "\\)"
        )
    )

    ; (printout t crlf ?planPartCComponent)
    (assert (planPartCComponent (which ?which) (value ?planPartCComponent)))
)
/*
* ======================================================================
* PART B
* ======================================================================
*/

(deftemplate planPartBComponent (slot value) (slot which))
(do-backward-chaining planPartBComponent)

/*
* Builds planPartB for one sample
*/
(defrule build-planPartB-one
    (need-planPartB ?)

    (numSamples "one")

    (planPartBComponent (which ?*ONLY*) (value ?planPartBComponent))

    =>

    (bind ?planPartB
        (str-cat
            ?planPartBComponent
        )
    )

    ; (printout t crlf ?planPartB)
    (assert (planPartB ?planPartB))
)

/*
* Builds planPartB for two samples
*/
(defrule build-planPartB-two
    (need-planPartB ?)

    (numSamples "two")

    (planPartBComponent (which ?*FIRST*) (value ?planPartBComponent1))
    (planPartBComponent (which ?*SECOND*) (value ?planPartBComponent2))
    =>

    (bind ?planPartB
        (str-cat
            ?planPartBComponent1
            " "
            ?planPartBComponent2
            " Furthermore, both samples are taken independently."
        )
    )

    ; (printout t crlf ?planPartB)
    (assert (planPartB ?planPartB))
)


/*
* Builds a component of planPartB if randomness = random
*/
(defrule build-planPartBComponent-random
    (need-planPartBComponent (which ?which) (value ?))

    (randomness (which ?which) (value "random"))

    (populationDescription (which ?which) (value ?populationDescription))
    
    =>

    (bind ?planPartBComponent
        (str-cat 
            "A random sample of "
            ?populationDescription
            " is taken."
        ) 
    )

    ; (printout t crlf ?planPartBComponent)
    (assert (planPartBComponent (which ?which) (value ?planPartBComponent)))
)  

/*
* Builds planPartB component if randomness = not random
*/
/*
* Builds a component of planPartB if randomness = random
*/
(defrule build-planPartBComponent-notRandom
    (need-planPartBComponent (which ?which) (value ?))

    (randomness (which ?which) (value "not random"))

    (populationDescription (which ?which) (value ?populationDescription))
    
    =>

    (bind ?planPartBComponent
        (str-cat 
            "While the taken sample of "
            ?populationDescription
            " is not random, it can be safely assumed to be representative of the population."
        ) 
    )

    ; (printout t crlf ?planPartBComponent)
    (assert (planPartBComponent (which ?which) (value ?planPartBComponent)))
)
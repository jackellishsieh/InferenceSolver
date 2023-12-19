/*
* ======================================================================
* LARGE COUNTS
* ======================================================================
*/
(deftemplate largeCounts (slot which) (slot value))     ; Boolean for if passes large counts
(do-backward-chaining largeCounts)


/*
* For a proportion interval OR a two-sample proportion test, given a sample size and sample proportion,
* check if Large Counts applies
*/
(defrule largeCounts-interval-or-two
    (need-largeCounts (which ?which) (value ?))

    (or 
        (procedureType "interval")
        (and
            (procedureType "test")
            (numSamples "two")
        )
    )
    (sampleSize (which ?which) (value ?sampleSize))
    (sampleProportion (which ?which) (value ?sampleProportion))
    
    =>
    (bind ?sampleCount (* ?sampleSize ?sampleProportion))
    (bind ?largeCounts (and (>= ?sampleCount 10) (>= (- ?sampleSize ?sampleCount) 10)))

    (assert (largeCounts (which ?which) (value ?largeCounts)))
)

; (defrule largeCounts-two
;     (need-largeCounts (which ?which) (value ?))

;     (procedureType "test")
;     (numSamples "two")

;     (sampleSize (which ?which) (value ?sampleSize))
;     (sampleProportion (which ?which) (value ?sampleProportion))
    
;     =>
;     (bind ?sampleCount (* ?sampleSize ?sampleProportion))
;     (bind ?largeCounts (and (>= ?sampleCount 10) (>= (- ?sampleSize ?sampleCount) 10)))

;     (assert (largeCounts (which ?which) (value ?largeCounts)))
; )

/*
* For a one-sample proportion test, given the sample size and hypothesis proportion, 
* check if Large Counts applies
*/
(defrule largeCounts-test-one
    (need-largeCounts (which ?which) (value ?))

    (procedureType "test")
    (numSamples "one")

    (sampleSize (which ?which) (value ?sampleSize))
    (hypothesisProportion ?hypothesisProportion)
    
    =>
    (bind ?sampleCount (* ?sampleSize ?hypothesisProportion))
    (bind ?largeCounts (and (>= ?sampleCount 10) (>= (- ?sampleSize ?sampleCount) 10)))
    
    (assert (largeCounts (which ?which) (value ?largeCounts)))
)
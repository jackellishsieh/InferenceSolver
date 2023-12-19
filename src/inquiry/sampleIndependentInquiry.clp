/*
* Rules for inquiring about needed information that is independent of samples
*/
(do-backward-chaining numSamples)               ; String "one" or "two" or "paired"
(do-backward-chaining parameterType)            ; String "proportion" or "mean"
(do-backward-chaining parameterDescription)     ; String describing the parameter

(do-backward-chaining comparison)               ; String "<", ">", "≠"
(do-backward-chaining hypothesisMean)           ; Float mu_0
(do-backward-chaining hypothesisProportion)     ; Probability p_0 

(do-backward-chaining hypothesisMeanDifference)         ; Float mu_1 - mu_2. Right now, set to 0 always
(do-backward-chaining hypothesisProportionDifference)   ; Float p_1 - p_2. Right now, set to 0 always

(do-backward-chaining testType)                 ; String "z" or "t"
(do-backward-chaining procedureType)            ; String "interval" or "test"
(do-backward-chaining alpha)                    ; Probability for interval or for test

/*
* numSamples
*/
(defrule inquiry-numSamples
    (need-numSamples ?)
    =>
    (bind ?NUM_SAMPLES_OPTIONS (create$ "one" "two"))
    (assert (numSamples (inputStringFromList "How many samples are there?" ?NUM_SAMPLES_OPTIONS)))
)

/*
* parameterType
*/
(defrule inquiry-parameterType
    (need-parameterType ?)
    =>
    (bind ?PARAMETER_TYPE_OPTIONS (create$ "proportion" "mean"))
    (assert (parameterType (inputStringFromList "Are we interested in a proportion or a mean?" ?PARAMETER_TYPE_OPTIONS)))
)

/*
* parameterDescription
*/
(defrule inquiry-parameterDescription-proportion
    (parameterType "proportion")
    (need-parameterDescription ?)
    =>
    (bind ?prompt (str-cat "What's the proportion of? For example, enter \"red balloons\""))
    (assert (parameterDescription (inputString ?prompt)))
)

(defrule inquiry-parameterDescription-mean
    (parameterType "mean")
    (need-parameterDescription ?)
    =>
    (bind ?prompt (str-cat "What's the mean of? For example, enter \"heart rate\""))
    (assert (parameterDescription (inputString ?prompt)))
)

/*
* Test type
* Change the phrasing a bit if there are two populations
*/
(defrule inquiry-testType
    (need-testType ?)

    (parameterType "mean")  ; Only ask if not a proportion

    (numSamples ?numSamples)
    =>
    (bind ?TEST_TYPE_OPTIONS (create$ "known" "unknown"))
    
    (bind ?prompt "Is the standard deviation of the population known or unknown?")
    (if (eq ?numSamples "two") then 
        (bind ?prompt "Are the standard deviations of both populations both known, or is at least one unknown?")
    )

    (bind ?response (inputStringFromList ?prompt ?TEST_TYPE_OPTIONS))

    (if (eq ?response "known") then
        (assert (testType "z"))
     else
        (assert (testType "t"))
    )
)

/*
* procedureType
*/
(defrule inquiry-procedureType
    (need-procedureType ?)
    =>
    (bind ?procedure_TYPE_OPTIONS (create$ "interval" "test"))
    (assert (procedureType (inputStringFromList "Are we constructing a confidence interval or a performing a significance test?" ?procedure_TYPE_OPTIONS)))
)

/*
* alpha
*/
(defrule inquiry-alpha-interval
    (need-alpha ?)
    (procedureType "interval")
    =>
    (assert (alpha (- 1.0 (inputProbability "What level of confidence (default is 0.95) are we using?"))))
)

(defrule inquiry-alpha-test
    (need-alpha ?)
    (procedureType "test")
    =>
    (assert (alpha (inputProbability "What level of significance (default is 0.05) are we using?")))
)

/*
* comparison
*/
(defrule inquiry-comparison
    (need-comparison ?)
    =>
    (bind ?COMPARISON_OPTIONS (create$ ">" "<" "≠"))
    (bind ?response (inputStringFromList "Which hypothesis are you testing?" ?COMPARISON_OPTIONS))

    ; < becomes <, > becomes >, ≠ becomes \\neq
    (bind ?comparison "\\neq")
    (if (eq ?response ">") then
        (bind ?comparison ">")
    )
    (if (eq ?response "<") then
        (bind ?comparison "<")
    )

    (assert (comparison ?comparison))
)

(defrule inquiry-hypothesisMean
    (need-hypothesisMean ?)
    =>
    (assert (hypothesisMean (inputFloat "What is the hypothesis mean value?")))
)

(defrule inquiry-hypothesisProportion
    (need-hypothesisProportion ?)
    =>
    (assert (hypothesisProportion (inputProbability "What is the hypothesis proportion value?")))
)

; (defrule inquiry-hypothesisMeanDifference
;     (need-hypothesisMeanDifference ?)
;     =>
;     (assert (hypothesisMeanDifference (inputFloat "What is the hypothesis mean difference?")))
; )

; (defrule inquiry-hypothesisProportionDifference
;     (need-hypothesisProportionDifference ?)
;     =>
;     (assert (hypothesisProportionDifference (inputFloat "What is the hypothesis proportion difference?")))
; )
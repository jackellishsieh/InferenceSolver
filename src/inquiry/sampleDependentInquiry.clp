/*
* Rules for inquiring about needed information that is dependent on the particular sample
*/

; String constants that make questions about information easy to print
(defglobal ?*ONLY* = "")
(defglobal ?*FIRST* = " first")
(defglobal ?*SECOND* = " second")

(deftemplate populationDescription          (slot value) (slot which))    ; String describing the population

(deftemplate sampleSize                     (slot value) (slot which))    ; Integer sample size

(deftemplate randomness                     (slot value) (slot which))    ; String "random" or "not random"

(deftemplate populationNormality            (slot value) (slot which))    ; String "normal" or "not normal"
(deftemplate sampleBalance                  (slot value) (slot which))    ; String "balanced" or "not balanced"

(deftemplate sampleProportion               (slot value) (slot which))    ; Probability p hat
(deftemplate sampleMean                     (slot value) (slot which))    ; Float x hat        

(deftemplate sampleStandardDeviation        (slot value) (slot which))    ; Nonnegative float s_x
(deftemplate populationStandardDeviation    (slot value) (slot which))    ; Nonnegative float sigma_x


(do-backward-chaining populationDescription)
(do-backward-chaining sampleSize)
(do-backward-chaining sampleProportion)
(do-backward-chaining sampleMean)
(do-backward-chaining sampleStandardDeviation)
(do-backward-chaining populationStandardDeviation)
(do-backward-chaining randomness)
(do-backward-chaining populationNormality)
(do-backward-chaining sampleBalance)
(do-backward-chaining populationDescription)

/*
* populationDescription
*/
(defrule inquiry-populationDescription
    (need-populationDescription (which ?which) (value ?))
    =>
    (bind ?value (inputString (str-cat "What's the" ?which " population of interest?")))
    (assert (populationDescription (which ?which) (value ?value)))
)

/*
* sampleSize
*/
(defrule inquiry-sampleSize
    (need-sampleSize (which ?which) (value ?))

    (populationDescription (which ?which) (value ?populationDescription))

    =>
    (bind ?prompt (str-cat "What's the size of the sample of " ?populationDescription "?"))
    (bind ?sampleSize (inputNaturalNumber ?prompt))
    (assert (sampleSize (which ?which) (value ?sampleSize)))
)

/*
* randomness
*/
(defrule inquiry-randomness
    (need-randomness (which ?which) (value ?))

    (populationDescription (which ?which) (value ?populationDescription))
    =>
    (bind ?RANDOMNESS_OPTIONS (create$ "random" "not random"))
    (bind ?prompt (str-cat "According to the prompt, is the sample of " ?populationDescription " explicitly random?"))
    (bind ?randomness (inputStringFromList ?prompt ?RANDOMNESS_OPTIONS))
    
    (assert (randomness (which ?which) (value ?randomness)))
)

/*
* populationNormality
*/
(defrule inquiry-populationNormality
    (need-populationNormality (which ?which) (value ?))

    (populationDescription (which ?which) (value ?populationDescription))

    =>
    (bind ?POPULATION_NORMALITY_OPTIONS (create$ "yes" "no"))
    (bind ?prompt (str-cat "Is the population of " ?populationDescription " normally distributed?"))
    (bind ?response (inputStringFromList ?prompt ?POPULATION_NORMALITY_OPTIONS))

    (bind ?populationNormality "normal")
    (if (eq ?response "no") then
        (bind ?populationNormality "not normal")
    )

    (assert (populationNormality (which ?which) (value ?populationNormality)))
)

/*
* sampleBalance
*/
(defrule inquiry-sampleBalance
    (need-sampleBalance (which ?which) (value ?))

    (populationDescription (which ?which) (value ?populationDescription))

    =>
    (bind ?SAMPLE_BALANCE_OPTIONS (create$ "yes" "no"))
    (bind ?prompt (str-cat "Does the sample distribution for the " ?populationDescription " have strong skew or outliers?"))
    (bind ?response (inputStringFromList ?prompt ?SAMPLE_BALANCE_OPTIONS))

    (bind ?sampleBalance "balanced")
    (if (eq ?response "yes") then
        (bind ?sampleBalance "not balanced")
    )

    (assert (sampleBalance (which ?which) (value ?sampleBalance)))
)

/*
* sampleProportion
*/
(defrule inquiry-sampleProportion
    (need-sampleProportion (which ?which) (value ?))

    (populationDescription (which ?which) (value ?populationDescription))
    =>
    (bind ?prompt (str-cat "What is the sample proportion value for the " ?populationDescription "?"))
    (bind ?sampleProportion (inputProbability ?prompt))

    (assert (sampleProportion (which ?which) (value ?sampleProportion)))
)

/*
* sampleMean
*/
(defrule inquiry-sampleMean
    (need-sampleMean (which ?which) (value ?))

    (populationDescription (which ?which) (value ?populationDescription))
    =>
    (bind ?prompt (str-cat "What is the sample mean value for the " ?populationDescription "?"))
    (bind ?sampleMean (inputFloat ?prompt))

    (assert (sampleMean (which ?which) (value ?sampleMean)))
)

/*
* populationStandardDeviation
*/
(defrule inquiry-populationStandardDeviation
    (need-populationStandardDeviation (which ?which) (value ?))

    (populationDescription (which ?which) (value ?populationDescription))
    =>
    (bind ?prompt (str-cat "What is the population standard deviation for the " ?populationDescription "?"))
    (bind ?populationStandardDeviation (inputNonnegativeFloat ?prompt))

    (assert (populationStandardDeviation (which ?which) (value ?populationStandardDeviation)))
)

/*
* sampleStandardDeviation
*/
(defrule inquiry-sampleStandardDeviation
    (need-sampleStandardDeviation (which ?which) (value ?))

    (populationDescription (which ?which) (value ?populationDescription))
    =>
    (bind ?prompt (str-cat "What is the sample standard deviation for the " ?populationDescription "?"))
    (bind ?sampleStandardDeviation (inputNonnegativeFloat ?prompt))

    (assert (sampleStandardDeviation (which ?which) (value ?sampleStandardDeviation)))
)
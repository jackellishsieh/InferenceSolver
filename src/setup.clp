(clear)
(reset)

(defglobal ?*OUTPUT_FILENAME* = "solution.tex")

(batch src/statsUtilities.clp)

; Inquiry rules
(batch src/inquiry.clp)

; Deduction rules
(batch src/deduction.clp)

; Solution building rules
(batch src/buildSolution.clp)

(batch src/buildState.clp)

(batch src/buildPlan.clp)

(batch src/buildDo.clp)

(batch src/buildConclude.clp)

(load-function InvNorm)
(load-function InvT)
(load-function NormalCDF)
(load-function TCDF)

; (assert (numSamples "two"))
; (assert (alpha 0.05))
; (assert (procedureType "test"))
; (assert (parameterType "mean"))
; (assert (parameterDescription "speed"))

; (assert (populationDescription (which ?*ONLY*) (value "men")))
; (assert (populationDescription (which ?*FIRST*) (value "women")))
; (assert (populationDescription (which ?*SECOND*) (value "men")))

; (assert (randomness (which ?*ONLY*) (value "random")))
; (assert (randomness (which ?*FIRST*) (value "random")))
; (assert (randomness (which ?*SECOND*) (value "random")))

; (assert (sampleSize (which ?*FIRST*) (value 100)))
; (assert (sampleSize (which ?*SECOND*) (value 25)))

; (assert (sampleStandardDeviation (which ?*FIRST*) (value 3)))
; (assert (sampleStandardDeviation (which ?*SECOND*) (value 5)))

; (assert (sampleStandardDeviation (which ?*FIRST*) (value 3)))
; (assert (sampleStandardDeviation (which ?*SECOND*) (value 5)))

; For easier testing
; (assert (numSamples "one"))
; (assert (alpha 0.05))
; (assert (procedureType "test"))
; (assert (parameterType "proportion"))
; (assert (sampleSize 210))
; (assert (sampleProportion (/ 35 210)))
; (assert (hypothesisProportion 0.12))
; (assert (populationDescription "Phillie fans"))
; (assert (parameterDescription "red cars"))
; (assert (comparison ">"))

; (assert (numSamples "one"))
; (assert (alpha 0.10))
; (assert (procedureType "interval"))
; (assert (parameterType "mean"))
; (assert (sampleSize 15))
; (assert (sampleMean 29.43))
; (assert (sampleStandardDeviation 16.23))
; (assert (parameterDescription "percent increase in gas mileage using Platinum Gasaver"))
; (assert (populationDescription "vehicles"))

; (assert (randomness "random"))
; (assert (populationNormality "not normal"))
; (assert (sampleBalance "balanced"))


(run)
/*
* Pulls all the build parts together
*/
(do-backward-chaining planPartA)
(do-backward-chaining planPartB)
(do-backward-chaining planPartC)
(do-backward-chaining planPartD)

(defrule build-plan
    (need-plan ?)

    (planPartA ?planPartA)
    (planPartB ?planPartB)
    (planPartC ?planPartC)
    (planPartD ?planPartD)

    =>
    (printout t crlf crlf "(!!!) Finished plan section (!!!)" crlf crlf)

    (bind ?plan
        (str-cat
            "\\textbf{Plan}: "
            ?planPartA
                ?*NEWLINE* "\\begin{itemize}"
                ?*NEWLINE* "\\item " ?*TAB* "Randomness: "
            ?planPartB ?*NEWLINE*
                ?*NEWLINE* "\\item " ?*TAB* "Independence: "
            ?planPartC ?*NEWLINE*
                ?*NEWLINE* "\\item " ?*TAB* "Normality: "
            ?planPartD
                ?*NEWLINE*"\\end{itemize}"
        )
    )

    (assert (plan ?plan))
)

(batch src/buildPlan/buildPlanPartA.clp)
(batch src/buildPlan/buildPlanPartB.clp)
(batch src/buildPlan/buildPlanPartC.clp)
(batch src/buildPlan/buildPlanPartD.clp)

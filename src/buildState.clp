/*
* Author:                  Jack Hsieh
* Date of creation:        March 10, 2022
* Functional description:  Writes the state section for AP Stats
*
*/

/*
* Pulls all the build parts together
*/
(do-backward-chaining statePartA)
(do-backward-chaining statePartB)

(defrule build-state
    (need-state ?)

    (statePartA ?statePartA)
    (statePartB ?statePartB)
    =>
    (printout t crlf crlf "(!!!) Finished state section (!!!)" crlf crlf)

    ; (printout t ?statePartA crlf)
    ; (printout t ?statePartB crlf)

    (bind ?state 
        (str-cat
            "\\textbf{State}: "
            ?statePartA
            ?*NEWLINE*
            ?statePartB
        )
    )

    (assert (state ?state))
)

(batch src/buildState/buildStatePartA.clp)
(batch src/buildState/buildStatePartB.clp)
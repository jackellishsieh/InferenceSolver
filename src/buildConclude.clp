/*
* Pulls all the build parts together
*/
(do-backward-chaining concludePartA)
(do-backward-chaining concludePartB)

(defrule build-conclude
    (need-conclude ?)

    (concludePartA ?concludePartA)
    (concludePartB ?concludePartB)
    =>
    (printout t crlf crlf "(!!!) Finished conclude section (!!!)" crlf crlf)

    ; (printout t ?concludePartA crlf)
    ; (printout t ?concludePartB crlf)

    (bind ?conclude 
        (str-cat
            "\\textbf{Conclude}: "
            ?concludePartA
                    ?*NEWLINE*
            ?concludePartB
        )
    )

    (assert (conclude ?conclude))
)    

(batch src/buildConclude/buildConcludePartA.clp)
(batch src/buildConclude/buildConcludePartB.clp)
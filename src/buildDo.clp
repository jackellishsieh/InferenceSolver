/*
* Pulls all the build parts together
*/
(do-backward-chaining doPartA)
(do-backward-chaining doPartB)

(defrule build-do
    (need-do ?)

    (doPartA ?doPartA)
    (doPartB ?doPartB)
    =>
    (printout t crlf crlf "(!!!) Finished do section (!!!)" crlf crlf)

    (bind ?do
        (str-cat
            "\\textbf{Do}: "
            ?doPartA
                ?*NEWLINE*
            ?doPartB
        )
    )

    (printout t crlf ?do)
    (assert (do ?do))
)    

(batch src/buildDo/buildDoPartAInterval.clp)
(batch src/buildDo/buildDoPartBInterval.clp)

(batch src/buildDo/buildDoPartATest.clp)
(batch src/buildDo/buildDoPartBTest.clp)
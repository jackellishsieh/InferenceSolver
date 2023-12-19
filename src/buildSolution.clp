(do-backward-chaining solution)
(do-backward-chaining state)
(do-backward-chaining plan)
(do-backward-chaining do)
(do-backward-chaining conclude)

(defrule printSolution
    (solution ?solution)

    =>

    (printout t ?solution)
)

(defrule exportSolution
    (solution ?solution)

    =>

    (printout t "WRITING SOLUTION TO " ?*OUTPUT_FILENAME*)

    (close outputRouter)
    (open ?*OUTPUT_FILENAME* outputRouter "w")

    (bind ?tex
        (str-cat
            "\\documentclass{article}"
            ?*NEWLINE*
            "\\usepackage{amsthm}"
            ?*NEWLINE*
            "\\begin{document}"
            ?*NEWLINE*
            ?solution
            ?*NEWLINE*
            "\\end{document}"
        )
    )

    (printout outputRouter ?tex)
)

(defrule buildSolution
    (need-solution ?)

    (state ?state)
    (plan ?plan)
    (do ?do)
    (conclude ?conclude)

    =>

    (printout t crlf crlf crlf "FINISHED EVERYTHING!!" crlf crlf crlf)

    (bind ?solution 
        (str-cat
            ?state
            "\\newline" ?*NEWLINE* ?*NEWLINE* 
            ?plan
            "\\newline" ?*NEWLINE* ?*NEWLINE* 
            ?do
            "\\newline" ?*NEWLINE* ?*NEWLINE* 
            ?conclude
        )
    )

    (assert (solution ?solution))
)
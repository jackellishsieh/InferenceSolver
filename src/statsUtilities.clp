 /*
* Author:                  Jack Hsieh
* Date of creation:        March 10, 2022
* Functional description:  Functions for inputing various data types: integer, float, string
*/

(defglobal ?*TAB* = "   ")
(defglobal ?*NEWLINE* = "
")


(defglobal ?*QUIT_STRING* = "q") ; String for quitting an input loop
(defglobal ?*QUIT_SYMBOL* = (sym-cat ?*QUIT_STRING*)) ; Symbol for quitting an input loop


/* 
* Rounds a decimal to a certain number of places
* Formula = 10^-places * floor(10^places * ?value + 0.5)
*/
(deffunction roundTo (?value ?places)
    (bind ?placeMultiplier (** 10 ?places))
    (return (/ (integer (+ (* ?value ?placeMultiplier) 0.5)) ?placeMultiplier))
)

/*
* Serves as a generalized input loop for inputting a data type
* Returns
* Returns FALSE upon quit

* ?conditionName = string/symbol name of function for evaluating if input is valid
* ?readName = string (read or readline) to read the input

* ?initialPrompt = string prompt for the first time asking the question (includes datatype)
* ?repeatPrompt = string prompt for repeatedly asking the question
*/
(deffunction inputLoop (?initialPrompt ?repeatPrompt ?conditionName ?readName)
    ; String to dynamically read each input
    (bind ?READ_STRING (str-cat "(" ?readName ")"))

    ; String to dynamically reevaluate each input    
    (bind ?EVALUATION_STRING (str-cat "(" ?conditionName " ?input)"))

    ; Initial query
    (printout t crlf ?initialPrompt)
    (bind ?input (eval ?READ_STRING))

    ; Continue the loop if the input is not the quit string and fails the condition check
    (while (and (neq (str-cat ?input) ?*QUIT_STRING*) (not (eval ?EVALUATION_STRING))) do        
        (printout t ?repeatPrompt)
        (bind ?input (eval ?READ_STRING))
    )

    ; Return false and quit if the input matches the quit string.
    ; Otherwise, return the input 
    (if (eq (str-cat ?input) ?*QUIT_STRING*) then
        (bind ?input FALSE)
    )

    (return ?input)
) ; deffunction inputLoop (?prompt ?conditionName ?dataTypeString)

/*
* Inputs an integer
*/
(deffunction inputInteger (?prompt)
    (bind ?INITIAL_PROMPT (str-cat ?prompt " (enter an integer): "))
    (bind ?REPEAT_PROMPT (str-cat ?*TAB* "Please enter an integer: "))

    (return (inputLoop ?INITIAL_PROMPT ?REPEAT_PROMPT integerp read))
)

/*
* Inputs a natural number
*/
(deffunction inputNaturalNumber (?prompt)
    (bind ?INITIAL_PROMPT (str-cat ?prompt " (enter a natural number): "))
    (bind ?REPEAT_PROMPT (str-cat ?*TAB* "Please enter a natural number: "))

    ; Returns TRUE if lowercased symbol is an integer and greater than 0
    (bind ?checkNaturalNumber
        (lambda (?input)
            (return (and (integerp ?input) (> ?input )))
        )
    )

    (return (inputLoop ?INITIAL_PROMPT ?REPEAT_PROMPT "?checkNaturalNumber" read))
)

/*
* Inputs a float
* Must accept if given an integer or float -> number
*/
(deffunction inputFloat (?prompt)
    (bind ?INITIAL_PROMPT (str-cat ?prompt " (enter a float): "))
    (bind ?REPEAT_PROMPT (str-cat ?*TAB* "Please enter an float: "))

    (bind ?return (inputLoop ?INITIAL_PROMPT ?REPEAT_PROMPT numberp read))

    ; Return false if FALSE
    (if (not ?return) then
        (return ?return)
    )
    ; Otherwise, convert to float
    (return (float ?return))
)

/*
* Inputs a float from 0 to 1, inclusive
* Must accept if given an integer or float -> number
*/
(deffunction inputProbability (?prompt)
    (bind ?INITIAL_PROMPT (str-cat ?prompt " (enter a float from 0 to 1): "))
    (bind ?REPEAT_PROMPT (str-cat ?*TAB* "Please enter an float from 0 to 1: "))

    ; Returns TRUE if lowercased symbol is a number and from 0 to 1
    (bind ?checkProbability 
        (lambda (?input)
            (return (and (numberp ?input) (>= ?input 0) (<= ?input 1)))
        )
    )

    ; Get the unprocessed input
    (bind ?return (inputLoop ?INITIAL_PROMPT ?REPEAT_PROMPT "?checkProbability" read))

    ; Return false if FALSE
    (if (not ?return) then
        (return ?return)
    )
    ; Otherwise, convert to float
    (return (float ?return))
)

/*
* Inputs a nonnegative float
* Must accept if given an integer or float -> number
*/
(deffunction inputNonnegativeFloat (?prompt)
    (bind ?INITIAL_PROMPT (str-cat ?prompt " (enter a nonnegative float): "))
    (bind ?REPEAT_PROMPT (str-cat ?*TAB* "Please enter a nonnegative float: "))

    ; Returns TRUE if lowercased symbol is a number and greater than or equal to 0
    (bind ?checkNonnegativeFloat 
        (lambda (?input)
            (return (and (numberp ?input) (>= ?input 0)))
        )
    )

    ; Get the unprocessed input
    (bind ?return (inputLoop ?INITIAL_PROMPT ?REPEAT_PROMPT "?checkNonnegativeFloat" read))

    ; Return false if FALSE
    (if (not ?return) then
        (return ?return)
    )
    ; Otherwise, convert to float
    (return (float ?return))
)

/*
* Inputs a string
* Must accept if given a symbol or string -> lexeme
*/
(deffunction inputString (?prompt)
    (bind ?INITIAL_PROMPT (str-cat ?prompt " (enter a string): "))
    (bind ?REPEAT_PROMPT (str-cat ?*TAB* "Please enter an string: "))

    (return (inputLoop ?INITIAL_PROMPT ?REPEAT_PROMPT lexemep readline))
)


/*
* Converts a list of strings to an English string:
* a --> a
* (a, b) --> a [or] b
* (a, b, c) --> a, b, [or] c
*/
(deffunction listToEnglish (?list ?conjunction)
   ; Just return the element as a string if one element
   (if (eq (length$ ?list) 1) then
        (return (str-cat (nth$ 1 ?list)))
    )

    ; If there are two elements, join with an "or"
    (if (eq (length$ ?list) 2) then
        (return (str-cat (nth$ 1 ?list) " " ?conjunction " " (nth$ 2 ?list)))
    )
    
    ; If there are more elements, join as a, b, c, or d
    (bind ?string (nth$ 1 ?list))

    (for (bind ?i 2) (< ?i (length$ ?list)) (++ ?i)
        (bind ?string (str-cat ?string ", " (nth$ ?i ?list)))
    )
    (bind ?string (str-cat ?string ", or " (nth$ ?i ?list)))

    (return ?string)
)

/*
* Inputs one of the given strings
* Must accept if given a symbol or string -> lexeme
*/
(deffunction inputStringFromList (?prompt ?stringList)
    (bind ?INITIAL_PROMPT (str-cat ?prompt " (enter either " (listToEnglish ?stringList "or") "): "))
    (bind ?REPEAT_PROMPT (str-cat ?*TAB* "Please enter an option from the list: "))

    ; Returns TRUE if lowercased symbol is a part of the symbol list
    (bind ?checkAgainstList 
        (lambda (?input)
            (return (member$ (lowcase ?input) ?stringList))
        )
    )

    ; Get the unprocessed input
    (bind ?return (inputLoop ?INITIAL_PROMPT ?REPEAT_PROMPT "?checkAgainstList" readline))

    ; Return false if FALSE
    (if (not ?return) then
        (return ?return)
    )
    ; Otherwise, convert to lowercase string
    (return (lowcase ?return))
)

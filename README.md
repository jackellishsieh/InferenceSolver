# InferenceSolver
A user-friendly expert system that generates $\LaTeX$-styled solutions to statistical inference problems

## Overview

InferenceSolver is a knowledge-based system that...
- Asks the user for problem parameters in plain English
- Outputs detailed solutions as a .tex file with explained calculations, reasoning, and interpretation
- Handles the following parameters:
-- [one/two]-sample 
-- [proportion/mean] 
-- [$z$/$t$]
-- [confidence interval/significance test]
-- [random/non-random] [balanced/unbalanced] sample
-- [normal/non-normal] population


## Usage

### Dependencies
- [Jess rule engine for Java](http://alvarestech.com/temp/fuzzyjess/Jess60/Jess70b7/docs/intro.html#setup)
- [Apache Commons Math](https://commons.apache.org/proper/commons-math/)

### Installing in Eclipse
1.  Include Jess and Apache Commons Math  in Referenced Libraries
2.  Install the .src folder into the project

### Running in Eclipse
1. Run the Jess engine from within the project
2. Batch in the *setup.clp* file by entering `(batch src/setup.clp)`
3. The program will ask the user for needed information.
4. Once all relevant questions have been answered, the program will output the solution file as *solution.tex*
7.  To restart, enter `(reset) (run)`

Running the Jess engine using the provided Main.java file provides additional debug information about the facts in working memory.

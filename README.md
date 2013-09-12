# Line Length Miner

A tool to mine GitHub for source code to analyze line length frequencies of code in Ruby.

## Hypothesis

A line length of 100 characters is "typical" to at least the 99th percentile.

## Methodology

* Selection of Projects
    * Search GitHub for public repositories containing Ruby code and list them by number of stars in descending order
* Calculation of Line Length
    * All lines except the following are included:
        1. Lines that consist solely of whitespace
        1. Lines that consist solely of comments
        1. Lines that contain only the string `end`
        1. Lines that are over 200 characters long
    * The length of the line is the number of characters that make up the line except for the trailing line terminator, but including all other whitespace
* Process
    1. Select the 10 most popular Ruby projects on GitHub
    1. Check them out to the local machine
    1. Calculate the set of line-lengths
    1. Calculate &mu; (mean) and &sigma; (standard deviation)
    1. Calculate 99<sup>th</sup> percentile by the formula:
        * X = &mu; + &sigma; * z
        * Where z = 2.326348 (z-score of 99<sup>th</sup> percentile)

## Assumptions

1. Line lengths are normally distributed
1. The most popular projects contain the most "typical" code

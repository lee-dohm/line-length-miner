# Line Length Miner

A tool to mine GitHub for source code to analyze line length frequencies of code in Ruby.

## Hypothesis

The 99<sup>th</sup> percentile of "typical" line lengths is greater than 100 characters.

There are tensions pulling different directions at line lengths:

* Encouraging longer lines
    * Longer identifiers are more readable
    * Wrapped lines are prone to more bugs
    * Wrapped lines are less readable
    * Screen sizes on desktops
* Encouraging shorter lines
    * Longer lines are less readable
    * Some tools have line length limitations
    * Screen sizes on laptops
    * Multi-window views

A balance can be struck, but the question is where? My idea is that "typical" lines of code cluster around a particular length, i.e. they follow a [normal distribution](http://en.wikipedia.org/wiki/Normal_distribution). I want to allow "typical" lines of code to not be inconvenienced by being forced to wrap and encourage abnormal lines of code to be rewritten. I've chosen the 99<sup>th</sup> percentile as the cutoff between typical and abnormal, meaning I am assuming that one out of every one hundred lines in a normal code base is problematically long.

## Methodology

* Selection of Projects
    * Search GitHub for public repositories containing Ruby code and list them by number of stars in descending order
* Calculation of Line Length
    * Look at lines of text in files ending with `.rb`
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
1. Even in projects containing high-quality code, 1 in 100 lines of code will be abnormally long

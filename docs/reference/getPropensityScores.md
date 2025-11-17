# Returns a data frame with two columns corresponding to the level 2 variable and the fitted value from the logistic regression.

Returns a data frame with two columns corresponding to the level 2
variable and the fitted value from the logistic regression.

## Usage

``` r
getPropensityScores(lr.results, nStrata = 5)
```

## Arguments

- lr.results:

  the results of \[mlpsa.logistic()\]

- nStrata:

  number of strata within each level.

## Value

a data frame

## See also

mlpsa.logistic

# Estimates propensity scores using logistic regression.

This method will estimate a separate logistic regression model for each
level 2 (or cluster).

## Usage

``` r
mlpsa.logistic(vars, formula, level2, stepAIC = FALSE, ...)
```

## Arguments

- vars:

  data frame containing the variables to estimate the logistic
  regression

- formula:

  the logistic regression formula to use

- level2:

  the name of the column containing the level 2 specification

- stepAIC:

  if true, the \[MASS::stepAIC()\] from the \`MASS\` package will be
  used within each level.

- ...:

  currently unused.

## Value

a list of glm classes for each level 2 or stepwise-selected model if
stepAIC is true.

## See also

getPropensityScores

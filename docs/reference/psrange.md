# Estimates models with increasing number of comparison subjects starting from 1:1 to using all available comparison group subjects.

Estimates models with increasing number of comparison subjects starting
from 1:1 to using all available comparison group subjects.

## Usage

``` r
psrange(
  df,
  treatvar,
  formula,
  nsteps = 10,
  nboot = 10,
  samples,
  type = c("logistic", "ctree"),
  ...
)
```

## Arguments

- df:

  data frame with variables to pass to glm

- treatvar:

  vector representing treatment placement. Should be coded as 0s (for
  control) and 1s (for treatment).

- formula:

  formula for logistic regression model

- nsteps:

  number of steps to estimate from 1:1 to using all control records.

- nboot:

  number of models to execute for each step.

- samples:

  the sample sizes to draw from control group for each step.

- type:

  either logistic for Logistic regression (using `glm` function) or
  ctree for Conditional Inference Trees (using the `ctree` function).

- ...:

  other parameters passed to glm.

## Value

a class of psrange that contains a summary data frame, a details data
frame, and a list of each individual result from glm.

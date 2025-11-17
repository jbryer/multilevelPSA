# Estimate covariate effect sizes before and after propensity score adjustment.

Estimate covariate effect sizes before and after propensity score
adjustment.

## Usage

``` r
covariate.balance(covariates, treatment, level2, strata, abs = TRUE)
```

## Arguments

- covariates:

  frame or matrix of covariates.

- treatment:

  vector of treatment indicators.

- level2:

  vector indicating level 2 membership.

- strata:

  strata indicators.

- abs:

  if TRUE absolute values of effect sizes will be plotted.

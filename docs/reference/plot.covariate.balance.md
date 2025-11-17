# Multiple covariate balance assessment plot.

A graphic based upon \[cv.bal.psa()\] function in the \`PSAgraphics\`
package. This graphic plots the effect sizes for multiple covariates
before and after propensity score adjustement.

## Usage

``` r
# S3 method for class 'covariate.balance'
plot(
  x,
  plot.strata = FALSE,
  order = c("unadjusted", "adjusted"),
  strata.size = 3,
  strata.legend.guide = "none",
  point.size = 3,
  point.alpha = 1,
  line.color = "black",
  line.alpha = 0.2,
  legend.position = c(0.8, 0.2),
  ...
)
```

## Arguments

- x:

  results of \[covariate.balance()\].

- plot.strata:

  whether individual strata should be plotted.

- order:

  how to order the y-axis. Possible values are adjusted, unadjusted, or
  NULL (don't reorder).

- strata.size:

  text size for strata if plotted.

- strata.legend.guide:

  guide for legend placement for strata.

- point.size:

  size of the overall effect size points.

- point.alpha:

  transparency level of the overall effect size points.

- line.color:

  the color of the line connecting the overall effect size points.

- line.alpha:

  transparency level of the line connecting the overall effect size
  points.

- legend.position:

  where to position the legend.

- ...:

  currently unused.

## Value

a ggplot2 with an attribute, `effects`, that is the data frame used to
create the plot.

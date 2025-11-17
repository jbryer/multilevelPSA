# Loess plot with density distributions for propensity scores and outcomes on top and right, respectively.

Loess plot with density distributions for propensity scores and outcomes
on top and right, respectively.

## Usage

``` r
loess.plot(
  x,
  response,
  treatment,
  responseTitle = "",
  treatmentTitle = "Treatment",
  percentPoints.treat = 0.1,
  percentPoints.control = 0.01,
  points.treat.alpha = 0.1,
  points.control.alpha = 0.1,
  plot.strata,
  plot.strata.alpha = 0.2,
  ...
)
```

## Arguments

- x:

  vector of propensity scores.

- response:

  the response variable.

- treatment:

  the treatment variable as a logical type.

- responseTitle:

  the label to use for the y-axis (i.e. the name of the response
  variable)

- treatmentTitle:

  the label to use for the treatment legend.

- percentPoints.treat:

  the percentage of treatment points to randomly plot.

- percentPoints.control:

  the percentage of control points to randomly plot.

- points.treat.alpha:

  the transparency level for treatment points.

- points.control.alpha:

  the transparency level for control points.

- plot.strata:

  an integer value greater than 2 indicating the number of vertical
  lines to plot corresponding to quantiles.

- plot.strata.alpha:

  the alpha level for the vertical lines.

- ...:

  other parameters passed to \[ggplot2::geom_smooth()\] and
  \[ggplot2::stat_smooth()\].

## Value

a ggplot2 figure

## See also

plot.mlpsa

## Examples

``` r
if (FALSE) { # \dontrun{
require(multilevelPSA)
require(party)
data(pisana)
data(pisa.psa.cols)
cnt = 'USA' #Can change this to USA, MEX, or CAN
pisana2 = pisana[pisana$CNT == cnt,]
pisana2$treat <- as.integer(pisana2$PUBPRIV) %% 2
lr.results <- glm(treat ~ ., data=pisana2[,c('treat',pisa.psa.cols)], family='binomial')
st = data.frame(ps=fitted(lr.results), 
        math=apply(pisana2[,paste('PV', 1:5, 'MATH', sep='')], 1, mean), 
        pubpriv=pisana2$treat)
        st$treat = as.logical(st$pubpriv)
loess.plot(st$ps, response=st$math, treatment=st$treat, percentPoints.control = 0.4, 
           percentPoints.treat=0.4)
} # }
```

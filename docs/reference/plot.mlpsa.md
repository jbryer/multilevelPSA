# Plots the results of a multilevel propensity score model.

The plot created uses the `ggplot2` framework. As such, additional
modifications can be made. This plot is an extension of the `circ.psa`
function in the `PSAgraphics` package for multilevel models.

## Usage

``` r
# S3 method for class 'mlpsa'
plot(x, ratio = c(1, 2), plotExtra = NULL, ...)
```

## Arguments

- x:

  the results of \[mlspa()\].

- ratio:

  the ratio of the size of the distribution plots (left and bottom) to
  the circular plot.

- plotExtra:

  a plot to place in the lower left corner.

- ...:

  parameters passed to \[mlpsa.circ.plot()\] and
  \[mlpsa.distribution.plot()\]

## Examples

``` r
if (FALSE) { # \dontrun{
require(multilevelPSA)
require(party)
data(pisana)
data(pisa.colnames)
data(pisa.psa.cols)
mlctree = mlpsa.ctree(pisana[,c('CNT','PUBPRIV',pisa.psa.cols)], formula=PUBPRIV ~ ., level2='CNT')
student.party = getStrata(mlctree, pisana, level2='CNT')
student.party$mathscore = apply(student.party[,paste0('PV', 1:5, 'MATH')], 1, sum) / 5
results.psa.math = mlpsa(response=student.party$mathscore, 
       treatment=student.party$PUBPRIV, 
       strata=student.party$strata, 
       level2=student.party$CNT, minN=5)
plot(results.psa.math)
} # }
```

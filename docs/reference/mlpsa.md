# This function will perform phase II of the multilevel propensity score analysis.

The ci.adjust provides a Bonferroni-Sidak adjusted confidence intervals
based on the number of levels/clusters.

## Usage

``` r
mlpsa(
  response,
  treatment = NULL,
  strata = NULL,
  level2 = NULL,
  minN = 5,
  reverse = FALSE,
  ci.level = 0.05
)
```

## Arguments

- response:

  vector containing the response values

- treatment:

  vector containing the treatment conditions

- strata:

  vector containing the strata for each response

- level2:

  vector containing the level 2 specifications

- minN:

  the minimum number of subjects per strata for that strata to be
  included in the analysis.

- reverse:

  reverse the order of treatment and control for the difference
  calculation.

- ci.level:

  the confidence level to use for confidence intervals. Defaults to a
  95% confidence level.

## Value

a mlpsa class

## See also

\[mlpsa.ctree()\], \[mlpsa.logistic()\]

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
results.psa.math
summary(results.psa.math)
} # }
```

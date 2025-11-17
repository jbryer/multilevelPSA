# Heat map representing variables used in a conditional inference tree across level 2 variables.

This figure provides a summary of the covariates used within each level
two cluster along with their relative importance. Covariates are listed
on the y-axis and level two clusters along the x-axis. Cells that are
shaded indicate that that covariate was present in the conditional. The
shade of the color represents the highest level within the tree that
covariate appeared. That is, the darkest color, or depth 1, corresponds
to the covariate used at the root of the tree, or the first split.

## Usage

``` r
tree.plot(
  x,
  colNames,
  level2Col,
  colLabels = NULL,
  color.high = "azure",
  color.low = "steelblue",
  color.na = "white",
  ...
)
```

## Arguments

- x:

  the results of \[mlpsa.ctree()\]

- colNames:

  the columns to include in the graphic

- level2Col:

  the name of the level 2 column.

- colLabels:

  column labels to use. This is a data frame with two columns, the first
  column should match the values in `trees` and the second column the
  description that will be used for labeling the variables.

- color.high:

  color for variables with less relative importance as determined by
  occurring later in the tree (further from the root split).

- color.low:

  color for variables with greater relative importance as determined by
  occurring sooner in the tree (closer to the root split).

- color.na:

  color for variables that do not occur in the tree.

- ...:

  currently unused.

## Value

a ggplot2 expression

## See also

plot.mlpsa

## Examples

``` r
if (FALSE) { # \dontrun{
require(party)
data(pisana)
data(pisa.colnames)
data(pisa.psa.cols)
mlctree = mlpsa.ctree(pisana[,c('CNT','PUBPRIV',pisa.psa.cols)], formula=PUBPRIV ~ ., level2='CNT')
student.party = getStrata(mlctree, pisana, level2='CNT')
tree.plot(mlctree, level2Col=pisana$CNT)
} # }
```

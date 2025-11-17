# Estimates propensity scores using the recursive partitioning in a conditional inference framework.

This function will estimate propensity scores using the conditional
inference framework as outlined in the `party` package. Specifically, a
separate tree will be estimated for each level 2 (or cluster). A key
advantage of this framework over other methods for estimating propensity
scores is that this method will work on data sets containing missing
values.

## Usage

``` r
mlpsa.ctree(vars, formula, level2, ...)
```

## Arguments

- vars:

  a data frame containing the covariates to use for estimating the
  propensity scores.

- formula:

  the model for estimating the propensity scores. For example, treat ~ .

- level2:

  the name of the column in `vars` specifying the level 2 (or cluster).

- ...:

  currently unused.

## Value

a list of BinaryTree-class classes for each level 2

## References

Torsten Hothorn, Kurt Hornik and Achim Zeileis (2006). Unbiased
Recursive Partitioning: A Conditional Inference Framework. Journal of
Computational and Graphical Statistics, 15(3), 651–674.

## See also

\[getStrata()\]

\[tree.plot()\]

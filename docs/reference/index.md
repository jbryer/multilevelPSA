# Package index

## All functions

- [`align(`*`<plots>`*`)`](align.plots.md) : Adapted from ggExtra
  package which is no longer available. This is related to an
  experimental mlpsa plot that will combine the circular plot along with
  the two individual distributions.

- [`as.data.frame(`*`<covariate.balance>`*`)`](as.data.frame.covariate.balance.md)
  : Returns the overall effects as a data frame.

- [`covariate.balance()`](covariate.balance.md) : Estimate covariate
  effect sizes before and after propensity score adjustment.

- [`covariateBalance()`](covariateBalance.md) : Calculate covariate
  effect size differences before and after stratification.

- [`cv.trans.psa()`](cv.trans.psa.md) : Transformation of Factors to
  Individual Levels

- [`difftable.plot()`](difftable.plot.md) : This function produces a
  ggplot2 figure containing the mean differences for each level two, or
  cluster.

- [`getPropensityScores()`](getPropensityScores.md) : Returns a data
  frame with two columns corresponding to the level 2 variable and the
  fitted value from the logistic regression.

- [`getStrata()`](getStrata.md) : Returns a data frame with two columns
  corresponding to the level 2 variable and the leaves from the
  conditional inference trees.

- [`is.mlpsa()`](is.mlpsa.md) :

  Returns true if the object is of type `mlpsa`

- [`loess.plot()`](loess.plot.md) : Loess plot with density
  distributions for propensity scores and outcomes on top and right,
  respectively.

- [`lsos()`](lsos.md) : Nicer list of objects in memory. Particularly
  useful for analysis of large data.
  https://stackoverflow.com/questions/1358003/tricks-to-manage-the-available-memory-in-an-r-session

- [`missing.plot()`](missing.plot.md) : Returns a heat map graphic
  representing missingness of variables grouped by the given grouping
  vector.

- [`mlpsa()`](mlpsa.md) : This function will perform phase II of the
  multilevel propensity score analysis.

- [`mlpsa.circ.plot()`](mlpsa.circ.plot.md) : Plots the results of a
  multilevel propensity score model.

- [`mlpsa.ctree()`](mlpsa.ctree.md) : Estimates propensity scores using
  the recursive partitioning in a conditional inference framework.

- [`mlpsa.difference.plot()`](mlpsa.difference.plot.md) : Creates a
  graphic summarizing the differences between treatment and comparison
  groups within and across level two clusters.

- [`mlpsa.distribution.plot()`](mlpsa.distribution.plot.md) : Plots
  distribution for either the treatment or comparison group.

- [`mlpsa.logistic()`](mlpsa.logistic.md) : Estimates propensity scores
  using logistic regression.

- [`multilevelPSA-package`](multilevelPSA-package.md)
  [`multilevelPSA`](multilevelPSA-package.md) : Multilevel Propensity
  Score Analysis

- [`pisa.colnames`](pisa.colnames.md) : Mapping of variables in
  \`pisana\` with full descriptions.

- [`pisa.countries`](pisa.countries.md) : Data frame mapping PISA
  countries to their three letter abbreviation.

- [`pisa.psa.cols`](pisa.psa.cols.md) : Character vector representing
  the list of covariates used for estimating propensity scores.

- [`pisana`](pisana.md) : North American (i.e. Canada, Mexico, and
  United States) student results of the 2009 Programme of International
  Student Assessment.

- [`plot(`*`<covariate.balance>`*`)`](plot.covariate.balance.md) :
  Multiple covariate balance assessment plot.

- [`plot(`*`<mlpsa>`*`)`](plot.mlpsa.md) : Plots the results of a
  multilevel propensity score model.

- [`plot(`*`<psrange>`*`)`](plot.psrange.md) : Plots densities and
  ranges for the propensity scores.

- [`print(`*`<covariate.balance>`*`)`](print.covariate.balance.md) :
  Prints the overall effects before and after propensity score
  adjustment.

- [`print(`*`<mlpsa>`*`)`](print.mlpsa.md) :

  Prints basic information about a `mlpsa` class.

- [`print(`*`<psrange>`*`)`](print.psrange.md) : Prints information
  about a psrange result.

- [`print(`*`<xmlpsa>`*`)`](print.xmlpsa.md) : Prints the results of
  \[mlpsa()\] and \[xtable.mlpsa()\].

- [`psrange()`](psrange.md) : Estimates models with increasing number of
  comparison subjects starting from 1:1 to using all available
  comparison group subjects.

- [`summary(`*`<mlpsa>`*`)`](summary.mlpsa.md) :

  Provides a summary of a `mlpsa` class.

- [`summary(`*`<psrange>`*`)`](summary.psrange.md) : Prints the summary
  results of psrange.

- [`tree.plot()`](tree.plot.md) : Heat map representing variables used
  in a conditional inference tree across level 2 variables.

- [`xtable(`*`<mlpsa>`*`)`](xtable.mlpsa.md) : Prints the results of
  \[mlpsa()\] as a LaTeX table.

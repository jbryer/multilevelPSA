multilevelPSA 1.2.6
=========

* Updated documentation to address CRAN notes.
* Updated citation file.
* Added vignette.

multilevelPSA 1.2.5
=========

* Fixed a bug where a ggplot2 parameter was matched by more than one pass through parameter.

multilevelPSA 1.2.4
=========

* Update for new version of ggplot2.

multilevelPSA 1.2.3
=========

* Will use brewer color scheme with 8 or fewer levels.
* Update for new version of xtable package.

multilevelPSA 1.2.2
=========

* Added The ci.adjust paramter to the mlpsa function to specify the confidence level (default is 0.05).
* Added Bonferroni-Sidak adjusted confidence intervals based on the number of levels/clusters to what is returned in by the mlpsa package in the diff.wtd data frame. The mlpsa.difference.plot function will plot these confidence intervals in a dashed green line
* Changed how factors are dummy coded in the balance functions to decrease
  execution time.
* Updated psranges to add support for classification trees (using ctree in party
  package).
* Updated for the newest version of roxygen2
* Various updates for CRAN check

multilevelPSA 1.2.1
=========

* Fixed position of overall difference for level 2 on the left margin if strata
  were much smaller than the overall difference.
* Added xlim parameter to the mlpsa.diff.plot function.
* Removed a duplicated column in the pisana data frame.

multilevelPSA 1.2
=========

* Added covariate.balance and corresponding plot function to visualize covariate 
  effect sizes before and after propensity score adjustment.
* The getPropensityScore method will also return strata. The number of strata is
  configurable through a function parameter.
* Added parameters to loess.plot to control the number of points to plot (as a sampling percentage) 
  as well as the transparency level.
* Added reverse parameter to mlpsa to control the order of the difference calculation
  so that control is subtracted from treatment. Under certain codings, the defaul
  may end up subtracting treatment from control. The plotting functions are also
  updated to reflect this change.
* Changed minimum R requirement to 3.0 since some dependent packages require 3.0 (e.g. ggplot2).
* Updates for compatibility with ggplot 0.9.
* Fixed bug where the mlpsa.distribution.plot, and by extension the plot.mlpsa function,
  would fail if the treatment/control columns were named TRUE/FALSE.
* Added a plot.strata parameter to loess.plot that will optionally draw vertical
  lines indicating strata.

multilevelPSA 1.1
=========

* Updated pisa demo for use with the full PISA dataset using the pisa package available
  at http://github.com/jbryer/pisa.
* Added pisa.countries data frame.
* Can now pass parameters through to geom_smooth and stat_smooth from loess.plot.
* Fixed CITATION file to include text version.

multilevelPSA 1.0
=========

* Initial version of the multilevelPSA package release on February 13, 2013.
* Project is hosted on Github. More information at http://jbryer.github.com/multilevelPSA.

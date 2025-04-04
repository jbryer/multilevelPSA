#' This packages provides functions to estimate and visualize multilevel propensity
#' score analysis.
#' 
#' This package extends the principles put forth by the \code{PSAgraphics} 
#' (Helmreich, Pruzek, & Xiong, 2010) for multilevel, or clustered, data.
#'
#' Propensity score analyses are typically done in two phases. In phase I, a
#' statistical model predicting treatment using the available individual covariates 
#' is estimated. This package currently currently provides functions to perform
#' propensity score estimates using logistic regression (see [mlpsa.logistic()])
#' and conditional inference trees (see [mlpsa.ctree()]). The latter method
#' provides explicit stratifications as defined by each leaf node. The former however,
#' results in a numerical value ranging from zero to one (i.e. the fitted values).
#' A common approach is to then create stratifications using quintiles. However,
#' other approaches such as Loess regression are also provided.
#'
#' Phase II of typical propensity score analyses concerns with the comparison of an
#' outcome between the treatment and comparison groups. The [mlpsa()]
#' method will perform this analysis in a multilevel, or clustered, fashion. That
#' is, the results of the [mlpsa()] procedure produce summary results
#' at level one (i.e. each strata within each cluster), level two (i.e. overall results
#' for each cluster), and overall (i.e. overall results across all clusters).
#'
#' This package also provides a number of visualizations that provide a critical
#' part in presenting, understanding, and interpreting the results. See
#' [plot.mlpsa()] for details.
#' 
#' @name multilevelPSA-package
#' @aliases multilevelPSA
#' @title Multilevel Propensity Score Analysis
#' @references [https://cran.r-project.org/package=PSAgraphics](https://www.oecd.org/en/about/programmes/pisa.html)
#' 		[https://www.jstatsoft.org/article/view/v029i06](https://www.jstatsoft.org/article/view/v029i06)
#' @keywords propensity score analysis psa multilevel graphics
#' @seealso \code{PSAgraphics}
#' @import plyr
#' @import PSAgraphics
#' @import ggplot2
#' @import party
#' @importFrom grid grob gTree editGrob vpPath viewport vpTree grid.layout 
#'                  getGrob grobWidth grobHeight unit.c pushViewport grid.draw
#'                  upViewport grid.newpage
#' @importFrom reshape melt cast melt.data.frame
#' @importFrom psych describeBy
#' @importFrom MASS stepAIC
#' @importFrom stats binomial density fitted glm median model.matrix na.omit qt quantile sd var
#' @importFrom utils capture.output object.size setTxtProgressBar txtProgressBar
"_PACKAGE"

#' North American (i.e. Canada, Mexico, and United States) student results of the 2009
#' Programme of International Student Assessment.
#'
#' Student results from the 2009 Programme of International Student Assessment (PISA)
#' as provided by the Organization for Economic Co-operation and Development (OECD).
#' See [https://www.oecd.org/en/about/programmes/pisa.html/](https://www.oecd.org/en/about/programmes/pisa.html/)
#' for more information including the code book.
#'
#' Note that missing values have been imputed using the 
#' [mice](https://cran.r-project.org/package=mice) package.
#' Details on the specific procedure are in the `pisa.impute` function
#' in the [pisa](https://github.com/jbryer/pisa) package.
#' 
#' @references Organization for Economic Co-operation and Development (2009).
#'             Programme for International Student Assessment (PISA). 
#'             [https://www.oecd.org/en/about/programmes/pisa.html](https://www.oecd.org/en/about/programmes/pisa.html)
#' @name pisana
#' @docType data
#' @format a data frame with 66,548 obvservations of 65 variables.
#' @source Organization for Economic Co-operation and Development
#' @keywords datasets
NULL

#' Mapping of variables in `pisana` with full descriptions.
#' 
#' This data frame provides three variables, `Variable` corresponding to the
#' column names in `pisana`, `ShortDesc` providing a short
#' description of the variable as a valid R object name, and `Desc` providing
#' a longer description of the variable.
#' 
#' @name pisa.colnames
#' @docType data
#' @format a data frame with 50 rows of 3 variables.
#' @keywords datasets
NULL

#' Character vector representing the list of covariates used for estimating
#' propensity scores.
#' 
#' @name pisa.psa.cols
#' @docType data
#' @format a character vector with covariate names for estimating propensity scores.
#' @keywords datasets
NULL

#' Data frame mapping PISA countries to their three letter abbreviation.
#' 
#' This data frame has two columns, \code{CNT3} for the three letter abbreviation
#' of each country and \code{Country} that provides the full country name in English.
#' 
#' @name pisa.countries
#' @docType data
#' @format data frame with 65 rows of 2 variables.
#' @keywords datasets
NULL

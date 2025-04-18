% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mlpsa.logistic.R
\name{mlpsa.logistic}
\alias{mlpsa.logistic}
\title{Estimates propensity scores using logistic regression.}
\usage{
mlpsa.logistic(vars, formula, level2, stepAIC = FALSE, ...)
}
\arguments{
\item{vars}{data frame containing the variables to estimate the logistic regression}

\item{formula}{the logistic regression formula to use}

\item{level2}{the name of the column containing the level 2 specification}

\item{stepAIC}{if true, the [MASS::stepAIC()] from the `MASS` package
will be used within each level.}

\item{...}{currently unused.}
}
\value{
a list of glm classes for each level 2 or stepwise-selected model if stepAIC is true.
}
\description{
This method will estimate a separate logistic regression model for each level 2
(or cluster).
}
\seealso{
getPropensityScores
}

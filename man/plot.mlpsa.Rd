\name{plot.mlpsa}
\alias{plot.mlpsa}
\title{Plots the results of a multilevel propensity score model.}
\usage{
  \method{plot}{mlpsa} (mlpsa, ratio = c(1, 2),
    plotExtra = NULL, ...)
}
\arguments{
  \item{mlpsa}{the results of \code{\link{mlpsa}}.}

  \item{ratio}{the ratio of the size of the distribution
  plots (left and bottom) to the circular plot.}

  \item{plotExtra}{a plot to place in the lower left
  corner.}

  \item{...}{parameters passed to
  \code{\link{plot.mlpsa.circ}}.}
}
\description{
  The plot created uses the \code{ggplot2} framework. As
  such, additional modificaitons can be made. This plot is
  an extension of the \code{circ.psa} function in the
  \code{PSAgraphics} package for multilevel models.
}


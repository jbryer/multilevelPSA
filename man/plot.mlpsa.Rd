\name{plot.mlpsa}
\alias{plot.mlpsa}
\title{Plots the results of a multilevel propensity score model.}
\usage{
  \method{plot}{mlpsa} (multilevelPSA,
    xlab = names(multilevelPSA$level2.summary)[4],
    ylab = names(multilevelPSA$level2.summary)[5],
    legendlab = "Level 2", title = NULL,
    overall.col = "blue", overall.ci.col = "green",
    level1.plot = FALSE, level1.point.size = NULL,
    level1.rug.plot = NULL,
    level1.projection.lines = FALSE, level2.plot = TRUE,
    level2.point.size = NULL,
    level2.rug.plot = geom_rug_alt,
    level2.projection.lines = TRUE, level2.label = FALSE,
    unweighted.means = FALSE, weighted.means = FALSE,
    fill.colours = NULL, ...)
}
\arguments{
  \item{multilevelPSA}{}
}
\description{
  The plot created uses the \code{ggplot2} framework. As
  such, additional modificaitons can be made. This plot is
  an extension of the \code{circ.psa} function in the
  \code{PSAgraphics} package for multilevel models.
}


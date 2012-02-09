\name{plot.mlpsa.circ}
\alias{plot.mlpsa.circ}
\title{Plots the results of a multilevel propensity score model.}
\usage{
  plot.mlpsa.circ(x,
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
  \item{x}{the results of \code{\link{mlpsa}}.}

  \item{xlab}{label for the x-axis.}

  \item{ylab}{label for the y-axis.}

  \item{legendlab}{the label for the legend, or NULL to
  exclude.}

  \item{title}{title for the figure.}

  \item{overall.col}{the color used for the overall
  results.}

  \item{overall.ci.col}{the color used for the confidence
  intervals.}

  \item{level1.plot}{logical value indicating whether level
  1 points should be plotted.}

  \item{level1.point.size}{the size of level 1 points}

  \item{level1.rug.plot}{the geom to use for plotting a
  level 1 rug. Possible values are geom_rug (for left and
  bottom), geom_rug_alt (for top and right), or NULL (to
  exclude).}

  \item{level1.projection.lines}{logical value indicating
  whether level 1 project lines (parallel to the unit line)
  are drawn.}

  \item{level2.plot}{logical value indicating whether level
  2 points should be plotted.}

  \item{level2.point.size}{the size of level 2 points}

  \item{level2.rug.plot}{the geom to use for plotting a
  level 2 rug. Possible values are geom_rug (for left and
  bottom), geom_rug_alt (for top and right), or NULL (to
  exclude).}

  \item{level2.projection.lines}{logical value indicating
  whether level 2 project lines (parallel to the unit line)
  are drawn.}

  \item{level2.label}{logical value indicating whether
  level 2 points should be labeled.}

  \item{unweighted.means}{logical value indicating whether
  horizontal and vertical lines are drawn representing the
  unweighted (i.e. unadjusted from phase I of PSA) means
  for each level 2, or cluster.}

  \item{weighted.means}{logical value indicating whether
  horizontal and vertical lines are drawn representing the
  weighted means for each level 2, or cluster.}

  \item{fill.colours}{if specified, the colors to use for
  level 2 points.}

  \item{...}{currently unused.}
}
\description{
  The plot created uses the \code{ggplot2} framework. As
  such, additional modificaitons can be made. This plot is
  an extension of the \code{circ.psa} function in the
  \code{PSAgraphics} package for multilevel models.
}


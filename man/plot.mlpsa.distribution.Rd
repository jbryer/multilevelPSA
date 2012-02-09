\name{plot.mlpsa.distribution}
\alias{plot.mlpsa.distribution}
\title{Plots distribution for either the treatment or comparison group.}
\usage{
  plot.mlpsa.distribution(x, treat, fill.colours = NULL,
    flip = TRUE, label = treat, level2.label = NULL,
    legendlab = NULL, ...)
}
\arguments{
  \item{x}{the results of \code{\link{mlpsa}}.}

  \item{treat}{the group to plot. This must be one of the
  two levels of the treatment variable.}

  \item{fill.colours}{if specified, the colors to use for
  level 2 points.}

  \item{flip}{if TRUE, the level 2 clusters will be on the
  y-axis and the outcome variable on the x-axis. Otherwise
  reversed.}

  \item{label}{the label to use for the axis.}

  \item{level2.label}{the axis label for the level 2
  indicators.}

  \item{legendlab}{the label for the legend, or NULL to
  exclude a legend.}

  \item{...}{currently unused.}
}
\description{
  Plots distribution for either the treatment or comparison
  group.
}


\name{plot.difftable}
\alias{plot.difftable}
\title{This function produces a ggplot2 figure contianing the mean differences for
each level two, or cluster.}
\usage{
  plot.difftable(multilevelPSA, fill.colours = NULL,
    legendlab = NULL, ...)
}
\arguments{
  \item{multilevelPSA}{the results of \code{\link{mlpsa}}.}

  \item{fill.colours}{the colours to use for each level
  two.}

  \item{legendlab}{the label to use for the legend, or NULL
  to exclude.}

  \item{...}{currently unused.}
}
\description{
  This function produces a ggplot2 figure contianing the
  mean differences for each level two, or cluster.
}


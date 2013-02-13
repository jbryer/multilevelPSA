\name{difftable.plot}
\alias{difftable.plot}
\title{This function produces a ggplot2 figure contianing the mean differences for
each level two, or cluster.}
\usage{
  difftable.plot(x, fill.colours = NULL, legendlab = NULL,
    ...)
}
\arguments{
  \item{x}{the results of \code{\link{mlpsa}}.}

  \item{fill.colours}{the colours to use for each level
  two.}

  \item{legendlab}{the label to use for the legend, or NULL
  to exclude.}

  \item{...}{currently unused.}
}
\value{
  a ggplot2 figure
}
\description{
  This function produces a ggplot2 figure contianing the
  mean differences for each level two, or cluster.
}


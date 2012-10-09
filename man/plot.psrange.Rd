\name{plot.psrange}
\alias{plot.psrange}
\title{Plots the results of psrange call with ggplot2 displaying the range of fitted
values (i.e. propensity scores).}
\usage{
  plot.psrange(x, xlab = "Percent of Control Group",
    ylab = paste("Propensity Score Range (ntreat = ", prettyNum(x$summary[1, "ntreat"], big.mark = ","), ")", sep = ""),
    ...)
}
\arguments{
  \item{x}{a psrange object}

  \item{xlab}{label for the x axis}

  \item{ylab}{label for the y axis}

  \item{...}{currently unused.}
}
\description{
  Plots the results of psrange call with ggplot2 displaying
  the range of fitted values (i.e. propensity scores).
}


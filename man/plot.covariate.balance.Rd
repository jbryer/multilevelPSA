\name{plot.covariate.balance}
\alias{plot.covariate.balance}
\title{Multiple covariate blance assessment plot.}
\usage{
  \method{plot}{covariate.balance} (x, grid = TRUE, ...)
}
\arguments{
  \item{x}{results of \code{\link{covariate.balance}}.}

  \item{grid}{should all the levels be plotted together
  (FALSE) or in a grid (TRUE).}

  \item{...}{currently unused.}
}
\value{
  a ggplot2 with an attribute, \code{effects}, that is the
  data frame used to create the plot.
}
\description{
  A graphic based upon \code{\link{cv.bal.psa}} function in
  the \code{PSAgraphics} package. This graphic plots the
  effect sizes for multiple covariated before and after
  propensity score andjustement.
}


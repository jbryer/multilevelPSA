\name{getPropensityScores}
\alias{getPropensityScores}
\title{Returns a data frame with two columns corresponding to the level 2 variable
and the fitted value from the logistic regression.}
\usage{
  getPropensityScores(lr.results)
}
\arguments{
  \item{lr.results}{the results of
  \code{\link{mlpsa.logistic}}}
}
\value{
  a data frame
}
\description{
  Returns a data frame with two columns corresponding to
  the level 2 variable and the fitted value from the
  logistic regression.
}
\seealso{
  mlpsa.logistic
}


\name{mlpsa.logistic}
\alias{mlpsa.logistic}
\title{Performs a logistic regression analysis for each level 2.}
\usage{
  mlpsa.logistic(vars, formula, level2, stepAIC = FALSE,
    ...)
}
\arguments{
  \item{vars}{data frame containing the variables to
  estimate the logistic regression}

  \item{formula}{the logistic regression formula to use}

  \item{level2}{the name of the column containing the level
  2 specification}

  \item{stepAIC}{if true, stepAIC will be called for each
  level.}
}
\value{
  a list of glm classes for each level 2 or
  stepwise-selected model if stepAIC is true.
}
\description{
  TODO: Need more details
}


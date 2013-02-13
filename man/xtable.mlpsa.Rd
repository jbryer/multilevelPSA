\name{xtable.mlpsa}
\alias{xtable.mlpsa}
\title{Prints the results of \code{\link{mlpsa}} as a LaTeX table.}
\usage{
  \method{xtable}{mlpsa} (x, caption, label, align,
    digits = 2, display, include.note = TRUE, ...)
}
\arguments{
  \item{x}{results of \code{\link{mlpsa}}}

  \item{digits}{number of digits to print.}

  \item{include.note}{include a table note indicating how
  many rows were removed due to insufficient data within a
  strata.}

  \item{caption}{passed through to \code{\link{xtable}}.}

  \item{label}{passed through to \code{\link{xtable}}.}

  \item{align}{Not used.}

  \item{display}{passed through to \code{\link{xtable}}.}

  \item{...}{other parameters passed to
  \code{\link{summary.mlpsa}}}
}
\description{
  This function implements the \code{\link{xtable}} method
  for \code{\link{mlpsa}}.
}


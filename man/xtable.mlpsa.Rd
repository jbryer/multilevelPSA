% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xtable.mlpsa.r
\name{xtable.mlpsa}
\alias{xtable.mlpsa}
\title{Prints the results of [mlpsa()] as a LaTeX table.}
\usage{
\method{xtable}{mlpsa}(
  x,
  caption,
  label,
  align,
  digits = 2,
  display = NULL,
  auto = FALSE,
  include.note = TRUE,
  ...
)
}
\arguments{
\item{x}{results of [mlpsa()]}

\item{caption}{passed through to [xtable::xtable()].}

\item{label}{passed through to [xtable::xtable()].}

\item{align}{Not used.}

\item{digits}{number of digits to print.}

\item{display}{passed through to [xtable::xtable()].}

\item{auto}{passed through to [xtable::xtable()].}

\item{include.note}{include a table note indicating how many rows were removed
due to insufficient data within a strata.}

\item{...}{other parameters passed to [summary.mlpsa()]}
}
\description{
This function implements the [xtable::xtable()] method for [mlpsa()].
}

\name{plot.missing}
\alias{plot.missing}
\title{Returns a heat map graphic representing missinging of variables grouped by
the given grouping vector.}
\usage{
  plot.missing(vars, grouping, grid = FALSE)
}
\arguments{
  \item{vars}{a data frame containing the variables to
  visualize missingness}

  \item{grouping}{a vector of length nrow(vars)
  corresponding to how missing will be grouped by}

  \item{grid}{whether to draw a grid between tiles}
}
\value{
  a ggplot2 expression
}
\description{
  Returns a heat map graphic representing missinging of
  variables grouped by the given grouping vector.
}


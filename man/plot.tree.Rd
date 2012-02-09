\name{plot.tree}
\alias{plot.tree}
\title{Heat map representing variables used in a conditional inference tree across level 2 variables.}
\usage{
  plot.tree(trees, colNames, level2Col, colLabels = NULL,
    ...)
}
\arguments{
  \item{trees}{the results of \code{\link{mlpsa.ctree}}}

  \item{colNames}{the columns to include in the graphic}

  \item{level2Col}{the name of the level 2 column.}

  \item{colLabels}{column labels to use. This is a data
  frame with two columns, the first column should match the
  values in \code{trees} and the second column the
  description that will be used for labeling the
  variables.}

  \item{...}{currently unused.}
}
\value{
  a ggplot2 expression
}
\description{
  Heat map representing variables used in a conditional
  inference tree across level 2 variables.
}


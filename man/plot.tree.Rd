\name{plot.tree}
\alias{plot.tree}
\title{Heat map representing variables used in a conditional inference tree across level 2 variables.}
\usage{
  plot.tree(x, colNames, level2Col, colLabels = NULL,
    color.high = "azure", color.low = "steelblue",
    color.na = "white", ...)
}
\arguments{
  \item{x}{the results of \code{\link{mlpsa.ctree}}}

  \item{colNames}{the columns to include in the graphic}

  \item{level2Col}{the name of the level 2 column.}

  \item{colLabels}{column labels to use. This is a data
  frame with two columns, the first column should match the
  values in \code{trees} and the second column the
  description that will be used for labeling the
  variables.}

  \item{color.low}{color for variables with greater
  relative importance as determined by occurring sooner in
  the tree (closer to the root split).}

  \item{color.high}{color for variables with less relative
  importance as determined by occurring later in the tree
  (further from the root split).}

  \item{color.na}{color for variables that do not occur in
  the tree.}

  \item{...}{currently unused.}
}
\value{
  a ggplot2 expression
}
\description{
  This figure provides a summary of the covariates used
  within each level two cluster along with their relative
  importance. Covariates are listed on the y-axis and level
  two clusters along the x-axis. Cells that are shaded
  indicate that that covariate was present in the
  conditional. The shade of the color represents the
  highest level witin the tree that covariate appeared.
  That is, the darkest color, or depth 1, corresponds to
  the covariate used at the root of the tree, or the first
  split.
}


\name{plot.loess}
\alias{plot.loess}
\title{Loess plot with density distributions for propensity scores and outcomes on
top and right, respectively.}
\usage{
  plot(x)
}
\arguments{
  \item{x}{vector of propensity scores.}

  \item{response}{the response variable.}

  \item{treatment}{the treatment varaible as a logical
  type.}

  \item{percentPoints.treat}{the percentage of treatment
  points to randomly plot.}

  \item{percentPoints.control}{the percentage of control
  points to randomly plot.}

  \item{responseTitle}{the label to use for the y-axis
  (i.e. the name of the response variable)}

  \item{treatmentTitle}{the label to use for the treatment
  legend.}
}
\value{
  a ggplot2 figure
}
\description{
  Loess plot with density distributions for propensity
  scores and outcomes on top and right, respectively.
}
\seealso{
  plot.mlpsa
}


\name{plot.loess}
\alias{plot.loess}
\title{Loess plot with density distributions for propensity scores and outcomes on
top and right, respectively.}
\usage{
  plot.loess(ps, response, treatment, responseTitle = "",
    treatmentTitle = "Treatment",
    percentPoints.treat = 0.1,
    percentPoints.control = 0.01)
}
\arguments{
  \item{ps}{vector of propensity scores.}

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


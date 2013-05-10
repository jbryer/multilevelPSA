\name{plot.psrange}
\alias{plot.psrange}
\title{Plots densities and ranges for the propensity scores.}
\usage{
  \method{plot}{psrange} (x, xlab = NULL, ylab = NULL,
    labels = c("Comparison", "Treatment"),
    text.ratio.size = 4, text.ncontrol.size = 3,
    point.size = 1, point.alpha = 0.6, line.width = 6,
    density.alpha = 0.2, rect.color = "green",
    rect.alpha = 0.2, ...)
}
\arguments{
  \item{x}{the result of psrange.}

  \item{xlab}{label for x-axis.}

  \item{ylab}{label for y-axis.}

  \item{labels}{labels for the comparison and treatment
  legend.}

  \item{text.ratio.size}{size of the text for the ratio.}

  \item{text.ncontrol.size}{size of the text for the number
  of control units.}

  \item{point.size}{size of the points for the minimum and
  maximum ranges for each model.}

  \item{point.alpha}{the alpha (transparency) level for the
  points.}

  \item{line.width}{the width of the line between the
  median of the minimum and maximum ranges.}

  \item{density.alpha}{the alpha (transparency) level of
  the density curves.}

  \item{rect.color}{the color of the rectangle surrounding
  the range of minimum and maximum ranges.}

  \item{rect.alpha}{the alpha (transparency) level of the
  rectangle.}

  \item{...}{currently unused.}
}
\value{
  a ggplot2 object
}
\description{
  Plots densities and ranges for the propensity scores.
}


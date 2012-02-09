\name{plot.mlpsa.difference}
\alias{plot.mlpsa.difference}
\title{Creates a graphic summarizing the differences between treatment and comparison
groups within and across level two clusters.}
\usage{
  plot.mlpsa.difference(multilevelPSA,
    xlab = "Difference Score", ylab = NULL, title = NULL,
    overall.col = "blue", overall.ci.col = "green",
    level2.point.size = NULL, level1.points = TRUE,
    errorbars = TRUE, level2.rug.plot = TRUE,
    jitter = TRUE, reorder = TRUE, labelLevel2 = TRUE,
    sd = NULL, ...)
}
\arguments{
  \item{multilevelPSA}{the results of \code{\link{mlpsa}}.}

  \item{xlab}{label for the x-axis, or NULL to exclude.}

  \item{ylab}{label for the y-aixs, or NULL to exclude.}

  \item{title}{title of the figure, or NULL to exclude.}

  \item{overall.col}{the color of the overall results
  line.}

  \item{overall.ci.col}{the color of the overall confidence
  interval.}

  \item{level2.point.size}{the point size of level 2
  points.}

  \item{level1.points}{logical value indicating whether
  level 1 strata should be plotted.}

  \item{errorbars}{logical value indicating whether error
  bars should be plotted for for each level 1.}

  \item{level2.rug.plot}{logical value indicating whether a
  rug plot should be plotted for level 2.}

  \item{jitter}{logical value indicating whether level 1
  points should be jittered.}

  \item{reorder}{logical value indicating whether the level
  two clusters should be reordered from largest difference
  to smallest.}

  \item{labelLevel2}{logical value indicating whether the
  difference for each level 2 should be labeled.}

  \item{sd}{If specified, effect sizes will be plotted
  instead of difference in the native unit.}

  \item{...}{currently unused.}
}
\description{
  Creates a graphic summarizing the differences between
  treatment and comparison groups within and across level
  two clusters.
}


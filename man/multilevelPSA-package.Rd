\docType{package}
\name{multilevelPSA-package}
\alias{multilevelPSA}
\alias{multilevelPSA-package}
\title{Multilevel Propensity Score Analysis}
\description{
  This packages provides functions to estimate and
  visualize multilvel propensity score analysis.
}
\details{
  This package extends the principles put forth by the
  \code{PSAgraphics} (Helmreich, Pruzek, & Xiong, 2010) for
  multilevel, or clustered, data.

  Propensity score analyses are typically done in two
  phases. In phase I, a statistical model prediciting
  treatment using the available individual covaraites is
  estimated. This package currently currently provides
  functions to perform propensity score estimates using
  logistic regression (see \code{\link{mlpsa.logistic}})
  and conditional inference trees (see
  \code{\link{mlpsa.ctree}}). The latter method provides
  explicit stratifications as defined by each leaf node.
  The former however, results in a numerical value ranging
  from zero to one (i.e. the fitted values). A common
  approach is to then create stratificaitons using
  quintiles. However, other approaches such as Loess
  regression are also provided.

  Phase II of typical pronsity score analyses concerns with
  the comparison of an outcome between the treatment and
  comparison groups. The \code{\link{mlpsa}} method will
  perform this analysis in a multilevel, or clustered,
  fashion. That is, the results of the \code{\link{mlpsa}}
  procedure produce summary results at level one (i.e. each
  strata within each cluster), level two (i.e. overall
  results for each cluster), and overall (i.e. overall
  results across all clusters).

  This package also provides a number of visualizaions that
  provide a critical part in presenting, understanding, and
  interpreting the results. See \code{\link{plot.mlpsa}}
  for details.
}
\author{
  Jason Bryer \email{jason@bryer.org}
}
\references{
  \url{http://cran.r-project.org/web/packages/PSAgraphics/PSAgraphics.pdf}
  \url{http://www.jstatsoft.org/v29/i06/}
}
\seealso{
  \code{PSAgraphics}
}
\keyword{analysis}
\keyword{graphics}
\keyword{multilevel}
\keyword{propensity}
\keyword{psa}
\keyword{score}


\name{loess.plot}
\alias{loess.plot}
\title{Loess plot with density distributions for propensity scores and outcomes on
top and right, respectively.}
\usage{
  loess.plot(x, response, treatment, responseTitle = "",
    treatmentTitle = "Treatment",
    percentPoints.treat = 0.1,
    percentPoints.control = 0.01, ...)
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

  \item{...}{other parameters passed to
  \code{\link{geom_smooth}} and \code{\link{stat_smooth}}.}
}
\value{
  a ggplot2 figure
}
\description{
  Loess plot with density distributions for propensity
  scores and outcomes on top and right, respectively.
}
\examples{
\dontrun{
require(multilevelPSA)
require(party)
data(pisana)
data(pisa.psa.cols)
cnt = 'USA' #Can change this to USA, MEX, or CAN
pisana2 = pisana[pisana$CNT == cnt,]
pisana2$treat <- as.integer(pisana2$PUBPRIV) \%\% 2
lr.results <- glm(treat ~ ., data=pisana2[,c('treat',pisa.psa.cols)], family='binomial')
st = data.frame(ps=fitted(lr.results),
				math=apply(pisana2[,paste('PV', 1:5, 'MATH', sep='')], 1, mean),
				pubpriv=pisana2$treat)
				st$treat = as.logical(st$pubpriv)
loess.plot(st$ps, response=st$math, treatment=st$treat, percentPoints.control = 0.4,
           percentPoints.treat=0.4)
}
}
\seealso{
  plot.mlpsa
}


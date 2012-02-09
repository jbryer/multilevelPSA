\name{mlpsa}
\alias{mlpsa}
\title{This function will perform phase II of the multilevel propensity score analysis.}
\usage{
  mlpsa(response, treatment = NULL, strata = NULL,
    level2 = NULL, minN = 1)
}
\arguments{
  \item{response}{vector containing the response values}

  \item{treatment}{vector containing the treatment
  conditions}

  \item{strata}{vector containing the strata for each
  response}

  \item{level2}{vector containing the level 2
  specifications}

  \item{minN}{the minimum number of subjects per strata for
  that strata to be included in the analysis.}
}
\value{
  a mlpsa class
}
\description{
  TODO: Need more details
}
\examples{
\dontrun{party.results = multilevelCtree(student[,c(1,5:48,68)], formula=PUBPRIV ~ ., level2='CNT')}
}
\seealso{
  \code{\link{mlpsa.ctree}} \code{\link{mlpsa.logistic}}
}


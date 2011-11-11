\name{multilevelPSA}
\alias{multilevelPSA}
\title{This function will calculate the multilevel propensity score analysis.}
\usage{
  multilevelPSA(response, treatment = NULL, strata = NULL,
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
  a multilevel.psa class
}
\description{
  TODO: Need more details
}


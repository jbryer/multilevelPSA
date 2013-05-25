\name{covariateBalance}
\alias{covariateBalance}
\title{Calculate covariate effect size differences before and after stratification.}
\usage{
  covariateBalance(covariates, treatment, propensity,
    strata = NULL, int = NULL, tree = FALSE, minsize = 2,
    universal.psd = TRUE, trM = 0, absolute.es = TRUE,
    trt.value = NULL, use.trt.var = FALSE, verbose = FALSE,
    xlim = NULL, plot.strata = TRUE, ...)
}
\arguments{
  \item{covariates}{dataframe of interest}

  \item{treatment}{binary vector of 0s and 1s (necessarily?
  what if character, or 1, 2?)}

  \item{propensity}{PS scores from some method or other.}

  \item{strata}{either a vector of strata number for each
  row of covariate, or one number n in which case it is
  attempted to group rows by ps scores into n strata of
  size approximately 1/n.  This does not seem to work well
  in the case of few specific propensity values, as from a
  tree.}

  \item{int}{either a number m used to divide [0,1] into m
  equal length subintervals, or a vector of cut points
  between 0 an 1 defining the subintervals (perhaps as
  suggested by loess.psa).  In either case these
  subintervals define strata, so strata can be of any
  size.}

  \item{tree}{logical, if unique ps scores are few, as from
  a recursively partitioned tree, then TRUE will force each
  ps value to define a stratum.}

  \item{minsize}{smallest allowable stratum-treatment size.
  If violated, strata is removed.}

  \item{universal.psd}{If 'TRUE', forces standard
  deviations used to be unadjusted for stratification.}

  \item{trM}{trimming proportion for mean calculations.}

  \item{absolute.es}{logical, if 'TRUE' routine uses
  absolute values of all effect sizes.}

  \item{trt.value}{allows user to specify which value is
  active treatment, if desired.}

  \item{use.trt.var}{logical, if true then Rubin-Stuart
  method using only treatment variance with be used in
  effect size calculations.}

  \item{verbose}{logical, controls output that is visibly
  returned.}

  \item{xlim}{limits for the x-axis.}

  \item{plot.strata}{logical indicating whether to print
  strata.}

  \item{...}{currently unused.}
}
\description{
  This function is modified from the
  \code{\link{cv.bal.psa}} function in the
  \code{PSAgrpahics} package.
}
\details{
  Note: effect sizes are calculated as treatment 1 -
  treatment 0, or treatment B - treatment A.
}
\author{
  Robert M. Pruzek RMPruzek@yahoo.com

  James E. Helmreich James.Helmreich@Marist.edu

  KuangNan Xiong harryxkn@yahoo.com
}


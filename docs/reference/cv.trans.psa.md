# Transformation of Factors to Individual Levels

The function `cv.trans.psa` takes a covariate data frame and replaces
each categorical covariate of `n >=3` levels with n new binary covariate
columns, one for each level. Transforms covariate dataframe for use with
the function `cv.bal.psa`.

## Usage

``` r
cv.trans.psa(covariates, fcol = NULL)
```

## Arguments

- covariates:

  A dataframe of covariates, presumably some factors.

- fcol:

  An optional vector containing the factor columns in the covariate data
  frame. In `NULL` (default) routine to identify factors internally.

## Details

NOTE: This function originated in the `PSAgraphics` package. It has been
adapted here for the `multilevelPSA` package.

## Author

James E. Helmreich James.Helmreich@Marist.edu

Robert M. Pruzek RMPruzek@yahoo.com

KuangNan Xiong harryxkn@yahoo.com

Jason Bryer jason@bryer.org

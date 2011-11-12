#' This packages provides functions to perform and visualize multilvel propensity
#' score analys.
#' 
#' \tabular{ll}{
#'  Package: \tab multilevelPSA\cr
#'  Type: \tab Package\cr
#'  Version: \tab 0.9\cr
#'  Date: \tab 2011-03-18\cr
#'  License: \tab GPL (>= 2)\cr
#'  LazyLoad: \tab yes\cr
#'  Depends: \tab ggplot2 reshape plyr psych
#' }
#'
#' This package extends the principles put forth by the \code{PSAgraphics} 
#' (Helmreich, Pruzek, & Xiong, 2010) for multilevel, or clustered, data.
#' 
#' @name multilevelPSA-package
#' @aliases multilevelPSA
#' @docType package
#' @title Multilevel Propensity Score Analysis
#' @author Jason Bryer \email{jason@@bryer.org}
#' @references \url{http://cran.r-project.org/web/packages/PSAgraphics/PSAgraphics.pdf}
#' 		\url{http://www.jstatsoft.org/v29/i06/}
#' @keywords psa multilevel
#' @seealso \code{\link{PSAgraphics}}
#' @import ggplot2 reshape plyr psych
NA

#' Student results from the 2009 Programme of International Student Assessment (PISA)
#' as provided by the Organization for Economic Co-operation and Development (OECD).
#' See \url{http://www.pisa.oecd.org/} for more information including the code book.
#'
#' @name pisa.student
#' @docType data
#' @format a data frame with 475,460 ovservations of 305 variables from North America.
#' @source Organization for Economic Co-operation and Development
#' @keywords datasets
NULL

#' School results from the 2009 Programme of International Student Assessment (PISA)
#' as provided by the Organization for Economic Co-operation and Development (OECD).
#' See \url{http://www.pisa.oecd.org/} for more information including the code book.
#'
#' @name pisa.school
#' @docType data
#' @format a data frame with 17,145 ovservations of 247 variables from North America.
#' @source Organization for Economic Co-operation and Development
#' @keywords datasets
NULL

.First.lib <- function(libname, pkgname) {
}

.Last.lib <- function(libname, pkgname) {
}

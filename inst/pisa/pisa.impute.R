#' This function will use the \code{MICE} package to impute missing values separately
#' for each group.
#'
#' @param toimpute the variables to impute.
#' @param the grouping variable.
#' @param maxToImpute the maximum percentage to attempt to impute. Must be a value
#'        between 0 and 1.
#' @param ... other parameters passed to \code{mice}
impute.pisa <- function(toimpute, grouping, maxToImpute=.5, ...) {
	cols = names(toimpute)	
	imputePlyr <- function(x) {
		missing = apply(x, 2, function(c) sum(is.na(c))) / nrow(x)
		noImpute = names(missing)[which(missing > maxToImpute)]
		x = x[,!names(x) %in% noImpute]
		m.out = mice(x, m=1, ...)
		complete = complete(m.out, m.out$m)
		if(length(noImpute) > 0) {
			complete[,noImpute] = NA
		}
		return(list(m.out, complete[,cols]))
	}
	
	results = dlply(toimpute, .(grouping), imputePlyr, .progress='text', .parallel=FALSE)
	return(results)
}

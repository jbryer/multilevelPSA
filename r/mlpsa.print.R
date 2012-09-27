#' Returns true if the object is of type \code{mlpsa}
#'
#' @param x the object to test
#' @export
is.mlpsa <- function(x) {
	inherits(x, 'mlpsa')
}

#' Prints basic information about a \code{mlpsa} class.
#'
#' @param x the \code{mlpsa} class.
#' @param ... unused.
#' @method print mlpsa
#' @S3method print mlpsa
#' @export
print.mlpsa <- function(x, ...) {
	#TODO: Create a better print function
	cat('The following fields are available:\n')
	print(ls(x))
}

#' Provides a summary of a \code{mlpsa} class.
#'
#' @param object the mlpsa object.
#' @param ... unused.
#' @method summary mlpsa
#' @S3method summary mlpsa
#' @export
summary.mlpsa <- function(object, ...) {
	#TODO: Create a better summary function.
	cat(paste("Multilevel PSA Model of ", nrow(object$level1.summary), ' strata for ',
			  nrow(object$level2.summary), ' levels.\n',
		'Approx t: ', round(object$approx.t, digits=2), '\n',
		'Confidence Interval: ', round(object$overall.ci[1], digits=2), ', ', round(object$overall.ci[2], digits=2),
	sep=''))
}


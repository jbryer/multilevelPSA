#' Estimates propensity scores using logistic regression.
#' 
#' This method will estimate a separate logistic regression model for each level 2
#' (or cluster).
#' 
#' @param vars data frame containing the variables to estimate the logistic regression
#' @param formula the logistic regression formula to use
#' @param level2 the name of the column containing the level 2 specification
#' @param stepAIC if true, the \code{\link{stepAIC}} from the \code{MASS} package
#'        will be used within each level.
#' @param ... currently unused.
#' @return a list of glm classes for each level 2 or stepwise-selected model if stepAIC is true.
#' @seealso getPropensityScores
#' @export
mlpsa.logistic <- function(vars, formula, level2, stepAIC=FALSE, ...) {
	if(stepAIC) { require(MASS) }
	lrPlyr <- function(x) {
		excludeVars = names(x) %in% c(level2)
		x = x[,!excludeVars]
		lr = glm(formula, data=x, family=binomial)
		if(stepAIC) {
			step = stepAIC(lr, trace=FALSE)
			return(step)
		} else {
			return(lr)
		}
	}
	lr.results = dlply(vars, level2, lrPlyr, .progress='text')
	return(lr.results)
}

#' Returns a data frame with two columns corresponding to the level 2 variable
#' and the fitted value from the logistic regression.
#' 
#' @seealso mlpsa.logistic
#' @param lr.results the results of \code{\link{mlpsa.logistic}}
#' @return a data frame
#' @export getPropensityScores
getPropensityScores <- function(lr.results) {
	df = data.frame(level2 = character(), ps=numeric)
	for(i in names(lr.results)) {
		ps = fitted(lr.results[i][[1]])
		df = rbind(df, data.frame(level2 = rep(i, length(ps)), ps=ps))
	}
	return(df)
}

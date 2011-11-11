#' @include package.R
NA

#' Performs a recursive partitioning in a conditional inference framework for each level 2.
#' 
#' TODO: Need more details
#' 
#' @return a list of BinaryTree-class classes for each level 2
#' @export multilevelCtree
multilevelCtree <- function(vars, formula, level2) {
	partyPlyr <- function(x) {
		excludeVars = names(x) %in% c(level2)
		x = x[,!excludeVars]
		tmp.party = ctree(formula, data=x)
		return(tmp.party)
	}
	party.results = dlply(vars, level2, partyPlyr, .progress='text')
	return(party.results)
}

#' Returns a data frame with two columns corresponding to the level 2 variable
#' and the leaves from the conditional inference trees.
#' 
#' @param data data frame to merge results to
#' @return a data frame
#' @export getStrata
getStrata <- function(party.results, data, level2) {
	data$strata = as.numeric(NA)
	for(i in names(party.results)) {
		data[which(data[,level2] == i),]$strata = where(party.results[i][[1]], newdata=data[which(data[,level2] == i),])
	}
	return(data)
}

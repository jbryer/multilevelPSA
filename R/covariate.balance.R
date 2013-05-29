#' Estimate covariate effect sizes before and after propensity score adjustment.
#' 
#' @param covariates frame or matrix of covariates.
#' @param treatment vector of treatment indicators.
#' @param level2 vector indicating level 2 membership.
#' @param strata strata indicators.
#' @param abs if TRUE absolute values of effect sizes will be plotted.
#' @export
covariate.balance <- function(covariates, treatment, level2, strata, abs=TRUE) {
	#Recode factors. First we'll covert logicals and factors with two levels to integers
	for(i in 1:ncol(covariates)) {
		if(class(covariates[,i]) == 'logical') {
			covariates[,i] <- as.integer(covariates[,i])
		} else if(class(covariates[,i]) == 'factor' & length(levels(covariates[,i])) == 2) {
			covariates[,i] <- as.integer(covariates[,i])
		}
	}
	if('factor' %in% sapply(covariates, class)) {
		#Convert remaining factors using cv.trans.psa from PSAgraphics
		covariates <- cv.trans.psa(covariates)[[1]]
	}
	
	results <- data.frame(row.names=names(covariates), 
						  es.adj=rep(as.numeric(NA), ncol(covariates)), 
						  es.unadj=rep(as.numeric(NA), ncol(covariates)),
						  stringsAsFactors=FALSE)
	strata.es <- list()
	for(i in names(covariates)) {
		rows <- !is.na(covariates[,i])
		adj <- describeBy(covariates[rows,i], 
						  group=list(treatment[rows], level2[rows], strata[rows]), 
						  mat=TRUE, skew=FALSE)[,c('group1','group2','group3','n','mean')]
		names(adj) <- c('treat','level2','strata','n','mean')
		adj.mean <- cast(adj, level2 + strata ~ treat, value='mean')
		adj.n <- cast(adj, level2 + strata ~ treat, value='n')
		names(adj.n)[3:4] <- paste0(names(adj.n)[3:4], '.n')
		adj.mean <- cbind(adj.mean, adj.n[,3:4])
		adj.mean <- na.omit(adj.mean)
		adj.mean$diff <- adj.mean[,4] - adj.mean[,3]
		adj.mean$es <- adj.mean$diff / sd(covariates[,i], na.rm=TRUE)
		adj.mean$es.wtd <- adj.mean$es * (adj.mean[,5] + adj.mean[,6])
		results[i,]$es.adj <- mean(adj.mean$es.wtd) / sum(adj.mean[,4:5])
		results[i,]$es.unadj <- ( mean(covariates[treatment,i], na.rm=TRUE) - 
								  	mean(covariates[!treatment,i], na.rm=TRUE) ) / 
									sd(covariates[,i], na.rm=TRUE)
		strata.es[[i]] <- adj.mean[,1:8]
	}
	if(abs) {
		results$es.adj <- abs(results$es.adj)
		results$es.unadj <- abs(results$es.unadj)
	}
	results <- cbind(covariate=row.names(results), results)
	#results <- diff <- results$es.unadj - results$es.adj
	row.names(results) <- 1:nrow(results)
	ret <- list(effects=results, strata.effects=strata.es)
	class(ret) <- 'covariate.balance'
	return(ret)
}

#' Returns the overall effects as a data frame.
#' 
#' @param x results of \code{\link{covariate.balance}}.
#' @param row.names unused.
#' @param optional unused.
#' @param ... unused
#' @return a data frame with overall covariate effects before and after adjustment.
#' @S3method as.data.frame covariate.balance
#' @method as.data.frame covariate.balance
#' @export
as.data.frame.covariate.balance <- function(x, row.names=NULL, optional=FALSE, ...) {
	return(x$effects)
}

#' Prints the overall effects before and after propensity score adjustment.
#' 
#' @param x results of \code{\link{covariate.balance}}.
#' @param ... unused.
#' @S3method print covariate.balance
#' @method print covariate.balance
#' @export
print.covariate.balance <- function(x, ...) {
	print(x$effects)
}

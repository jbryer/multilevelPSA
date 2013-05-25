utils::globalVariables(c('value','covariate','variable','level2','group'))

#' #' Multiple covariate blance assessment plot.
#' 
#' A graphic based upon \code{\link{cv.bal.psa}} function in the \code{PSAgraphics}
#' package. This graphic plots the effect sizes for multiple covariated before and
#' after propensity score andjustement.
#'
#' @param mlpsatree results of \code{\link{mlpsa.ctree}}.
#' @param grid should all the levels be plotted together (FALSE) or in a grid (TRUE).
#' @param ... currently unused.
#' @return a ggplot2 with an attribute, \code{effects}, that is the data frame
#'        used to create the plot.
#' @export
balance.plot <- function(mlpsatree, grid=TRUE, ...) {
	covs <- attr(mlpsatree, 'covars')
	level2 <- attr(mlpsatree, 'level2')
	treat <- attr(mlpsatree, 'treatment')
	
	#Recode factors. First we'll covert logicals and factors with two levels to integers
	for(i in 1:ncol(covs)) {
		if(class(covs[,i]) == 'logical') {
			covs[,i] <- as.integer(covs[,i])
		} else if(class(covs[,i]) == 'factor' & length(levels(covs[,i])) == 2) {
			covs[,i] <- as.integer(covs[,i])
		}
	}
	if('factor' %in% sapply(covs, class)) {
		#Convert remaining factors using cv.trans.psa from PSAgraphics
		#covs <- as.data.frame(cv.trans.psa(covs))
		covs <- cv.trans.psa(covs)[[1]]
		#names(covs) <- gsub('covariates.transformed.', '', names(covs))
	}

	results <- data.frame(covariate=character(), level2=character, unadjusted=numeric(),
						  adjusted=numeric(), stringsAsFactors=FALSE)
	for(i in unique(level2)) {
		cv <- covs[level2 == i,]
		tr <- treat[level2 == i]
		st <- where(mlpsatree[[i]])
		
		if(length(unique(st)) > 26) { #Only use the largest 26 strata
			warning(paste0('Level ', i, ' has more than 26 strata. Will use the ',
						   '26 largest strata only.'))
			strataSize <- as.data.frame(table(st))
			strataSize <- strataSize[order(strataSize$Freq, decreasing=TRUE),]
			cv <- cv[st %in% strataSize[1:26,]$st,]
			tr <- tr[st %in% strataSize[1:26,]$st]
			st <- st[st %in% strataSize[1:26,]$st]
		}
		
		bal <- covariateBalance(cv, tr, propensity=st, tree=TRUE)
		
		results <- rbind(results, data.frame(
			covariate = row.names(bal$effect.sizes),
			level2 = rep(i, ncol(covs)),
			unadjusted = bal$effect.sizes[,'stES_unadj'],
			adjusted = bal$effect.sizes[,'stES_adj'],
			stringsAsFactors = FALSE
		))
	}

	row.names(results) <- 1:nrow(results)
	results <- melt(results, id.vars=c('covariate','level2'))
	results$group <- paste(results$variable, results$level2, sep='-')
	
	results <- results[rev(order(results$level2, results$covariate)),]
	
	results$covariate <- factor(results$covariate, ordered=TRUE)
	
	p <- ggplot(results, aes(x=value, y=covariate, color=variable, 
							 shape=factor(level2), linetype=factor(level2))) + 
		geom_point() + geom_path(alpha=.5, aes(group=group)) +
		ylab('Covariate') + xlab('Effect Size') +
		scale_color_hue('Adjustment') + scale_linetype('level2') + scale_shape('level2')
	if(grid) {
		p <- p + facet_grid(~ level2)
	}
	
	attr(p, 'effects') <- results
	
	return(p)
}

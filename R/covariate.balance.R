#' Estimate covariate effect sizes before and after propensity score adjustment.
#' 
#' @param covs frame or matrix of covariates.
#' @param treat vector of treatment indicators.
#' @param level2 vector indicating level 2 membership.
#' @param strata strata indicators.
#' @export
covariate.balance <- function(covs, treat, level2, strata) {	
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
		st <- strata[level2 == i]
		
		cc <- complete.cases(cv)
		
		if(length(unique(st)) > 26) { #Only use the largest 26 strata
			warning(paste0('Level ', i, ' has more than 26 strata. Will use the ',
						   '26 largest strata only.'))
			strataSize <- as.data.frame(table(st))
			strataSize <- strataSize[order(strataSize$Freq, decreasing=TRUE),]
			cv <- cv[st %in% strataSize[1:26,]$st,]
			tr <- tr[st %in% strataSize[1:26,]$st]
			st <- st[st %in% strataSize[1:26,]$st]
		}
		
		if(length(unique(st)) > 1) {
			bal <- covariateBalance(cv, tr, propensity=st, tree=TRUE)
			
			results <- rbind(results, data.frame(
				covariate = row.names(bal$effect.sizes),
				level2 = rep(i, ncol(covs)),
				unadjusted = bal$effect.sizes[,'stES_unadj'],
				adjusted = bal$effect.sizes[,'stES_adj'],
				stringsAsFactors = FALSE
			))
		}
	}
	
	row.names(results) <- 1:nrow(results)
	results <- melt(results, id.vars=c('covariate','level2'))
	results$group <- paste(results$variable, results$level2, sep='-')
	
	results <- results[rev(order(results$level2, results$covariate)),]
	
	results$covariate <- factor(results$covariate, ordered=TRUE)
	
	class(results) <- c('covariate.balance','data.frame')
	return(results)
}

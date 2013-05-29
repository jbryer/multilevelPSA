utils::globalVariables(c('value','covariate','EffectSize','level2','group'))

#' Multiple covariate blance assessment plot.
#' 
#' A graphic based upon \code{\link{cv.bal.psa}} function in the \code{PSAgraphics}
#' package. This graphic plots the effect sizes for multiple covariated before and
#' after propensity score andjustement.
#'
#' @param x results of \code{\link{covariate.balance}}.
#' @param plot.strata whether individual strata should be plotted.
#' @param strata.size text size for strata if plotted.
#' @param strata.legend.guide guide for legend placement for strata.
#' @param point.size size of the overall effect size points.
#' @param point.alpha transparency level of the overall effect size points.
#' @param line.color the color of the line connecting the overall effect size ponts.
#' @param line.alpha transparency level of the line connecting the overall effect size points.
#' @param ... currently unused.
#' @return a ggplot2 with an attribute, \code{effects}, that is the data frame
#'        used to create the plot.
#' @S3method plot covariate.balance
#' @method plot covariate.balance
#' @export
plot.covariate.balance <- function(x, 
								   plot.strata=FALSE, 
								   strata.size=3,
								   strata.legend.guide='none', 
								   point.size=3,
								   point.alpha=1,
								   line.color='black',
								   line.alpha=.2,
								   ...) {
	bal <- x$effects
	strata <- x$strata.effects
	diff <- bal$es.unadj - bal$es.adj
	cvorder <- bal[order(diff, decreasing=FALSE),]$covariate
	tmp <- melt(bal, id='covariate', variable_name='EffectSize')
	tmp$covariate <- factor(tmp$covariate, levels=cvorder, ordered=TRUE)
	tmp$EffectSize <- as.character(tmp$EffectSize)
	
	p <- ggplot(tmp, aes(x=value, y=covariate, group=covariate))
	if(plot.strata) {
		strata.effects <- data.frame()
		for(i in seq_along(strata)) {
			cov <- names(strata)[i]
			eff <- strata[[i]]
			eff$covariate <- cov
			strata.effects <- rbind(strata.effects, eff)
		}
		strata.effects$covariate <- factor(strata.effects$covariate, levels=cvorder, ordered=TRUE)
		p <- p + geom_text(data=strata.effects, aes(x=abs(es), y=covariate, 
							color=level2, label=strata), size=2, alpha=.3)
	}
	
	p <- p + geom_line(alpha=line.alpha, color=line.color)
	if(plot.strata) {
		p <- p + geom_point(size=point.size, alpha=point.alpha, aes(shape=EffectSize))
		p <- p + scale_color_hue(guide=strata.legend.guide)
	} else {
		p <- p + geom_point(size=strata.size, aes(shape=EffectSize, color=EffectSize))
		p <- p + scale_color_hue(' ', labels=c('Adjusted', 'Unadjusted'))
	}
	p <- p + scale_shape(' ', labels=c('Adjusted', 'Unadjusted')) +
		theme(legend.position=c(.8,.5)) +
		ylab('') + xlab('Effect Size')
	
	return(p)
}

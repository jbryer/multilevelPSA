utils::globalVariables(c('value','covariate','variable','level2','group'))

#' Multiple covariate blance assessment plot.
#' 
#' A graphic based upon \code{\link{cv.bal.psa}} function in the \code{PSAgraphics}
#' package. This graphic plots the effect sizes for multiple covariated before and
#' after propensity score andjustement.
#'
#' @param x results of \code{\link{covariate.balance}}.
#' @param grid should all the levels be plotted together (FALSE) or in a grid (TRUE).
#' @param ... currently unused.
#' @return a ggplot2 with an attribute, \code{effects}, that is the data frame
#'        used to create the plot.
#' @S3method plot covariate.balance
#' @method plot covariate.balance
#' @export
plot.covariate.balance <- function(x, grid=TRUE, ...) {
	p <- ggplot(x, aes(x=value, y=covariate, color=variable 
							 #shape=factor(level2), linetype=factor(level2)
				)) + 
		geom_point() + geom_path(alpha=.5, aes(group=group)) +
		ylab('') + xlab('Effect Size') +
		scale_color_hue(' ') + scale_linetype('level2') + scale_shape('level2')
	if(grid) {
		p <- p + facet_grid(~ level2) + theme(axis.text.x=element_text(angle=-90), legend.position='top')
	}
	
	return(p)
}

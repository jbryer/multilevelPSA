utils::globalVariables(c('level2','diffwtd'))

#' This function produces a ggplot2 figure containing the mean differences for
#' each level two, or cluster.
#'
#' @param x the results of [mlpsa()].
#' @param fill.colors the colors to use for each level two.
#' @param legendlab the label to use for the legend, or NULL to exclude.
#' @param ... currently unused.
#' @return a ggplot2 figure
#' @export
difftable.plot <- function(x, 
						   fill.colors=NULL, 
						   legendlab=NULL, ...) {
	stopifnot(is.mlpsa(x))
	multilevelPSA = x
	level1.summary <- multilevelPSA$level1.summary
	level2.summary <- multilevelPSA$level2.summary
	p = ggplot(level2.summary, aes(x=level2, y=level2, 
		label=prettyNum(diffwtd, digits=3, drop0trailing=FALSE))) + 
		geom_point(alpha=0) +
		geom_text(aes(color=level2), size=5) + xlab(NULL) + ylab(NULL) + 
		theme(legend.position='none', 
			axis.text.x=element_text(size=8, angle=-90, hjust=0, vjust=.5),
			axis.text.y=element_text(size=8, hjust=0, vjust=.5))
	if(!is.null(fill.colors)) {
		p = p + scale_color_manual(legend=FALSE, values=fill.colors) + 
			scale_fill_manual(legend=FALSE, values=fill.colors)
	} else if(length(unique(level2.summary$level2)) > 20) {
		#No legend since the legend would be bigger than the plot
		p = p + scale_color_hue(legend=FALSE) + scale_fill_hue(legend=FALSE)
	} else if(length(unique(level1.summary$level2)) > 8) {
		p = p + scale_color_hue(legendlab) + scale_fill_hue(legendlab)
	} else {
		p = p + scale_color_brewer(legendlab) + scale_fill_brewer(legendlab)
	}
	return(p)
}

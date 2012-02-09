#'
#'
plot.difftable <- function(multilevelPSA, fill.colours=NULL, legendlab=NULL) {
	level1.summary <- multilevelPSA$level1.summary
	level2.summary <- multilevelPSA$level2.summary
	p = ggplot(level2.summary, aes(x=level2, y=level2, 
		label=prettyNum(diffwtd, digits=3, drop0trailing=FALSE))) + 
		geom_point(alpha=0) +
		geom_text(aes(colour=level2), size=5) + xlab(NULL) + ylab(NULL) + 
		opts(legend.position='none', 
			axis.text.x=theme_text(size=8, angle=-90, hjust=0, vjust=.5),
			axis.text.y=theme_text(size=8, hjust=0, vjust=.5))
	if(!is.null(fill.colours)) {
		p = p + scale_colour_manual(legend=FALSE, values=fill.colours) + 
			scale_fill_manual(legend=FALSE, values=fill.colours)
	} else if(length(unique(level2.summary$level2)) > 20) {
		#No legend since the legend would be bigger than the plot
		p = p + scale_colour_hue(legend=FALSE) + scale_fill_hue(legend=FALSE)
	} else if(length(unique(level1.summary$level2)) > 8) {
		p = p + scale_colour_hue(legendlab) + scale_fill_hue(legendlab)
	} else {
		p = p + scale_colour_brewer(legendlab) + scale_fill_brewer(legendlab)
	}
	return(p)
}

#'
#' @export 
plot.mlpsa.distribution <- function(multilevelPSA, x='level2', y='Public', colour.values=NULL, flip=TRUE, xlab=NULL, ylab=y) {
	p = ggplot(multilevelPSA$level1.summary, aes_string(x=x, y=y))
	p = p + scale_y_continuous(limits=multilevelPSA$plot.range)
	if(flip) {
		p = p + coord_flip() 
		p = p + opts(legend.position=c(-1,-1), axis.text.x=theme_text(size=10, angle=0, hjust=.5, vjust=1))
	} else {
		p = p + opts(legend.position=c(-1,-1), axis.text.x=theme_text(size=10, angle=-90, hjust=0, vjust=.5))
	}
	p = p + geom_point(stat='identity', alpha=.3, size=.8)
	p = p + geom_hline(yintercept=multilevelPSA$overall.mnx, colour='blue', size=.6)
	if(!is.null(colour.values)) p = p + scale_fill_manual(values=colour.values)
	p = p + scale_y_continuous(limits=multilevelPSA$plot.range)	
	p = p + geom_point(data=multilevelPSA$level2.summary, aes_string(x=x, y='mnx', size='n', fill=x), stat='identity', shape=21, colour='black')
	p = p + xlab(xlab) + ylab(ylab)
	p = p + geom_rug(data=multilevelPSA$level1.summary, aes_string(x=NULL, y=y, colour=x), alpha=.6, size=.5)
	if(flip) {
		p = p + geom_text(data=multilevelPSA$level2.summary, y=multilevelPSA$plot.range[1], aes(x=level2, label=prettyNum(mnx, digits=3, drop0trailing=FALSE)), size=3, hjust=0)
	} else {
		p = p + geom_text(data=multilevelPSA$level2.summary, y=multilevelPSA$plot.range[1], aes(x=level2, label=prettyNum(mnx, digits=3, drop0trailing=FALSE)), size=3, hjust=0, angle=-90)
	}
	return(p)
}

#'
#' @export 
plot.mlpsa.distribution <- function(multilevelPSA, treat='Public', 
			colour.values=NULL, flip=TRUE, label=treat, level2.label=NULL) {
	xname = 'level2'
	yname = treat
	fillname = 'level2'
	level1.summary = multilevelPSA$level1.summary
	level2.summary = multilevelPSA$level2.summary
	unweighted.summary = multilevelPSA$unweighted.summary
	plot.range = multilevelPSA$plot.range
	overall.ci = multilevelPSA$overall.ci
	overall.wtd = multilevelPSA$overall.wtd
	overall.mnx = multilevelPSA$overall.mnx
	overall.mny = multilevelPSA$overall.mny
	projection.intercept = multilevelPSA$projection.intercept
	level1.summary$panel = treat
	
	if(flip) {
		xname = treat
		yname = 'level2'
		p = ggplot(level1.summary, aes_string(x=xname, y=yname))
		#This is a bit of a hack. I renamed the mnx and mny columns in the mlpsa
		#function to use the treatment levels. This will duplicate those columns.
		level2.summary$mnx = multilevelPSA$level2.summary[,5]
		level2.summary$mny = multilevelPSA$level2.summary[,4]
		p = p + scale_x_continuous(limits=plot.range)
		p = p + opts(legend.position='none', 
					 axis.text.y=theme_text(size=10, angle=0, hjust=.5, vjust=1))
		p = p + ylab(level2.label)+ xlab(label)
		p = p + geom_rug(data=level1.summary, aes_string(x=treat, y=NULL, colour=fillname), 
						 alpha=.6, size=.5)
	} else {
		p = ggplot(level1.summary, aes_string(x=xname, y=yname))
		level2.summary$mnx = multilevelPSA$level2.summary[,4]
		level2.summary$mny = multilevelPSA$level2.summary[,5]
		p = p + scale_y_continuous(limits=plot.range)
		p = p + opts(legend.position=c(-1,-1), 
					 axis.text.x=theme_text(size=10, angle=-90, hjust=0, vjust=.5))
		p = p + ylab(label) + xlab(level2.label)
		p = p + geom_rug(data=level1.summary, aes_string(x=NULL, y=treat, colour=fillname), 
						 alpha=.6, size=.5)
	}
	
	p = p + geom_point(stat='identity', alpha=.3, size=.8)
	#p = p + geom_hline(yintercept=overall.mnx, colour='blue', size=.6)
	if(!is.null(colour.values)) p = p + scale_fill_manual(values=colour.values)
	p = p + geom_point(data=level2.summary, aes_string(x=xname, y=yname, size='n', fill=fillname), 
					   stat='identity', shape=21, colour='black')
	if(flip) {
		labeling = level2.summary[,c(yname, treat)]
		names(labeling) = c('yname', 'label')
		p = p + geom_text(data=labeling, x=plot.range[1], 
						  aes(y=yname, label=prettyNum(label, digits=3, drop0trailing=FALSE)), 
						  size=3, hjust=0)
	} else {
		labeling = level2.summary[,c(xname, treat)]
		names(labeling) = c('xname', 'label')
		p = p + geom_text(data=labeling, y=plot.range[1], 
						  aes(x=xname, label=prettyNum(label, digits=3, drop0trailing=FALSE)), 
						  size=3, hjust=0, angle=-90)
	}
	return(p)
}

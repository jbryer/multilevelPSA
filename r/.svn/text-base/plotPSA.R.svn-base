#' @include package.R
NA

ggplot.alpha <- function(...) get("alpha", grep("package:ggplot2$", search()))(...)

#'
#' @export plotpsa.multilevel.psa
plotpsa.multilevel.psa <- function(multilevelPSA,
		xlab='Difference Score', ylab='Level 2', title=NULL,
		overall.col="blue", overall.ci.col='green', level2.point.size=NULL,
		level1.points=TRUE,	errorbars=TRUE, level2.rug.plot=TRUE, jitter=TRUE, reorder=TRUE,
		labelLevel2=TRUE, sd=NULL
) {
	if(missing(multilevelPSA)) {
		stop('Must provide multilevelPSA from multilevel.psa')
	}
	
	if(reorder) {
		multilevelPSA$level2.summary = multilevelPSA$level2.summary[order(multilevelPSA$level2.summary$diffwtd),]
		ord.level2 = multilevelPSA$level2.summary$level2[order(multilevelPSA$level2.summary$diffwtd)]
		multilevelPSA$level1.summary$level2 = factor(multilevelPSA$level1.summary$level2, levels=ord.level2)
		multilevelPSA$level2.summary$level2 = factor(multilevelPSA$level2.summary$level2, levels=ord.level2)
	}

	if(!is.null(sd)) {
		multilevelPSA$level1.summary$Diff = multilevelPSA$level1.summary$Diff / sd
		multilevelPSA$level2.summary$diffwtd = multilevelPSA$level2.summary$diffwtd / sd
		multilevelPSA$level2.summary$ci.min = multilevelPSA$level2.summary$ci.min / sd
		multilevelPSA$level2.summary$ci.max = multilevelPSA$level2.summary$ci.max / sd
		multilevelPSA$overall.ci = multilevelPSA$overall.ci / sd
		multilevelPSA$overall.wtd = multilevelPSA$overall.wtd /sd
		multilevelPSA$plot.range = multilevelPSA$plot.range / sd
	}
	
	p = ggplot(multilevelPSA$level1.summary, aes(x=level2, y=Diff)) + coord_flip() + 
			geom_hline(aes(y=0), colour='black', size=1, alpha=.7) +
			geom_hline(yintercept=multilevelPSA$overall.wtd, colour=overall.col, size=1) + 
			geom_hline(yintercept=multilevelPSA$overall.ci, colour=overall.ci.col, size=1) + 
			opts(axis.ticks.margin=unit(0, "cm"))
	if(errorbars) {
		p = p + geom_errorbar(data=multilevelPSA$level2.summary, aes(x=level2, y=NULL, ymin=ci.min, ymax=ci.max), colour='green', alpha=.6)
	}
	if(level1.points) {
		if(jitter) {
			p = p + geom_point(stat='identity', alpha=.3, size=.8, position='jitter')
		} else {
			p = p + geom_point(stat='identity', alpha=.3, size=.8)
		}
	}
	p = p + geom_point(data=multilevelPSA$level2.summary, aes(x=level2, y=diffwtd, size=n), fill=ggplot.alpha('blue', .6), stat='identity', shape=21, colour='black')
	if(level2.rug.plot) {
		p = p + geom_rug(data=multilevelPSA$level2.summary, aes(x=NULL, y=diffwtd), alpha=.6, size=.5, colour='blue')
	}
	p = p + xlab(ylab) + ylab(xlab) + scale_size_continuous('Size')
	if(!is.null(title)) {
		p = p + opts(title=title)
	}
	
	if(labelLevel2) {
		p = p + geom_text(data=multilevelPSA$level2.summary, aes(x=level2, label=prettyNum(diffwtd, digits=3, drop0trailing=FALSE)), y=(0.9 * min(multilevelPSA$level1.summary$Diff)), size=3, hjust=1)
	}
			
	return(p)
}

#setGeneric('plotpsa')
#setGeneric('plotpsa', function(multilevelPSA, ...) standardGeneric('plotpsa'))

#
# @exportMethod plotpsa
#setMethod('plotpsa', signature(multilevelPSA='multilevel.psa'), plotpsa.multilevel.psa)

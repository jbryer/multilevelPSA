#' @include package.R
NA

ggplot.alpha <- function(...) get("alpha", grep("package:ggplot2$", search()))(...)

#'
#' @export plotcirc.multilevel.psa
plotcirc.multilevel.psa <- function(multilevelPSA,
		xlab='Control', ylab='Treatment', legendlab='Level 2', title=NULL,
		overall.col="blue", overall.ci.col='green',
		level1.plot=TRUE, level1.point.size=NULL, level1.rug.plot=NULL, level1.projection.lines=FALSE,
		level2.plot=TRUE, level2.point.size=NULL, level2.rug.plot=geom_rug_alt, level2.projection.lines=TRUE, level2.label=FALSE, 
		unweighted.means=FALSE, weighted.means=FALSE, fill.colours=NULL
) {
	if(missing(multilevelPSA)) {
		stop('Must provide multilevelPSA from multilevel.psa')
	}

	#Setup ggplot2
	p = ggplot(data=multilevelPSA$level2.summary, aes(x=mnx, y=mny, fill=level2, size=n)) +
			coord_equal(ratio=1) + 
			scale_x_continuous(limits=multilevelPSA$plot.range) +
			scale_y_continuous(limits=multilevelPSA$plot.range) +
			opts(axis.ticks.margin=unit(.1, "cm"))
	#Draw dashed lines for unweighted means
	if(unweighted.means) {
		p = p + geom_segment(data=multilevelPSA$unweighted.summary, aes(x=multilevelPSA$unweighted.summary[,3], y=multilevelPSA$plot.range[1], xend=multilevelPSA$unweighted.summary[,3], yend=multilevelPSA$unweighted.summary[,2], colour=level2), alpha=.4, linetype='dashed', size=.5) +
				geom_segment(data=multilevelPSA$unweighted.summary, aes(x=multilevelPSA$plot.range[1], y=multilevelPSA$unweighted.summary[,2], xend=multilevelPSA$unweighted.summary[,3], yend=multilevelPSA$unweighted.summary[,2], colour=level2), alpha=.4, linetype='dashed', size=.5)
	}
	#Draw solid lines for weighted means
	if(weighted.means) {
		p = p + geom_segment(data=multilevelPSA$level2.summary, aes(x=mnx, y=multilevelPSA$plot.range[1], xend=mnx, yend=mny, colour=level2), alpha=.7, size=.5) +
				geom_segment(data=multilevelPSA$level2.summary, aes(x=multilevelPSA$plot.range[1], y=mny, xend=mnx, yend=mny, colour=level2), alpha=.7, size=.5)
	}
	#Rug plots
	if(!is.null(level1.rug.plot)) {
		p = p + level1.rug.plot(data=multilevelPSA$level1.summary, aes(x=multilevelPSA$level1.summary[,5], y=multilevelPSA$level1.summary[,4], colour=level2), alpha=.5, size=.25)
	}
	if(!is.null(level2.rug.plot)) {
		p = p + level2.rug.plot(data=multilevelPSA$level2.summary, aes(x=mnx, y=mny, colour=level2), alpha=.6, size=.5)
	}
	#Projection lines
	if(level1.projection.lines) {
		p = p + geom_abline(data=multilevelPSA$level1.summary, aes(intercept=Diff, slope=1, colour=strata2), alpha=.5, size=.8)
	}
	if(level2.projection.lines) {
		#p = p + geom_abline(data=multilevelPSA$level2.summary, aes(intercept=diffwtd, slope=1, colour=level2), alpha=.5, size=.8)		
		tmp = multilevelPSA$level2.summary[order(multilevelPSA$level2.summary$diffwtd),]
		#tmp = tmp[c(1, (nrow(tmp)/4), (3*nrow(tmp)/4), nrow(tmp)),]
		p = p + geom_segment(data=tmp, aes(x=mnx, y=mny, xend=xmark, yend=ymark, colour=level2), size=.5, alpha=.2, linetype=1)
	}
	#Unit line
	p = p + geom_abline(slope=1, intercept=0, alpha=.7, size=1.4)
	#Overall multilevelPSA
	p = p + geom_abline(slope=1, intercept=multilevelPSA$overall.ci[1], colour=overall.ci.col, linetype=3, size=.6, alpha=.9) +
			geom_abline(slope=1, intercept=multilevelPSA$overall.ci[2], colour=overall.ci.col, linetype=3, size=.6, alpha=.9)
	#Overall difference line (parallel to the unit line)
	p = p + geom_abline(slope=1, intercept=multilevelPSA$overall.wtd, colour=overall.col, linetype='dashed', size=.6, alpha=.9)
	#Overall results (vertical line)
	p = p + geom_vline(xintercept=multilevelPSA$overall.mnx, colour=overall.col, size=.6, alpha=.7) +
			geom_hline(yintercept=multilevelPSA$overall.mny, colour=overall.col, size=.6, alpha=.7)
	#Label the mean lines
	p = p + geom_text( x=multilevelPSA$plot.range[1], y=multilevelPSA$overall.mny, label=prettyNum(multilevelPSA$overall.mny, digits=2), colour=overall.col, vjust=-.5, hjust=-.6, size=3) +
			geom_text( y=multilevelPSA$plot.range[1], x=multilevelPSA$overall.mnx, label=prettyNum(multilevelPSA$overall.mnx, digits=2), colour=overall.col, vjust=-.5, hjust=1.5, angle=-90, size=3)
	#p = p + geom_text(data=NULL, aes(x=(multilevelPSA$plot.range[1]+multilevelPSA$overall.wtd), y=(multilevelPSA$plot.range[1]+multilevelPSA$overall.wtd), label=prettyNum(multilevelPSA$overall.wtd, digits=3)), angle=45, size=3, colour=overall.col, vjust=-.7, hjust=-1)
	#Point for each level 1 stratum
	if(level1.plot) {
		#TODO: WARNING can't seem to specify both size and fill for secondary data set (seems to be Windows only)
		if(is.null(level1.point.size)) {
			p = p + geom_point(data=multilevelPSA$level1.summary, aes(x=multilevelPSA$level1.summary[,5], y=multilevelPSA$level1.summary[,4], colour=multilevelPSA$level1.summary$level2, size=multilevelPSA$level1.summary$n), alpha=.6)
		} else {
			p = p + geom_point(data=multilevelPSA$level1.summary, aes(x=multilevelPSA$level1.summary[,5], y=multilevelPSA$level1.summary[,4], colour=multilevelPSA$level1.summary$level2), size=1, alpha=.6)
		}
	}
	#Level 2 points
	if(level2.plot) {
		if(is.null(level2.point.size)) {
			p = p + geom_point(shape=21, colour='black') 
		} else {
			p = p + geom_point(size=level2.point.size, shape=21, colour='black')
		}
	}
	#Label level 2 points
	if(level2.label) { 
		p = p + geom_text(data=multilevelPSA$level2.summary, aes(x=mnx, y=mny, label=level2, hjust=.5, vjust=.5), stat='identity', size=4, colour='black')
	}
	#Projected difference distribution
	p = p + geom_abline(slope=-1, intercept=(multilevelPSA$projection.intercept - .03 * diff(multilevelPSA$plot.range)), colour='black', size=.5, alpha=.7)
	#Labels
	p = p + xlab(xlab) + ylab(ylab) + scale_size_continuous('Size')
	#Difference disttribution (as x's)
	p = p + geom_point(data=multilevelPSA$level2.summary, aes(x=xmark, y=ymark, label='x', colour=level2), stat='identity', size=2, shape=3, alpha=.5)
	#Set colour scheme and legend
	if(!is.null(fill.colours)) {
		p = p + scale_colour_manual(legend=FALSE, values=fill.colours) + scale_fill_manual(legend=FALSE, values=fill.colours)
	} else if(length(unique(multilevelPSA$level2.summary$level2)) > 20) {
		#No legend since the legend would be bigger than the plot
		p = p + scale_colour_hue(legend=FALSE) + scale_fill_hue(legend=FALSE)
	} else if(length(unique(multilevelPSA$level1.summary$level2)) > 8) {
		p = p + scale_colour_hue(legendlab) + scale_fill_hue(legendlab)
	} else {
		p = p + scale_colour_brewer(legendlab) + scale_fill_brewer(legendlab)
	}
	if(!is.null(title)) {
		p = p + opts(title=title)
	}
	
	return(p)
}

#setGeneric('plotcirc', function(multilevelPSA, ...) standardGeneric('plotcirc'))

#
# @exportMethod plotcirc
#setMethod('plotcirc', signature(multilevelPSA='multilevel.psa'), plotcirc.multilevel.psa)

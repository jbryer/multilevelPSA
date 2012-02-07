#' Plots the results of a multilevel propensity score model.
#'
#' The plot created uses the \code{ggplot2} framework. As such, additional modificaitons
#' can be made. This plot is an extension of the \code{circ.psa} function in the
#' \code{PSAgraphics} package for multilevel models.
#'
#' @param multilevelPSA 
#' @S3method plot mlpsa
#' @method plot mlpsa
#' @export
plot.mlpsa <- function(multilevelPSA,
		xlab=names(multilevelPSA$level2.summary)[4], ylab=names(multilevelPSA$level2.summary)[5], 
		legendlab='Level 2', title=NULL,
		overall.col="blue", overall.ci.col='green',
		level1.plot=FALSE, level1.point.size=NULL, level1.rug.plot=NULL, 
		level1.projection.lines=FALSE,
		level2.plot=TRUE, level2.point.size=NULL, level2.rug.plot=geom_rug_alt, 
		level2.projection.lines=TRUE, level2.label=FALSE, 
		unweighted.means=FALSE, weighted.means=FALSE, fill.colours=NULL, ...
) {
	ggplot.alpha <- function(...) get("alpha", grep("package:ggplot2$", search()))(...)

	if(missing(multilevelPSA)) {
		stop('Must provide multilevelPSA from multilevel.psa')
	}
	
	level1.summary = multilevelPSA$level1.summary
	level2.summary = multilevelPSA$level2.summary
	unweighted.summary = multilevelPSA$unweighted.summary
	plot.range = multilevelPSA$plot.range
	overall.ci = multilevelPSA$overall.ci
	overall.wtd = multilevelPSA$overall.wtd
	overall.mnx = multilevelPSA$overall.mnx
	overall.mny = multilevelPSA$overall.mny
	projection.intercept = multilevelPSA$projection.intercept
	
	#This is a bit of a hack. I renamed the mnx and mny columns in the mlpsa
	#function to use the treatment levels. This will duplicate those columns.
	level2.summary$mnx = multilevelPSA$level2.summary[,4]
	level2.summary$mny = multilevelPSA$level2.summary[,5]

	
	#Setup ggplot2
	p = ggplot(data=level2.summary, 
			aes(x=mnx, y=mny, fill=level2, size=n)) +
			coord_equal(ratio=1) + 
			scale_x_continuous(limits=plot.range) +
			scale_y_continuous(limits=plot.range) +
			opts(axis.ticks.margin=unit(.1, "cm"))
	#Draw dashed lines for unweighted means
	if(unweighted.means) {
		p = p + geom_segment(data=unweighted.summary, 
							 aes_string(x=names(unweighted.summary)[3], 
							 	xend=names(unweighted.summary)[3], 
							 	yend=names(unweighted.summary)[2], 
							 	colour='level2'), 
							 y=plot.range[1], 
							 alpha=.4, linetype='dashed', size=.5) +
				geom_segment(data=unweighted.summary, 
							 aes_string(y=names(unweighted.summary)[2], 
							 	xend=names(unweighted.summary)[3], 
							 	yend=names(unweighted.summary)[2], 
							 	colour='level2'),
							 x=plot.range[1], alpha=.4, linetype='dashed', size=.5)
	}
	#Draw solid lines for weighted means
	if(weighted.means) {
		p = p + geom_segment(data=level2.summary, 
							 aes(x=mnx, xend=mnx, yend=mny, colour=level2),
							 y=plot.range[1], alpha=.7, size=.5) +
				geom_segment(data=level2.summary, 
							 aes(y=mny, xend=mnx, yend=mny, colour=level2),
							 x=plot.range[1], alpha=.7, size=.5)
	}
	#Rug plots
	if(!is.null(level1.rug.plot)) {
		p = p + level1.rug.plot(data=level1.summary, 
								aes_string(x=names(level1.summary)[5], 
									y=names(level1.summary)[4], colour='level2'), 
								alpha=.5, size=.25)
	}
	if(!is.null(level2.rug.plot)) {
		p = p + level2.rug.plot(data=level2.summary, 
								aes(x=mnx, y=mny, colour=level2), alpha=.6, size=.5)
	}
	#Projection lines
	if(level1.projection.lines) {
		p = p + geom_abline(data=level1.summary, 
							aes(intercept=Diff, slope=1, colour=strata2), alpha=.5, size=.8)
	}
	if(level2.projection.lines) {
		tmp = level2.summary[order(level2.summary$diffwtd),]
		p = p + geom_segment(data=tmp, aes(x=mnx, y=mny, xend=xmark, yend=ymark, colour=level2), 
							 size=.5, alpha=.2, linetype=1)
	}
	#Unit line
	p = p + geom_abline(slope=1, intercept=0, alpha=.7, size=1.4)
	#Overall multilevelPSA
	p = p + geom_abline(slope=1, intercept=overall.ci[1], 
						colour=overall.ci.col, linetype=3, size=.6, alpha=.9) +
			geom_abline(slope=1, intercept=overall.ci[2], 
						colour=overall.ci.col, linetype=3, size=.6, alpha=.9)
	#Overall difference line (parallel to the unit line)
	p = p + geom_abline(slope=1, intercept=overall.wtd, 
						colour=overall.col, linetype='dashed', size=.6, alpha=.9)
	#Overall results (vertical line)
	p = p + geom_vline(xintercept=overall.mnx, 
					   colour=overall.col, size=.6, alpha=.7) +
			geom_hline(yintercept=overall.mny, 
					   colour=overall.col, size=.6, alpha=.7)
	#Label the mean lines
	p = p + geom_text( x=plot.range[1], y=overall.mny,
					   label=prettyNum(overall.mny, digits=2), 
					   colour=overall.col, vjust=-.5, hjust=-.6, size=3) +
			geom_text( y=plot.range[1], x=overall.mnx, 
					   label=prettyNum(overall.mnx, digits=2), 
					   colour=overall.col, vjust=-.5, hjust=1.5, angle=-90, size=3)
	#Point for each level 1 stratum
	if(level1.plot) {
		#TODO: WARNING can't seem to specify both size and fill for secondary data set 
		#(seems to be Windows only)
		if(is.null(level1.point.size)) {
			p = p + geom_point(data=level1.summary, 
							   aes_string(x=names(level1.summary)[5], 
								   	y=names(level1.summary)[4], 
								   	fill='level2', 
								   	size='n'), 
								   alpha=.6)
		} else {
			p = p + geom_point(data=level1.summary, 
							   aes_string(x=names(level1.summary)[5], 
								   	y=names(level1.summary)[4], 
								   	fill='level2'), 
							   size=1, alpha=.6)
		}
	}
	#Level 2 points
	if(level2.plot) {
		if(is.null(level2.point.size)) {
			p = p + geom_point(shape=21, colour='black') 
		} else {
			p = p + geom_point(size=multilevelPSA$level2.point.size, shape=21, colour='black')
		}
	}
	#Label level 2 points
	if(level2.label) { 
		p = p + geom_text(data=level2.summary, 
						  aes(x=mnx, y=mny, label=level2, hjust=.5, vjust=.5), 
						  stat='identity', size=4, colour='black')
	}
	#Projected difference distribution
	p = p + geom_abline(slope=-1, 
						intercept=(projection.intercept - .03 * diff(plot.range)), 
						colour='black', size=.5, alpha=.7)
	#Labels
	p = p + xlab(xlab) + ylab(ylab) + scale_size_continuous('Size')
	#Difference disttribution (as x's)
	p = p + geom_point(data=level2.summary, 
					   aes(x=xmark, y=ymark, colour=level2), 
					   label='x', stat='identity', size=2, shape=3, alpha=.5)
	#Set colour scheme and legend
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
	if(!is.null(title)) {
		p = p + opts(title=title)
	}
	
	return(p)
}

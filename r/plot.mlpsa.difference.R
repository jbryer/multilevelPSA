#' Creates a graphic summarizing the differences between treatment and comparison
#' groups within and across level two clusters.
#'
#' @param multilevelPSA the results of \code{\link{mlpsa}}.
#' @param xlab label for the x-axis, or NULL to exclude.
#' @param ylab label for the y-aixs, or NULL to exclude.
#' @param title title of the figure, or NULL to exclude.
#' @param overall.col the color of the overall results line.
#' @param overall.ci.col the color of the overall confidence interval.
#' @param level2.point.size the point size of level 2 points.
#' @param level1.points logical value indicating whether level 1 strata should be plotted.
#' @param errorbars logical value indicating whether error bars should be plotted for
#'        for each level 1.
#' @param level2.rug.plot logical value indicating whether a rug plot should be
#'        plotted for level 2.
#' @param jitter logical value indicating whether level 1 points should be jittered.
#' @param reorder logical value indicating whether the level two clusters should be
#'        reordered from largest difference to smallest.
#' @param labelLevel2 logical value indicating whether the difference for each level 2
#'        should be labeled.
#' @param sd If specified, effect sizes will be plotted instead of difference in the
#'        native unit.
#' @param ... currently unused.
#' @export
plot.mlpsa.difference <- function(multilevelPSA,
		xlab='Difference Score', 
		ylab=NULL,
		title=NULL,
		overall.col="blue",
		overall.ci.col='green',
		level2.point.size=NULL,
		level1.points=TRUE,
		errorbars=TRUE,
		level2.rug.plot=TRUE,
		jitter=TRUE,
		reorder=TRUE,
		labelLevel2=TRUE,
		sd=NULL,
		...
) {
	ggplot.alpha <- function(...) get("alpha", grep("package:ggplot2$", search()))(...)

	if(missing(multilevelPSA)) {
		stop('Must provide multilevelPSA from multilevel.psa')
	}
	
	if(reorder) {
		multilevelPSA$level2.summary = multilevelPSA$level2.summary[
			order(multilevelPSA$level2.summary$diffwtd),]
		ord.level2 = multilevelPSA$level2.summary$level2[
			order(multilevelPSA$level2.summary$diffwtd)]
		multilevelPSA$level1.summary$level2 = factor(multilevelPSA$level1.summary$level2, 
													 levels=ord.level2)
		multilevelPSA$level2.summary$level2 = factor(multilevelPSA$level2.summary$level2, 
													 levels=ord.level2)
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
			opts(axis.ticks.margin=unit(0, "cm"), axis.text.y=theme_text(size=8, angle=0, hjust=.5))
	if(errorbars) {
		p = p + geom_errorbar(data=multilevelPSA$level2.summary, 
							  aes(x=level2, y=NULL, ymin=ci.min, ymax=ci.max), 
							  colour='green', alpha=.6)
	}
	if(level1.points) {
		if(jitter) {
			p = p + geom_point(stat='identity', alpha=.3, size=.8, position='jitter')
		} else {
			p = p + geom_point(stat='identity', alpha=.3, size=.8)
		}
	}
	p = p + geom_point(data=multilevelPSA$level2.summary, aes(x=level2, y=diffwtd, size=n), 
					   fill=ggplot.alpha('blue', .6), stat='identity', shape=21, colour='black')
	if(level2.rug.plot) {
		p = p + geom_rug(data=multilevelPSA$level2.summary, aes(x=NULL, y=diffwtd), 
						 alpha=.6, size=.5, colour='blue')
	}
	p = p + xlab(ylab) + ylab(xlab) + scale_size_continuous('Size')
	if(!is.null(title)) {
		p = p + opts(title=title)
	}
	
	if(labelLevel2) {
		p = p + geom_text(data=multilevelPSA$level2.summary, aes(x=level2, 
						label=prettyNum(diffwtd, digits=3, drop0trailing=FALSE)), 
						y=(min(multilevelPSA$level2.summary$ci.min)+1), size=3, hjust=1)
	}
			
	return(p)
}

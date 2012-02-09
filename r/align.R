#' Adapted from ggExtra package which is no longer available. This is related to
#' an experimental mlpsa plot that will combine the circular plot along with
#' the two individual distributions.
#' 
#' @param gl grid.layout
#' @param ... graphic elements to combine.
align.plots <- function(gl, ...) {
	# Obtained from http://groups.google.com/group/ggplot2/browse_thread/thread/1b859d6b4b441c90
	# Adopted from http://ggextra.googlecode.com/svn/trunk/R/align.r
	
	# BUGBUG: Does not align horizontally when one has a title.
	#    There seems to be a spacer used when a title is present.  Include the
	#    size of the spacer.  Not sure how to do this yet.
	
	stats.row <- vector( "list", gl$nrow )
	stats.col <- vector( "list", gl$ncol )
	
	lstAll <- list(...)
	
	dots <- lapply(lstAll, function(.g) ggplotGrob(.g[[1]]))
	plottitles <- lapply(dots, function(.g) editGrob(getGrob(.g,"plot.title.text",grep=TRUE), vp=NULL))
	
	xtitles <- lapply(dots, function(.g) if(!is.null(getGrob(.g,"axis.title.x.text",grep=TRUE)))
		editGrob(getGrob(.g,"axis.title.x.text",grep=TRUE), vp=NULL) else ggplot2:::.zeroGrob)   
	
	xlabels <- lapply(dots, function(.g) if(!is.null(getGrob(.g,"axis.text.x.text",grep=TRUE)))
		editGrob(getGrob(.g,"axis.text.x.text",grep=TRUE), vp=NULL) else ggplot2:::.zeroGrob)  
	
	ytitles <- lapply(dots, function(.g) if(!is.null(getGrob(.g,"axis.title.y.text",grep=TRUE)))
		editGrob(getGrob(.g,"axis.title.y.text",grep=TRUE), vp=NULL) else ggplot2:::.zeroGrob)   
	
	ylabels <- lapply(dots, function(.g) if(!is.null(getGrob(.g,"axis.text.y.text",grep=TRUE)))
		editGrob(getGrob(.g,"axis.text.y.text",grep=TRUE), vp=NULL) else ggplot2:::.zeroGrob)  
	
	legends <- lapply(dots, function(.g) if(!is.null(.g$children$legends))
		editGrob(.g$children$legends, vp=NULL) else ggplot2:::.zeroGrob)
	
	widths.left <- mapply(`+`, e1=lapply(ytitles, grobWidth),
						  e2= lapply(ylabels, grobWidth), SIMPLIFY=FALSE)
	widths.right <- lapply(legends, grobWidth)
	#  heights.top <- lapply(plottitles, grobHeight)
	heights.top <- lapply( plottitles, function(x) unit(0,"cm") )
	heights.bottom <- mapply(`+`, e1=lapply(xtitles, grobHeight), e2= lapply(xlabels, grobHeight), SIMPLIFY=FALSE)
	
	for ( i in seq_along( lstAll ) ) {
		lstCur <- lstAll[[i]]
		
		# Left
		valNew <- widths.left[[ i ]]
		valOld <- stats.col[[ min(lstCur[[3]]) ]]$widths.left.max
		if ( is.null( valOld ) ) valOld <- unit( 0, "cm" )
		stats.col[[ min(lstCur[[3]]) ]]$widths.left.max <- max( do.call( unit.c, list(valOld, valNew) ) )
		
		# Right
		valNew <- widths.right[[ i ]]
		valOld <- stats.col[[ max(lstCur[[3]]) ]]$widths.right.max
		if ( is.null( valOld ) ) valOld <- unit( 0, "cm" )
		stats.col[[ max(lstCur[[3]]) ]]$widths.right.max <- max( do.call( unit.c, list(valOld, valNew) ) )
		
		# Top
		valNew <- heights.top[[ i ]]
		valOld <- stats.row[[ min(lstCur[[2]]) ]]$heights.top.max
		if ( is.null( valOld ) ) valOld <- unit( 0, "cm" )
		stats.row[[ min(lstCur[[2]]) ]]$heights.top.max <- max( do.call( unit.c, list(valOld, valNew) ) )
		
		# Bottom
		valNew <- heights.bottom[[ i ]]
		valOld <- stats.row[[ max(lstCur[[2]]) ]]$heights.bottom.max
		if ( is.null( valOld ) ) valOld <- unit( 0, "cm" )
		stats.row[[ max(lstCur[[2]]) ]]$heights.bottom.max <- max( do.call( unit.c, list(valOld, valNew) ) )
	}
	
	for(i in seq_along(dots)){
		lstCur <- lstAll[[i]]
		nWidthLeftMax <- stats.col[[ min( lstCur[[ 3 ]] ) ]]$widths.left.max
		nWidthRightMax <- stats.col[[ max( lstCur[[ 3 ]] ) ]]$widths.right.max
		nHeightTopMax <- stats.row[[ min( lstCur[[ 2 ]] ) ]]$heights.top.max
		nHeightBottomMax <- stats.row[[ max( lstCur[[ 2 ]] ) ]]$heights.bottom.max
		pushViewport( viewport( layout.pos.row=lstCur[[2]],
								layout.pos.col=lstCur[[3]], just=c("left","top") ) )
		pushViewport(viewport(
			x=unit(0, "npc") + nWidthLeftMax - widths.left[[i]],
			y=unit(0, "npc") + nHeightBottomMax - heights.bottom[[i]],
			width=unit(1, "npc") - nWidthLeftMax + widths.left[[i]] -
				nWidthRightMax + widths.right[[i]],
			height=unit(1, "npc") - nHeightBottomMax + heights.bottom[[i]] -
				nHeightTopMax + heights.top[[i]],
			just=c("left","bottom")))
		grid.draw(dots[[i]])
		upViewport(2)
	}
	
}

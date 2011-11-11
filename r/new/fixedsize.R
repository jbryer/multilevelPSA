fixedsize <- function(p, width=unit(1, "npc"), height=unit(1, "npc"), ...) {
	g <- ggplotGrob(p)
	xtitle <- editGrob(getGrob(g, "axis.title.x.text", grep = TRUE), vp = NULL)
	ytitle <- editGrob(getGrob(g, "axis.title.y.text", grep = TRUE), vp = NULL)
	xlabels <- editGrob(getGrob(g, "axis.text.x.text", grep = TRUE), vp = NULL)
	ylabels <- editGrob(getGrob(g, "axis.text.y.text", grep = TRUE), vp = NULL)
	
	legends <- if (!is.null(g$children$legends)) 
				editGrob(g$children$legends, vp = NULL) else ggplot2:::.zeroGrob
	dots <- list(...)
	
	gTree(children=gList(g),
			width=width, 
			height=height, 
			xtitle=xtitle,
			ytitle=ytitle,
			xlabels=xlabels,
			ylabels=ylabels,
			legends=legends,
			dots=dots,
			name=NULL, gp=NULL,
			cl="fixed")
}

preDrawDetails.fixed <- function(x) {
	heights.bottom <- grobHeight(x$xtitle) + grobHeight(x$xlabels)
	widths.left <- grobWidth(x$ytitle) + grobWidth(x$ylabels)
	widths.right <- grobWidth(x$legends)
	full.width <- convertUnit(x$width + widths.left + widths.right, "in")
	full.height <- convertUnit(x$height + heights.bottom , "in")
	pushViewport(do.call(viewport, c(list(width=full.width, height=full.height), x$dots)),
			recording=FALSE)
}

postDrawDetails.fixed <- function(x) {
	popViewport(recording=FALSE)
}

drawDetails.fixed <- function(x, recording=TRUE) {
	grid.draw(x$children)
}

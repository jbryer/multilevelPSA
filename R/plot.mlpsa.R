#' Plots the results of a multilevel propensity score model.
#'
#' The plot created uses the \code{ggplot2} framework. As such, additional modificaitons
#' can be made. This plot is an extension of the \code{circ.psa} function in the
#' \code{PSAgraphics} package for multilevel models.
#'
#' @param x the results of \code{\link{mlpsa}}.
#' @param ratio the ratio of the size of the distribution plots (left and bottom)
#'        to the circular plot.
#' @param plotExtra a plot to place in the lower left corner.
#' @param ... parameters passed to \code{\link{plot.mlpsa.circ}} and 
#'        \code{\link{plot.mlpsa.distribution}}
#' @S3method plot mlpsa
#' @method plot mlpsa
#' @export
plot.mlpsa <- function(x, ratio=c(1,2), plotExtra=NULL, ...) {
	stopifnot(is.mlpsa(x))
	mlpsa = x
	
	pcirc = plot.mlpsa.circ(mlpsa, legendlab=FALSE, ...) + 
				theme(legend.position='none') +
				xlab(NULL) + ylab(NULL)
	px = plot.mlpsa.distribution(mlpsa, treat=names(mlpsa$level2.summary)[4],
						flip=TRUE, label=names(mlpsa$level2.summary)[4], ...) +
				theme(legend.position='none')#, axis.text.x=element_blank())
	py = plot.mlpsa.distribution(mlpsa, treat=names(mlpsa$level2.summary)[5],
						flip=FALSE, label=names(mlpsa$level2.summary)[5], ...) +
				theme(legend.position='none')#, axis.text.y=element_blank())
	
	grid_layout = grid.layout(nrow=2, ncol=2, widths=c(ratio[1:2]), heights=ratio[2:1], respect=TRUE)
	grid.newpage()
	pushViewport( viewport( layout=grid_layout ) )
	multilevelPSA:::align.plots(grid_layout, list(pcirc, 1, 2), list(px, 2, 2), list(py, 1, 1))
	if(!is.null(plotExtra)) {
		pushViewport(viewport(layout.pos.row=2, layout.pos.col=1, just=c("center", "center")))
		grid.draw(ggplotGrob(plotExtra))
	}
}

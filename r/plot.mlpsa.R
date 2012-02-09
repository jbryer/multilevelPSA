#' Plots the results of a multilevel propensity score model.
#'
#' The plot created uses the \code{ggplot2} framework. As such, additional modificaitons
#' can be made. This plot is an extension of the \code{circ.psa} function in the
#' \code{PSAgraphics} package for multilevel models.
#'
#' @param mlpsa 
#' @S3method plot mlpsa
#' @method plot mlpsa
#' @export
plot.mlpsa <- function(mlpsa, ...) {
	#TODO: get proper names of treatment vars
	pcirc = plot.mlpsa.circ(mlpsa, legendlab=FALSE) + 
				opts(legend.position='none', 
				axis.text.x=theme_blank(), axis.text.y=theme_blank()) + 
				xlab(NULL) + ylab(NULL)
	px = plot.mlpsa.distribution(mlpsa, treat=names(mlpsa$level2.summary)[4],
						flip=TRUE, label=names(mlpsa$level2.summary)[4]) +
				opts(legend.position='none', axis.text.y=theme_blank())
	py = plot.mlpsa.distribution(mlpsa, treat=names(mlpsa$level2.summary)[5],
						flip=FALSE, label=names(mlpsa$level2.summary)[5]) +
				opts(legend.position='none', axis.text.x=theme_blank())
	pdiff = plot.difftable(mlpsa)
	
	#Circ top right
	grid_layout <- grid.layout(nrow=2, ncol=2, widths=c(1,2), heights=c(2,1), respect=TRUE)
	grid.newpage()
	pushViewport( viewport( layout=grid_layout ) )
	align.plots(grid_layout, list(pcirc, 1, 2), list(px, 2, 2), list(py, 1, 1))
	pushViewport(viewport(layout.pos.row=2, layout.pos.col=1, just=c("center", "center")))
	grid.draw(ggplotGrob(pdiff))
}

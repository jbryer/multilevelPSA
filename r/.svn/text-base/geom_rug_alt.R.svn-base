#' @include package.R
NA

require(ggplot2)

#'
#' @export GeomRugAlt
GeomRugAlt <- proto(Geom, {
	draw <- function(., data, scales, coordinates, ...) {
		rugs <- list()
		data <- coordinates$transform(data, scales)    
		if (!is.null(data$x)) {
			rugs$x <- with(data, segmentsGrob(
							x0 = unit(x, "native"), x1 = unit(x, "native"), 
							#y0 = unit(max(y) + 0.02, "npc"), y1 = unit(max(y) + 0.05, "npc"),
							y0 = unit(.97, "npc"), y1 = unit(1, "npc"),
							gp = gpar(col = alpha(colour, alpha), lty = linetype, lwd = size * .pt)
					))
		}  
		
		if (!is.null(data$y)) {
			rugs$y <- with(data, segmentsGrob(
							y0 = unit(y, "native"), y1 = unit(y, "native"), 
							#x0 = unit(max(x) + 0.02, "npc"), x1 = unit((max(x) + 0.05), "npc"),
							x0 = unit(.97, "npc"), x1 = unit(1, "npc"),
							gp = gpar(col = alpha(colour, alpha), lty = linetype, lwd = size * .pt)
					))
		}  
		
		gTree(children = do.call("gList", rugs))
	}
	
	objname <- "rug_alt"
	
	desc <- "Marginal rug plots"
	
	default_stat <- function(.) StatIdentity
	default_aes <- function(.) aes(colour="black", size=0.5, linetype=1, alpha = 1)
	guide_geom <- function(.) "path"
	
	examples <- function(.) {
		p <- ggplot(mtcars, aes(x=wt, y=mpg))
		p + geom_point()
		p + geom_point() + geom_rug_alt()
		p + geom_point() + geom_rug_alt(position='jitter')
	}			
})

#' A ggplot2 alternate rug geomtry.
#' 
#' This creates an additional ggplot2 geometry \code{geom_rug_alt} which allows
#' for rug plots to be placed on the top and right of the graph. 
#' 
#' @references \url{http://stackoverflow.com/questions/4867597/can-you-easily-plot-rugs-axes-on-the-top-right-in-ggplot2}
#' @author Jason Bryer \email{jason@@bryer.org}
#' @author William Doane
#' @export geom_rug_alt
geom_rug_alt <- GeomRugAlt$build_accessor()

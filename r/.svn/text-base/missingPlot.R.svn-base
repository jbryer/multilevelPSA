#' @include package.R
NA

#' Returns a heat map graphic representing missinging of variables grouped by
#' the given grouping vector.
#' 
#' TODO: Need more details
#' 
#' @param vars a data frame containing the variables to visualize missingness
#' @param grouping a vector of length nrow(vars) corresponding to how missing will be grouped by
#' @param grid whether to draw a grid between tiles
#' @return a ggplot2 expression
#' @export missingPlot
missingPlot <- function(vars, grouping, grid=FALSE) {
	empty <- plyr::empty
	
	Layout <- grid.layout(nrow = 1, ncol = 2)
	vplayout <- function(...) {
		grid.newpage()
		pushViewport(viewport(layout = Layout))
	}
	subplot <- function(x, y) { viewport(layout.pos.row = x, layout.pos.col = y) }
	mplot <- function(p1, p2, p3, p4) {
		vplayout()
		print(p2, vp = subplot(1, 2))
		print(p1, vp = subplot(1, 1))
		#print(p3, vp = subplot(3, 1))
		#print(p4, vp = subplot(4, 1))
	}
	
	colMissing = apply(vars, 2, function(x) sum(is.na(x))) / nrow(vars)
	colMissing = 100 * colMissing
	colMissing = data.frame(x=names(colMissing), y=as.numeric(colMissing))
	phist = ggplot(colMissing, aes(x=x, y=y, fill=y)) + geom_bar() + coord_flip()
	phist = phist + xlab(NULL) + ylab(NULL)
	phist = phist + opts(axis.text.x=theme_text(size=6, angle=-90, hjust=0, vjust=.5), axis.text.y=theme_blank(), axis.ticks=theme_blank())
	phist = phist + scale_fill_gradient('Missingness', low='white', high='red', limits=c(0,100), breaks=seq(0, 100, 10), labels=paste(seq(0,100,10), '%', sep=''))
	phist = phist + geom_text(aes(label=round(y, digits=0)), size=2)
	phist = phist + scale_x_discrete(expand=c(0,0)) + scale_y_continuous(expand=c(0,5))
	
	grouping = as.character(grouping)
	grouping[is.na(grouping)] = 'Unknown'
	grouping = as.factor(grouping)
	testing.NA = matrix(ncol=length(levels(grouping)), nrow=(ncol(vars)))
	for(i in 1:(dim(vars)[2])) {
		testing.NA[i,] = tapply(vars[[i]], grouping, function(x) sum(is.na(x)) / length(x))
	}
	testing.NA = testing.NA * 100
	dimnames(testing.NA) = list(names(vars), unique(grouping))
	testing.NA2 = melt(testing.NA)
	p = ggplot(testing.NA2, aes(x=X2, y=X1, fill=value))
	if(grid) {
		p = p + geom_tile(colour='grey')
	} else {
		p = p + geom_tile()
	}
	p = p + xlab(NULL) + ylab(NULL)
	p = p + opts(axis.ticks=theme_blank(), axis.text.y=theme_text(size=6, hjust=1, vjust=.5), axis.text.x=theme_text(size=6, angle=-90, hjust=0, vjust=.5))
	p = p + scale_fill_gradient('Missingness', legend=FALSE, low='white', high='red', breaks=seq(0, 100, 10), labels=paste(seq(0,100,10), '%', sep=''))
	p = p + geom_text(aes(label=round(value, digits=0)), size=2, colour='black')
	p = p + scale_x_discrete(expand=c(0,0)) + scale_y_discrete(expand=c(0,0))
	theme_update(panel.background=theme_blank(), panel.grid.major=theme_blank(), panel.border=theme_blank())
	pfinal = mplot(p + opts(plot.margin=unit(c(0, -13, 0, 0), "lines")), phist + geom_hline(yintercept=0) + opts(plot.margin=unit(c(0.05,0,2.6,12), "lines")))
	
	return(pfinal)
}

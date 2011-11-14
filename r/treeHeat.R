#' Heat map representing variables used in a conditional inference tree across level 2 variables.
#' 
#' TODO: Need more details
#' 
#' @return a ggplot2 expression
#' @export treeHeat
treeHeat <- function(trees, colNames, level2Col, colLabels=NULL) {
	ncol = length(colNames) + 1
	tree.df <- as.data.frame(matrix(nrow=length(unique(level2Col)), ncol=ncol))
	names(tree.df) = c('level2', colNames)
	tree.df[,2:ncol(tree.df)] = as.numeric(NA)
	tree.df[,1] = unique(level2Col)
	
	convertTree <- function(tree.df.row, node, depth, tree.party) {
		nodeVal = nodes(tree.party, node)[[1]]
		varName = as.character(nodeVal$psplit)[7]
		if(nodeVal$terminal) {
			#Do nothing
		} else {
			tree.df.row[varName] = min(depth, tree.df.row[varName][1,1], na.rm=TRUE)
			tree.df.row = convertTree(tree.df.row, nodes(tree.party, node)[[1]]$left[[1]], depth+1, tree.party)
			tree.df.row = convertTree(tree.df.row, nodes(tree.party, node)[[1]]$right[[1]], depth+1, tree.party)
		}
		tree.df.row
	}
	
	for(i in names(trees)) {
		tree.df[which(tree.df[,1] == i),] = convertTree(tree.df[which(tree.df[,1] == i),], 1, 1, trees[[i]])
	}
	
	tree.df.m <- melt(tree.df[which(tree.df$level2 %in% unique(level2Col)),], id='level2')
	tree.df.m$level2 = as.factor(as.character(tree.df.m$level2))
	descColName = 'variable'
	if(!is.null(colLabels)) {
		tree.df.m = merge(tree.df.m, colLabels, by.x='variable', by.y=names(colLabels)[1], all.x=TRUE)
		descColName = names(colLabels)[2]
	}
	#Labels
	value.freq = as.data.frame(table(tree.df.m[!is.na(tree.df.m$value),]$variable))
	level2.freq = as.data.frame(table(tree.df.m[!is.na(tree.df.m$value),]$level2))
	tree.df.m = merge(tree.df.m, level2.freq, by.x='level2', by.y='Var1', all.x=TRUE)
	tree.df.m = merge(tree.df.m, value.freq, by.x='variable', by.y='Var1', all.x=TRUE)
	names(tree.df.m)[(ncol(tree.df.m)-1):ncol(tree.df.m)] = c('level2.Freq', 'Var.Freq')
	tree.df.m$Desc = as.character(tree.df.m[,descColName])
	tree.df.m$level2 = as.character(tree.df.m$level2)
	
	p = ggplot(tree.df.m, aes(level2, Desc)) + geom_text(data=tree.df.m[!duplicated(tree.df.m$level2),], aes(x=level2, y='', label=level2.Freq), size=2, angle=-90, hjust=.5) +
			geom_text(data=tree.df.m[!duplicated(tree.df.m$variable),], aes(y=Desc, x='', label=Var.Freq), size=2, hjust=.5) +
			geom_tile(aes(fill = value)) + scale_fill_gradient("Depth", high = "lightgrey", low = "steelblue") + 
			opts(axis.text.y=theme_text(size=6, hjust=0, vjust=.5), axis.text.x=theme_text(size=6, angle=-90, hjust=0, vjust=.5), axis.ticks=theme_blank()) + 
			xlab(NULL) + ylab(NULL)
	return(p)
}
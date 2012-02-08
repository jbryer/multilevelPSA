require(multilevelPSA)
require(party)
data(pisana)
data(pisanaschool)

pkgdir = system.file(package='multilevelPSA')
source(paste(pkgdir, '/demo/pisa.setup.R', sep=''))

school = pisanaschool[,c('COUNTRY', "CNT", "SCHOOLID",
						"SC02Q01", #Public (1) or private (2)
						"STRATIO" #Student-teacher ratio 
						 )]
names(school) = c('COUNTRY', 'CNT', 'SCHOOLID', 'PUBPRIV', 'STRATIO')
school$SCHOOLID = as.integer(school$SCHOOLID)

student = pisana[,psa.cols]
student$CNT = as.character(student$CNT)
student = ddply(student, 'CNT', recodePISA, .progress='text')
student = merge(student, school, by=c('CNT', 'SCHOOLID'), all.x=TRUE)
student = student[!is.na(student$PUBPRIV),] #Remove rows with missing PUBPRRIV
table(student$CNT, student$PUBPRIV, useNA='ifany')

#Use conditional inference trees from the party package
mlctree = mlpsa.ctree(student[,c(1,5:48,68)], formula=PUBPRIV ~ ., level2='CNT')
student.party = getStrata(mlctree, student, level2='CNT')

student.party$mathscore = apply(student.party[,c('PV1MATH','PV2MATH','PV3MATH','PV4MATH','PV5MATH')], 1, sum) / 5
student.party$readscore = apply(student.party[,c('PV1READ','PV2READ','PV3READ','PV4READ','PV5READ')], 1, sum) / 5
student.party$sciescore = apply(student.party[,c('PV1SCIE','PV2SCIE','PV3SCIE','PV4SCIE','PV5SCIE')], 1, sum) / 5

#plot.tree(mlctree, psa.cols[c(4:48)], student.party$level2, colLabels=psa.cols.names)

results.psa.math = mlpsa(response=student.party$mathscore, treatment=student.party$PUBPRIV, strata=student.party$strata, level2=student.party$CNT, minN=5)
summary(results.psa.math)
ls(results.psa.math)

results.psa.math$level1.summary
results.psa.math$level2.summary

plot(results.psa.math)
plot.mlpsa.difference(results.psa.math, sd=mean(student$mathscore, na.rm=TRUE))


plot.mlpsa.circ(results.psa.math, legendlab=FALSE) #+ opts(legend.position='none')
plot.mlpsa.distribution(results.psa.math)



##### Experimental
pcirc = plot(results.psa.math, xlab='Public', ylab='Private', legendlab=FALSE, 
			 level1.plot=FALSE, level1.rug.plot=NULL, level1.projection.lines=FALSE,
			 weighted.means=FALSE, level2.rug.plot=NULL, level2.projection.lines=TRUE) + 
			 opts(legend.position='none') + xlab(NULL) + ylab(NULL)
ppublic = plot.mlpsa.distribution(results.psa.math, treat='Public', flip=TRUE, label='Public')
pprivate = plot.mlpsa.distribution(results.psa.math, treat='Private', flip=FALSE, label='Private')
pdiff = plot.difftable(results.psa.math)

#Circ top right
grid_layout <- grid.layout(nrow=2, ncol=2, widths=c(1,2), heights=c(2,1), respect=TRUE)
grid.newpage()
pushViewport( viewport( layout=grid_layout ) )
align.plots(grid_layout, list(pcirc, 1, 2), list(ppublic, 2, 2), list(pprivate, 1, 1))
pushViewport(viewport(layout.pos.row=2, layout.pos.col=1, just=c("center", "center")))
grid.draw(ggplotGrob(pdiff))

#Circ bottom left
grid_layout <- grid.layout(nrow=2, ncol=2, widths=c(2,1), heights=c(1,2), respect=TRUE)
grid.newpage()
pushViewport( viewport( layout=grid_layout ) )
align.plots(grid_layout, list(pcirc, 2, 1), list(pprivate, 2, 2), list(ppublic, 1, 1))

library(gridExtra)
grid.arrange(pcirc, #+ opts(plot.margin=unit(c(2,2,2,2),'cm')),
			 ppublic + opts(plot.margin=unit(c(0,2,0,2),'cm')))

#####
Layout <- grid.layout(nrow = 2, ncol = 2, 
					  widths = unit(c(1, 2), c("null", "null")), 
					  heights = unit(c(2, 1), c("null", "null")))
vplayout <- function(...) {
	grid.newpage()
	pushViewport(viewport(layout = Layout))
}
subplot <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
vplayout()
print(pcirc, vp = subplot(1, 2))
print(pprivate, vp = subplot(1, 1))
print(ppublic, vp = subplot(2, 2))

####
# http://learnr.wordpress.com/2009/04/01/ggplot2-marimekko-replacement-2-by-2-panel/
Layout <- grid.layout(nrow = 2, ncol = 3, widths = unit(c(4,
			2, 2), c("lines", "null", "null")), heights = unit(c(1,
														  													 1, 1), c("null", "null", "null")))
grid.show.layout(Layout)
vplayout <- function(...) {
	grid.newpage()
	pushViewport(viewport(layout = Layout))
}
subplot <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
mmplot <- function(a, b, c, d, e, f) {
	vplayout()
	print(a, vp = subplot(1, 1:2))
	print(b, vp = subplot(1, 2))
	print(c, vp = subplot(1, 3))
	print(d, vp = subplot(2, 1:2))
	print(e, vp = subplot(2, 2))
	print(f, vp = subplot(2, 3))
}
formatter <- function(x, prefix = "$") {
	ifelse(x > 999999999, paste(prefix, comma(x/1e+09,
					nsmall = 1), "bn", sep = ""), ifelse(x >
				  	999999, paste(prefix, comma(x/1e+06),
					"m", sep = ""), ifelse(x > 999, paste(prefix,
					comma(x/1000), "k", sep = ""), paste(prefix,
					comma(x), sep = ""))))
}

#####
source('https://raw.github.com/jbryer/multilevelPSA/master/r/align.R')
require(psych)
df = data.frame(x=rnorm(100, mean=50, sd=10),
				y=rnorm(100, mean=48, sd=10),
				group=rep(letters[1:10], 10))
dfx = describe.by(df$x, df$group, mat=TRUE)[,c('group1', 'mean', 'n', 'min', 'max')]
names(dfx) = c('group', 'x', 'x.n', 'x.min', 'x.max')
dfy = describe.by(df$y, df$group, mat=TRUE)[,c('group1', 'mean', 'n', 'min', 'max')]
names(dfy) = c('group', 'y', 'y.n', 'y.min', 'y.max')
df2 = cbind(dfx, dfy[,2:ncol(dfy)])
range = c(0,100)

p1a = ggplot(df2, aes(x=x, y=y, colour=group)) + geom_point() + opts(legend.position='none') +
	scale_x_continuous(limits=range) + scale_y_continuous(limits=range)
p1 = p1a + coord_equal(ratio=1) + xlab(NULL) + ylab(NULL)
p2 = ggplot(df, aes(x=x, y=group, colour=group)) + geom_point() + scale_x_continuous(limits=range) + opts(legend.position='none')
p3 = ggplot(df, aes(x=group, y=y, colour=group)) + geom_point() + scale_y_continuous(limits=range) + opts(legend.position='none')

# The alignment top to bottom does not work with coord_equal
grid_layout <- grid.layout(nrow=2, ncol=2, widths=c(1,2), heights=c(2,1), respect=TRUE)
grid.newpage()
pushViewport( viewport( layout=grid_layout, width=1, height=1 ) )
align.plots(grid_layout, list(p1, 1, 2), list(p3, 1, 1), list(p2, 2, 2))

# Remove and the align top to bottom works
grid_layout <- grid.layout(nrow=2, ncol=2, widths=c(1,2), heights=c(2,1))
grid.newpage()
pushViewport( viewport( layout=grid_layout, width=1, height=1 ) )
align.plots(grid_layout, list(p1a, 1, 2), list(p3, 1, 1), list(p2, 2, 2))

# Try gtable
gt = gtable(unit(1:2,'cm'), unit(2:1,'cm'))
#gtable_show_layout(gt)
gt = gtable_add_grob(gt, pcirc, 1,2)
gt = gtable_add_grob(gt, pprivate, 1,1)
gt = gtable_add_grob(gt, ppublic, 2,2)
plot(gt)



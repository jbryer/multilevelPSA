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


plotcirc.multilevel.psa(results.psa.math, xlab='Public', ylab='Private', legendlab=FALSE, level1.plot=FALSE, level1.rug.plot=NULL, level1.projection.lines=FALSE) + opts(legend.position='none')
plot.multilevel.distribution(results.psa.math)



##### Experimental
p1 = plotcirc.multilevel.psa(results.psa.math, xlab='Public', ylab='Private', legendlab=FALSE, level1.plot=FALSE, level1.rug.plot=NULL, level1.projection.lines=FALSE) + opts(legend.position='none') +
	xlab(NULL) + ylab(NULL) #opts(legend.position=c(.88,.25)) +  scale_size_continuous('Sample Size') 
p2 = plot.multilevel.distribution(results.psa.math, x='level2', y='Public', flip=TRUE)
p3 = plot.multilevel.distribution(results.psa.math, x='level2', y='Private', flip=FALSE)


grid_layout <- grid.layout(nrow=2, ncol=2, widths=c(1,2), heights=c(2,1))
grid.newpage()
pushViewport( viewport( layout=grid_layout ) )
align.plots(grid_layout, list(p3, 1, 1), list(p1, 1, 2), list(p2, 2, 2))



grid.arrange(p1,p2)




l1 = results.psa.math$level1.summary
l2 = results.psa.math$level2.summary
l1$Panel = 'Level 1'
l2$Panel = 'Level 2'
l1 = l1[,c('Public', 'Private', 'Panel')]
l2 = l2[,c('xmark', 'ymark' , 'Panel')])
names(l2) = names(l1)

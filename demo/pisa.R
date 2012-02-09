require(multilevelPSA)
require(party)
data(pisana)
data(pisanaschool)

pkgdir = system.file(package='multilevelPSA')
source(paste(pkgdir, '/pisa/pisa.setup.R', sep=''))

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

# These are the two main plots
plot(results.psa.math)
plot.mlpsa.difference(results.psa.math, sd=mean(student$mathscore, na.rm=TRUE))

# Or the individual components of the main plot separately
plot.mlpsa.circ(results.psa.math, legendlab=FALSE) #+ opts(legend.position='none')
plot.mlpsa.distribution(results.psa.math, 'Public')
plot.mlpsa.distribution(results.psa.math, 'Private')


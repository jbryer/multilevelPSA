require(multilevelPSA)
require(party)
data(pisana)
data(pisanaschool)

pkgdir = system.file(package='multilevelPSA')
source(paste(pkgdir, '/pisa/pisa.setup.R', sep=''))

student <- NULL
school <- NULL
if(require(pisa, quietly=TRUE)) {
	data(pisa.student)
	data(pisa.school)
	student = pisa.student[,psa.cols]
	school = pisa.school[,c('COUNTRY', "CNT", "SCHOOLID",
							"SC02Q01", #Public (1) or private (2)
							"STRATIO" #Student-teacher ratio 
	)]
} else {
	data(pisana)
	student = pisana[,psa.cols]
	school = pisanaschool[,c('COUNTRY', "CNT", "SCHOOLID",
							 "SC02Q01", #Public (1) or private (2)
							 "STRATIO" #Student-teacher ratio 
	)]
	student = ddply(student, 'CNT', recodePISA, .progress='text')
}

names(school) = c('COUNTRY', 'CNT', 'SCHOOLID', 'PUBPRIV', 'STRATIO')
school$SCHOOLID = as.integer(school$SCHOOLID)
school$CNT = as.character(school$CNT)

student$SCHOOLID = as.integer(student$SCHOOLID)
student$CNT = as.character(student$CNT)
student = merge(student, school, by=c('CNT', 'SCHOOLID'), all.x=TRUE)
student = student[!is.na(student$PUBPRIV),] #Remove rows with missing PUBPRRIV
table(student$CNT, student$PUBPRIV, useNA='ifany')
prop.table(table(student$CNT, student$PUBPRIV, useNA='ifany'), 1) * 100

#Use conditional inference trees from the party package
#For North America
#mlctree = mlpsa.ctree(student[,c(1,5:48,68)], formula=PUBPRIV ~ ., level2='CNT')
#For full dataset
mlctree = mlpsa.ctree(student[,c(1,5:48,65)], 
					  formula=PUBPRIV ~ ., level2='CNT')
student.party = getStrata(mlctree, student, level2='CNT')

#Tree heat map showing relative importance of covariates used in each tree.
plot.tree(mlctree, level2Col=student$CNT)

#NOTE: This is not entirely correct but is sufficient for visualization purposes.
#See mitools package for combining multiple plausible values.
student.party$mathscore = apply(student.party[,c('PV1MATH','PV2MATH','PV3MATH','PV4MATH','PV5MATH')], 1, sum) / 5
student.party$readscore = apply(student.party[,c('PV1READ','PV2READ','PV3READ','PV4READ','PV5READ')], 1, sum) / 5
student.party$sciescore = apply(student.party[,c('PV1SCIE','PV2SCIE','PV3SCIE','PV4SCIE','PV5SCIE')], 1, sum) / 5

results.psa.math = mlpsa(response=student.party$mathscore, 
						 treatment=student.party$PUBPRIV, 
						 strata=student.party$strata, 
						 level2=student.party$CNT, minN=5)
summary(results.psa.math)
ls(results.psa.math)

results.psa.math$overall.ci

results.psa.math$level1.summary
viewData(results.psa.math$level2.summary)

# These are the two main plots
plot(results.psa.math)
plot.mlpsa.difference(results.psa.math,
					  sd=mean(student.party$mathscore, na.rm=TRUE))

# Or the individual components of the main plot separately
plot.mlpsa.circ(results.psa.math, legendlab=FALSE) #+ opts(legend.position='none')
plot.mlpsa.distribution(results.psa.math, 'Public')
plot.mlpsa.distribution(results.psa.math, 'Private')


require(multilevelPSA)
require(party)
require(mice)
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
prop.table(table(student$CNT, student$PUBPRIV, useNA='ifany'), 1) * 100

cnt = 'USA' #Can change this to USA, MEX, or CAN
student2 = student[student$CNT == cnt,]

prop.table(table(student2$PUBPRIV, useNA='ifany')) * 100
if(file.exists(paste('pisa.student.mice.', cnt, '.rda', sep=''))) {
	load(paste('pisa.student.mice.', cnt, '.rda', sep=''))
} else {
	student.toimpute = student2[,c(5:48)]
	student.mice = mice(student.toimpute, m=1)
	save(student.mice, file=paste('pisa.student.mice.', cnt, '.rda', sep=''))
}

student.complete = complete(student.mice, 1)
student.complete$PUBPRIV = student2$PUBPRIV
table(student.complete$PUBPRIV, useNA='ifany')
prop.table(table(student.complete$PUBPRIV, useNA='ifany')) * 100
student.complete$PUBPRIV = as.integer(student.complete$PUBPRIV) - 1

psranges <- psrange(student.complete, student.complete$PUBPRIV, PUBPRIV ~ ., nsteps=10, nboot=5)
plot(psranges) + labs(title=paste('Propensity Score Ranges for ', cnt, sep=''))
summary(psranges)

ntreat <- length(which(student.complete$PUBPRIV == 1))
ncontrol <- length(which(student.complete$PUBPRIV == 0))
samples <- seq(ntreat, ncontrol, by=ntreat)
psranges2 <- psrange(student.complete, student.complete$PUBPRIV, PUBPRIV ~ ., samples=samples)
plot(psranges2)

rows <- c(which(student.complete$PUBPRIV == 1),
		  sample(which(student.complete$PUBPRIV == 0), 
		  	   3 * length(which(student.complete$PUBPRIV == 1)) ) )
lr.results <- glm(PUBPRIV ~ ., data=student.complete[rows,], family='binomial')
st = data.frame(ps=fitted(lr.results), 
				math=apply(student2[rows,paste('PV', 1:5, 'MATH', sep='')], 1, mean), 
				pubpriv=student.complete[rows,]$PUBPRIV)
st$treat = as.logical(st$pubpriv)
table(st$treat)
plot.loess(st$ps, response=st$math, treatment=st$treat, 
		   percentPoints.control = 0.4, percentPoints.treat=0.4)


require(multilevelPSA)
if(require(pisa, quietly=TRUE)) {
	data(pisa.student)
	student = pisa.student[,psa.cols]
} else {
	data(pisana)
	student = pisana[,psa.cols]
}
pkgdir = system.file(package='multilevelPSA')
source(paste(pkgdir, '/pisa/pisa.setup.R', sep=''))
student$CNT = as.character(student$CNT)
plot.missing(student[,c(5:48)], student$CNT)

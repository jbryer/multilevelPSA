require(multilevelPSA)
if(require(pisa, quietly=TRUE)) {
	data(pisa.student)
	data(pisa.psa.cols)
	student = pisa.student[,c('CNT', pisa.psa.cols)]
	student$CNT = as.character(student$CNT)
	missing.plot(student, student$CNT)
} else {
	message("pisa package not loaded. Try\nrequire(devtools)\ninstall_github('pisa','jbryer')")
}

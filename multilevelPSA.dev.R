install.packages(c('devtools', 'roxygen2', 'RSQLite', 'ipeds'), 
		repos=c('http://cran.r-project.org', 'http://r-forge.r-project.org'))

require(devtools)
require(roxygen2)
require(ggplot2)

setwd("~/Dropbox/Projects") #Mac
setwd("C:/Dropbox/My Dropbox/Projects") #Windows

#Package building
document("multilevelPSA", clean=TRUE)
document("multilevelPSA")
check_doc("multilevelPSA")
build("multilevelPSA", binary=FALSE)
build("multilevelPSA", binary=TRUE)
install("multilevelPSA")
check("multilevelPSA")
library(multilevelPSA)
ls('package:multilevelPSA')

#Build Vignette
setwd("C:/Dropbox/My Dropbox/Projects/multilevelPSA")
setwd(paste(getwd(), '/man/doc/', sep=''))
getwd()
Stangle('multilevelPSA.Rnw')
Sweave('multilevelPSA.Rnw')
texi2dvi('multilevelPSA.tex', pdf=TRUE)

#Load included data
data(pisa.student)
data(pisa.school)


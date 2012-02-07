install.packages(c('devtools', 'roxygen2', 'RSQLite', 'ipeds'), 
		repos=c('http://cran.r-project.org', 'http://r-forge.r-project.org'))

require(devtools)
require(roxygen2)
require(ggplot2)

setwd("~/Dropbox/Projects") #Mac
setwd("C:/Dropbox/My Dropbox/Projects") #Windows
getwd()

#Package building
document("multilevelPSA", clean=TRUE)
document("multilevelPSA")
check_doc("multilevelPSA")
run_examples("multilevelPSA")
build("multilevelPSA", binary=FALSE)
build("multilevelPSA", binary=TRUE)
install("multilevelPSA")
check("multilevelPSA")
library(multilevelPSA)
ls('package:multilevelPSA')



test('multilevelPSA')
test_package('multilevelPSA')

test_file('multilevelPSA/inst/tests/test-pisa.R')

#Load included data
data(pisana)
data(pisanaschool)


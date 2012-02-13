install.packages(c('devtools', 'roxygen2', 'ggplot2', 'PSAgraphics'), 
		repos=c('http://cran.r-project.org', 'http://r-forge.r-project.org'))

require(devtools)
require(roxygen2)
require(ggplot2)
require(PSAgraphics)

setwd("~/Dropbox/Projects") #Mac
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

tools::resaveRdaFiles(paste(getwd(), '/multilevelPSA/data', sep=''))

test('multilevelPSA')
test_package('multilevelPSA')

test_file('multilevelPSA/inst/tests/test-pisa.R')

#Load included data
data(pisana)
data(pisanaschool)


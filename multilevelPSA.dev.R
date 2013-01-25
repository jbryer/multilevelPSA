require(devtools)
require(ggplot2)
require(PSAgraphics)
require(proto)

setwd("~/Dropbox/Projects") #Mac
getwd()

#Package building
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

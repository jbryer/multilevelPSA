require(devtools)
setwd("~/Dropbox/Projects") #Mac

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

release('multilevelPSA')

#Discussion of the Notes generated with ggplot2
#http://stackoverflow.com/questions/9439256/
#     how-can-i-handle-r-cmd-check-no-visible-binding-for-global-variable-notes-when
#Told that the package will not pass with these NOTEs, using utils::globalVariables

##### Rd2markdown ##############################################################
require(Rd2markdown)
frontmatter <- '---
layout: default
title: multilevelPSA
subtitle: Multilevel Propensity Score Analysis
submenu: multilevelPSA
---'
Rd2markdown('multilevelPSA', outdir='~/Dropbox/Projects/jbryer.github.com/multilevelPSA/docs/',
			front.matter=frontmatter, run.examples=TRUE)

##### Data setup ###############################################################
source('multilevelPSA/inst/pisa/pisa.setup.R')
for(i in 1:ncol(pisa.colnames)) {
	pisa.colnames[,i] <- as.character(pisa.colnames[,i])
}
save(pisa.colnames, file='multilevelPSA/data/pisa.colnames.rda')
require(pisa)
require(mice)
countries <- c('Canada','Mexico','United States')
data(pisa.student)
data(pisa.school)
pisa.student$CNT <- as.character(pisa.student$CNT)
pisana <- pisa.student[pisa.student$CNT %in% countries,psa.cols]
table(pisana$CNT, useNA='ifany')
names(pisana); nrow(pisana); ncol(pisana)
pisanaschool <- pisa.school[pisa.school$CNT %in% countries,
							c("CNT", "SCHOOLID",
							  "SC02Q01", #Public (1) or private (2)
							  "STRATIO")] #Student-teacher ratio 
names(pisanaschool) <- c('CNT','SCHOOLID','PUBPRIV','STRATIO')
pisana <- merge(pisana, pisanaschool, by=c('CNT','SCHOOLID'), all.x=TRUE)
table(is.na(pisana$PUBPRIV))
pisana <- pisana[!is.na(pisana$PUBPRIV),]
nrow(pisana)
str(pisana)
pisana <- merge(pisa.countries, pisana, by.x='Country', by.y='CNT', all.y=TRUE)
names(pisana)[which(names(pisana) == 'CNT3')] <- 'CNT'
pisana.mice <- mice(pisana[,psa.cols[4:48]], m=1)
pisana <- cbind(pisana[,1:3], complete(pisana.mice), pisana[,49:ncol(pisana)])
for(i in which(unlist(lapply(pisana, class)) == 'factor')) {
	pisana[,i] <- as.factor(as.character(pisana[,i]))
}
save(pisana, file='multilevelPSA/data/pisana.rda')
tools::resaveRdaFiles(paste(getwd(), '/multilevelPSA/data', sep=''))

#### Fix non UTF-8 issue
require(multilevelPSA)
data(pisana)
data(pisa.colnames)
tools:::showNonASCII(pisana)
tools:::showNonASCII(pisa.colnames)
apply(pisana, 2, FUN=function(x) { tools:::showNonASCII(unique(x)) } )
apply(pisa.colnames, 2, tools:::showNonASCII)
table(pisana$ST23Q01, useNA='ifany')
levels(pisana$ST23Q01)[4] <- "I don't read for enjoyment"


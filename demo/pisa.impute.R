imputePISA <- function(student, school) {
	tmp = student[,5:48]
	names(tmp) = psa.cols.names[5:48,3]
	missingPlot(tmp, student$CNT, grid=FALSE)
	
	student$CNT = as.character(student$CNT)
	school$CNT = as.character(school$CNT)
	badCountries = c('JPN', 'KOR', 'POL') 
	amelia.results <<- list()
	mice.results <<- list()
	imputePlyr <- function(x) {
		#x2 = merge(x, school[which(school$CNT == x[1,'CNT']),], by=c('CNT', 'SCHOOLID'), all.x=TRUE)
		#x2 = x2[!is.na(x2$PUBPRIV),] #Remove rows with missing PUBPRRIV
		tmp = x[,c(5:48)]
		v1 = x[1,'CNT']
		print(paste('Imputing for ', v1, '...', sep=''))
		if(class(amelia.results[[v1]]) == "amelia") {
			a.out = amelia.results[[v1]]
			complete = a.out$imputations[[5]]
		} else if(class(mice.results[[v1]]) == 'mids') {
			m.out = mice.results[[v1]]
			complete = complete(m.out, 5)
		} else {
			if(v1 %in% badCountries) {
				#This is a bit of a hack, but we need to remove this column for these countries since there is 100% missingness
				tmp$ST07Q01 = NULL
				tmp$ST06Q01 = NULL
			}
			#a.out = amelia(x=tmp, m=5, noms=names(tmp))
			#complete = a.out$imputations[[5]]
			#amelia.results[[as.character(v1)]] <<- a.out
			m.out = mice(tmp)
			complete = complete(m.out, 5)
			mice.results[[as.character(v1)]] <<- m.out
		}
		if(v1 %in% badCountries) {
			complete$ST07Q01 = NA
			complete$ST06Q01 = NA
		}
		return(m.out)
	}
	results = dlply(student, .(CNT), imputePlyr, .progress='text', .parallel=FALSE)	
}

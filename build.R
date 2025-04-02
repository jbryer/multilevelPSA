devtools::document()
devtools::install(upgrade = 'never')
devtools::install()
devtools::build()
devtools::build_vignettes()
devtools::check(cran=TRUE)

# Build website
pkgdown::build_site()

# Ready for CRAN?
devtools::release()

# Sticker
library(multilevelPSA)
library(party)

# Load the Programme for International Student Assessment data
data("pisana", package = 'multilevelPSA')
data("pisa.psa.cols", package = 'multilevelPSA')

# Estimate the propensity scores
mlctree <- mlpsa.ctree(pisana[,c('CNT','PUBPRIV',pisa.psa.cols)], 
					   formula = PUBPRIV ~ .,
					   level2 = 'CNT')
# Get the strata
student.party <- getStrata(mlctree, pisana, level2 = 'CNT')
# Create a total math score as the average of the five imputed scores
student.party$mathscore <- apply(student.party[,paste0('PV', 1:5, 'MATH')], 1, sum) / 5
# Estimate the causal effects
results.psa.math <- mlpsa(response=student.party$mathscore, 
						  treatment=student.party$PUBPRIV, 
						  strata=student.party$strata, 
						  level2=student.party$CNT, minN=5)
mlpsa.circ.plot(results.psa.math, legendlab=FALSE) +
	theme_minimal()

hexSticker::sticker(
	
)
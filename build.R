devtools::document()
devtools::install(upgrade = 'never')
devtools::install()
devtools::install(build_vignettes = TRUE)
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
# remotes::install_github('jbryer/pisa')
source('demo/pisa.R')
# Load the Programme for International Student Assessment data
# data("pisana", package = 'multilevelPSA')
# data("pisa.psa.cols", package = 'multilevelPSA')
# student <- pisana

# Estimate the propensity scores
mlctree <- mlpsa.ctree(student[,c('CNT','PUBPRIV',pisa.psa.cols)], 
					   formula = PUBPRIV ~ .,
					   level2 = 'CNT')
# Get the strata
student.party <- getStrata(mlctree, student, level2 = 'CNT')
# Create a total math score as the average of the five imputed scores
student.party$mathscore <- apply(student.party[,paste0('PV', 1:5, 'MATH')], 1, sum) / 5
# Estimate the causal effects
results.psa.math <- mlpsa(response=student.party$mathscore, 
						  treatment=student.party$PUBPRIV, 
						  strata=student.party$strata, 
						  level2=student.party$CNT, minN=5)
p <- mlpsa.circ.plot(
		results.psa.math,
		legendlab = FALSE,
		plot.adjusted.means = FALSE
	) +
	xlab('') + ylab('') +
	theme_minimal() +
	theme(legend.position = 'none',
		  axis.text = element_blank(),
		  panel.grid.major = element_blank(),
		  panel.grid.minor = element_blank(),
		  panel.border = element_blank(),
		  panel.background = element_blank())
p

hexSticker::sticker(
	subplot = p,
	s_width = 3,
	s_height = 3,
	p_size = 10,
	p_y = 1.62,
	p_color = '#000000',
	url = 'jbryer.github.io/multilevelPSA',
	u_size = 5,
	u_color = '#00B5EE',
	package = 'multilevelPSA',
	filename = 'man/figures/multilevelPSA.png',
	white_around_sticker = TRUE,
	h_fill = '#FFFFFF',
	h_color = '#00B5EE'
)

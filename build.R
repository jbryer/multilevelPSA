usethis::use_tidy_description()
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



##### Sticker
library(multilevelPSA)
library(party)
# remotes::install_github('jbryer/pisa')
source('demo/pisa.R')
# Load the Programme for International Student Assessment data
# data("pisana", package = 'multilevelPSA')
# data("pisa.psa.cols", package = 'multilevelPSA')
# student <- pisana

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
	p_size = 9,
	p_x = 0.60,
	p_y = 1.42,
	p_color = '#00A5FF',
	url = 'jbryer.github.io/multilevelPSA',
	u_size = 5,
	u_color = '#00B5EE',
	package = 'multilevelPSA',
	filename = 'man/figures/multilevelPSA.png',
	white_around_sticker = TRUE,
	h_fill = '#FFFFFF',
	h_color = '#00B5EE'
)

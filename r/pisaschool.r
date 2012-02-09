#TODO: May want to move this to the data directory. For now this will prevent
#      the data file to be downloaded upon each build.

#' This function will load the 2009 PISA school data file. The data file is not
#' included with the package, but instead is downloaded upon first use into the
#' the package's installed data directory. Therefore, subsequent calls will simply
#' load the local version.
#'
#' @references Organisation for Economic Co-operation and Development (2009).
#'             Programme for International Student Assessment (PISA). 
#'             \url{http://www.pisa.oecd.org/}
#' @seealso \link{pisa}
#' @export
pisaschool <- function() {
	dataurl = 'http://multilevelpsa.r-forge.r-project.org/pisa/pisa.school.rda'
	pkgdir = system.file(package='multilevelPSA')
	pisafile = paste(pkgdir, '/data/pisa.school.rda', sep='')
	if(!file.exists(pisafile)) {
		cat(paste('Downloading pisa.student.rda from ', dataurl, sep=''))
		download.file(dataurl, pisafile)
	}
	load(pisafile)
	invisible(TRUE)
}

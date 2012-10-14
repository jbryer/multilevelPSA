#' Estimates models with increasing number of comparision subjects increasing from
#' 1:1 to using all comparison groups.
#' 
#' @param df data frame with variables to pass to glm
#' @param treatvar vector representing treatment placement. Should be coded as
#'        0s (for control) and 1s (for treatment).
#' @param formula formula for logistic regression model
#' @param nsteps number of steps to estimate from 1:1 to using all control records.
#' @param nboot number of models to execute for each step.
#' @return a class of psrange that contains a summary data frame, a details data
#'         frame, and a list of each individual result from glm.
#' @export
psrange <- function(df, treatvar, formula, nsteps=10, nboot=10,
					samples=(seq(0,1,1/nsteps) * 
						(length(which(treatvar==0)) - 2*length(which(treatvar==1))) + 
						length(which(treatvar==1))) ) {
	results <- list()
	
	ncontrol <- length(which(treatvar == 0))
	ntreat <- length(which(treatvar == 1))
	#ndiff <- ncontrol - ntreat
	dfrange <- data.frame(p=integer(), i=integer(),
						 ntreat=integer(), ncontrol=integer(), 
						 psmin=numeric(), psmax=numeric())
	pb <- txtProgressBar(min=1, max=(length(samples)*nboot), style=3)
	densities <- list()
	models <- list()
	for(i in 1:length(samples)) {
		tosample <- samples[i]
		models[[i]] <- list()
		density.df <- data.frame(treat=integer(), ps=numeric())
		for(j in 1:nboot) {
			rows <- c(which(treatvar == 1),
					 sample(which(treatvar == 0), tosample))
			lr.results <- glm(formula, data=df[rows,], family='binomial')
			dfrange <- rbind(dfrange, data.frame(ind=i, p=tosample/ncontrol*100, i=j,
												ntreat=ntreat, ncontrol=tosample, 
												psmin=range(fitted(lr.results))[1],
												psmax=range(fitted(lr.results))[2]))
			density.df <- rbind(density.df, 
								data.frame(treat=treatvar[rows], ps=fitted(lr.results)))
			models[[i]][[j]] <- lr.results
			setTxtProgressBar(pb, (((i-1)*nboot) + j))
		}
		densities[[i]] <- density.df
	}
	
	results$densities <- densities
	results$models <- models
	dfrange$ratio <- dfrange$ncontrol / dfrange$ntreat
	results$details <- dfrange
	smin <- describeBy(dfrange$psmin, group=dfrange$p, mat=TRUE)[,
							c('mean','sd','median','se','min','max')]
	names(smin) <- paste('min', names(smin), sep='.')
	smax <- describeBy(dfrange$psmax, group=dfrange$p, mat=TRUE)[,
							c('mean','sd','median','se','min','max')]
	names(smax) <- paste('max', names(smax), sep='.')
	results$summary <- cbind(dfrange[!duplicated(dfrange$p),c('p','ntreat','ncontrol','ratio')],
							 smin, smax)
	class(results) <- c('psrange')
	return(results)
}

#' Prints the summary results of psrange.
#' 
#' @param object psrange to print summary of.
#' @param ... currently unused.
#' @export
summary.psrange <- function(object, ...) {
	return(object$summary)
}

#' Plots the results of psrange call with ggplot2 displaying the range of fitted
#' values (i.e. propensity scores).
#' 
#' @param x a psrange object
#' @param xlab label for the x axis
#' @param ylab label for the y axis
#' @param ... currently unused.
plot.psrange2 <- function(x, 
						 xlab='Percentage of Control Group',
						 ylab=paste('Propensity Score Range (ntreat = ', 
									prettyNum(x$summary[1,'ntreat'], big.mark=','), ')', sep=''),
						 text.ratio.size=5,
						 text.ncontrol.size=3,
						 point.size=1, point.alpha=.6,
						 line.width = 6,
						 ...) {
	text.vjust <- -.4
	bar.factor = 1
	#min(x$summary$min.min)-.01
	p <- ggplot(x$summary, aes(x=p)) + 
		geom_crossbar(aes(group=p, y=min.mean, ymin=min.min, ymax=min.max), 
				colour='white', fill='green', alpha=.1, width=line.width*bar.factor) +
	  	geom_crossbar(aes(group=p, y=max.mean, ymin=max.min, ymax=max.max), 
	  			colour='white', fill='orange', alpha=.1, width=line.width*bar.factor) +
	  	geom_errorbar(aes(ymin=min.mean, ymax=max.mean), colour='black', width=line.width) + 
		geom_jitter(data=x$details, aes(x=p, y=psmin), size=point.size, alpha=point.alpha, shape=23) +
		geom_jitter(data=x$details, aes(x=p, y=psmax), size=point.size, alpha=point.alpha, shape=22) +
		geom_text(aes(label=paste(prettyNum(floor(ncontrol), big.mark=','), sep='')), 
				y=0, size=text.ncontrol.size, hjust=1.1, vjust=.5) +
		geom_text(aes(label=paste('1:', round(ratio, digits=1), sep=''), 
				y=(min.mean + (max.mean-min.mean)/2)), size=text.ratio.size, vjust=text.vjust) +
	  	coord_flip() + ylim(c(-.05,1)) + 
	  	#geom_hline(yintercept=0) + geom_hline(yintercept=1) +
	  	ylab(ylab) + xlab(xlab)
	return(p)
}

#' Plots densities for the propensity scores.
#' 
#' @param x the result of psrange
#' @return a ggplot2 object
#' @export
plot.psrange <- function(x,
						 xlab=paste('Propensity Score Range (ntreat = ', 
						   		   prettyNum(x$summary[1,'ntreat'], big.mark=','), ')', sep=''),
						 text.ratio.size = 5,
						 text.ncontrol.size = 3,
						 point.size = 1, 
						 point.alpha = .6,
						 line.width = 6,
						 density.alpha = .2,
						 rect.color = 'green',
						 rect.alpha = .2,
						 ...
) {
	densities.df <- data.frame(p=numeric(), treat=integer(), ps=numeric())
	for(i in seq_len(length(x$densities))) {
		densities.df <- rbind(densities.df, cbind(p=x$summary[i,'p'], 
												  x$densities[[i]]))
	}
	densities.df$treat = factor(densities.df$treat)
	
	text.vjust = -.4
	bar.factor = 1

	p <- ggplot() + xlim(c(-.05,1.05)) + ylim(c(-1,1)) +
			stat_density(data=densities.df[densities.df$treat==1,], 
				aes(x=ps, ymax=-..scaled.., fill=treat, ymin = 0),
				geom = "ribbon", position = "identity", alpha=density.alpha) +
			stat_density(data=densities.df[densities.df$treat==0,], 
				aes(x=ps, ymax=..scaled.., fill=treat, ymin = 0),
				geom = "ribbon", position = "identity", alpha=density.alpha) +
			geom_rect(data=x$summary, aes(group=p, xmin=max.min-.005, xmax=(max.max+.005), 
				ymin=0.25, ymax=.75), fill=rect.color, alpha=rect.alpha) +
			geom_rect(data=x$summary, aes(group=p, xmin=(min.min-.005), xmax=min.max+.005, 
				ymin=-.75, ymax=-0.25), fill=rect.color, alpha=rect.alpha) +
			geom_point(data=x$details, 
  		  		aes(y=-.5, x=psmin), size=point.size, alpha=point.alpha, shape=23) +
  		  	geom_point(data=x$details, 
  		  		aes(y=.5, x=psmax), size=point.size, alpha=point.alpha, shape=22) +
			geom_errorbarh(data=x$summary, 
				aes(y=0, x=min.mean + (max.mean-min.mean)/ 2, xmin=min.mean, xmax=max.mean), 
				colour='black', width=line.width) + 
		   	geom_text(data=x$summary,
		   		aes(label=paste(prettyNum(floor(ncontrol), big.mark=','), sep='')), 
		   		x=0, y=0, size=text.ncontrol.size, hjust=1.1, vjust=-0.2) +
   		  	geom_text(data=x$summary,
   		  		aes(label=paste('1:', round(ratio, digits=1), sep=''), 
   		  		x=(min.mean + (max.mean-min.mean)/2)), y=0, 
   		  		size=text.ratio.size, vjust=text.vjust) +
		  	facet_grid(p ~ ., as.table=FALSE) +
			theme(axis.text.y=element_blank(), axis.ticks.y=element_blank()) +
			ylab(NULL) + xlab(xlab) +
			scale_fill_hue('', limits=c(0,1), labels=c('Comparison','Treatment'))
	
	return(p)
}


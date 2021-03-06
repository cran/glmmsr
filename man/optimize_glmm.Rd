% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/optimization.R
\name{optimize_glmm}
\alias{optimize_glmm}
\title{Maximize the approximated log-likelihood}
\usage{
optimize_glmm(lfun, p_beta, p_theta, prev_fit = NULL, verbose = 1L)
}
\arguments{
\item{lfun}{the approximated loglikelihood function}

\item{p_beta}{the number of covariates}

\item{p_theta}{the number of random effects}

\item{prev_fit}{a \code{glmmFit} object, the result of a previous model fit.}

\item{verbose}{controls how much detail to print out while fitting the model.
For verbose = 0, print nothing. For verbose = 1 (the default), print
output approximately once a second during model fitting. For verbose = 2,
print out the parameter value and log-likelihood at every stage of
optimization.}
}
\value{
A list, containing the parameter estimate and variance matrix
}
\description{
Find the approximate maximum likelihood estimate, and estimate the variance
of the estimate
}
\keyword{internal}

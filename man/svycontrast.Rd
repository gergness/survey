\name{svycontrast}
\alias{svycontrast}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Linear and nonlinearconstrasts of survey statistics }
\description{
Computes linear or nonlinear contrasts of estimates produced by survey
functions (or any object with \code{coef} and \code{vcov} methods).
}
\usage{
svycontrast(stat, contrasts, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{stat}{object of class \code{svrepstat} or \code{svystat} }
  \item{contrasts}{A vector or list of vectors of coefficients, or a
    call or list of calls }
  \item{\dots}{For future expansion}
}
\value{
Object of class \code{svrepstat} or \code{svystat}
}

\details{
If \code{contrasts} is a list, the element names are used as
names for the returned statistics.
  
If an element of \code{contrasts} is shorter than \code{coef(stat)} and has names, the
names are used to match up the vectors and the remaining elements of
\code{contrasts} are assumed to be zero. If the names are not legal
variable names (eg \code{0.1}) they must be quoted (eg \code{"0.1"})

If \code{contrasts} is a \code{"call"} or list of \code{"call"s}, the
delta-method is used to compute variances, and the calls must use only
functions that \code{\link{deriv}} knows how to differentiate. If the
names are not legal variable names they must be quoted with backticks
(eg \code{`0.1`}).
  }
\seealso{\code{\link{regTermTest}}, \code{svyglm}}
\examples{
data(api)
dclus1<-svydesign(id=~dnum, weights=~pw, data=apiclus1, fpc=~fpc)

a <- svytotal(~api00+enroll+api99, dclus1)
svycontrast(a, list(avg=c(0.5,0,0.5), diff=c(1,0,-1)))
## if contrast vectors have names, zeroes may be omitted
svycontrast(a, list(avg=c(api00=0.5,api99=0.5), diff=c(api00=1,api99=-1)))

## nonlinear contrasts
svycontrast(a, quote(api00/api99))
svyratio(~api00, ~api99, dclus1)

## Example: standardised skewness coefficient
moments<-svymean(~I(api00^3)+I(api00^2)+I(api00), dclus1)
svycontrast(moments, 
quote((`I(api00^3)`-3*`I(api00^2)`*`I(api00)`+ 3*`I(api00)`*`I(api00)`^2-`I(api00)`^3)/
      (`I(api00^2)`-`I(api00)`^2)^1.5))

}
\keyword{survey}% at least one, from doc/KEYWORDS


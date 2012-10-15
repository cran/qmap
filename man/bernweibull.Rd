\name{bernweibull}
\alias{bernweibull}
\alias{dbernweibull}
\alias{pbernweibull}
\alias{qbernweibull}
\alias{rbernweibull}
%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  The Bernoulli-Weibull distribution
}

\description{
  Density, distribution function, quantile function and random
  generation for the Bernoulli-Weibull distribution with parameters
  \code{prob}, \code{shape},  and \code{scale}. 
}

\usage{
dbernweibull(x, prob, scale, shape)
pbernweibull(q, prob, scale, shape)
qbernweibull(p, prob, scale, shape)
rbernweibull(n, prob, scale, shape)
}

\arguments{
  \item{x,q}{
    vector of quantiles.
  }
  \item{p}{
    vector of probabilities.
  }
  \item{prob}{
    probability of non-zero event.
  }
  \item{n}{
    number of random samples.
  }
  \item{scale,shape}{
    shape and scale parameters of the weibull distribution.
  }
}

\details{
  Mixture of Bernoulli and Weibull distribution. The mixture is analogue
  to the one described for the \code{\link{berngamma}} distribution. 
}

\value{
  \code{dbernweibull} gives the density (pdf), \code{pbernweibull} gives
  the distribution function (cdf), \code{qbernweibull} gives the
  quantile function (inverse cdf), and \code{rbernweibull} generates
  random deviates.  
}

\note{
  The implementation is largely based on the \code{bweibull} family in
  the \code{CaDENCE}-package (Cannon, 2012) that was only available as
  test version at time of implementation (Mar. 2012). The
  \code{CaDENCE}-package is available at
  \url{http://www.eos.ubc.ca/~acannon/CaDENCE/}.
}

\references{
  Cannon, A. J. Neural networks for probabilistic environmental
  prediction: Conditional Density Estimation Network Creation and
  Evaluation (CaDENCE) in R. Computers & Geosciences, 2012, 41, 126 -
  135, doi:10.1016/j.cageo.2011.08.023.
}

\author{
  Lukas Gudmundsson
}

\seealso{
  \code{\link{Weibull}}, \code{\link{berngamma}}
}

\examples{
data(obsprecip)

(ts <- startbernweibull(obsprecip[,1]))
hist(obsprecip[,1],freq=FALSE) 
lines(seq(0,max(obsprecip[,1])),
      dbernweibull(seq(0,max(obsprecip[,1])),
                   prob=ts$prob,
                   shape=ts$shape,
                   scale=ts$scale),
      col="red")

pp <- seq(0.01,0.99,by=0.01)
qq <-quantile(obsprecip[,1],probs=pp) 

plot(qq,pp)
lines(qbernweibull((0:100)/100,
                   prob=ts$prob,
                   scale=ts$scale,
                   shape=ts$shape),
      (0:100)/100,col="red")

plot(qq,pp)
lines(qq,
      pbernweibull(qq,
                   prob=ts$prob,
                   scale=ts$scale,
                   shape=ts$shape),
      col="red")

hist(rbernweibull(1000,prob=ts$prob,
                      shape=ts$shape,
                      scale=ts$scale),freq=TRUE)

}

\keyword{distribution}
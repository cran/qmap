\name{bernlnorm}
\alias{bernlnorm}
\alias{dbernlnorm}
\alias{pbernlnorm}
\alias{qbernlnorm}
\alias{rbernlnorm}

\title{
  The Bernoulli-Log-Normal distribution
}

\description{
  Density, distribution function, quantile function and random
  generation for the Bernoulli-Log-Normal distribution with parameters
  \code{prob}, \code{meanlog},  and \code{sdlog}. 
}

\usage{
dbernlnorm(x, prob, meanlog, sdlog)
pbernlnorm(q, prob, meanlog, sdlog)
qbernlnorm(p, prob, meanlog, sdlog)
rbernlnorm(n, prob, meanlog, sdlog)
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
  \item{meanlog,sdlog}{
    meanlog and sdlog parameters of the Log-Normal distribution.
  }
}

\details{
  Mixture of Bernoulli and Log-Normal distribution. The mixture is analogue
  to the one described for the \code{\link{berngamma}} distribution. 
}

\value{
  \code{dbernlnorm} gives the density (pdf), \code{pbernlnorm} gives
  the distribution function (cdf), \code{qbernlnorm} gives the
  quantile function (inverse cdf), and \code{rbernlnorm} generates
  random deviates.  
}

\note{
  The implementation is largely based on the \code{blnorm} family in
  the \code{CaDENCE}-package (Cannon, 2012) that was only available as
  test version at time of implementation (Mar. 2012). 
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
  \code{\link{Lognormal}}, \code{\link{berngamma}}
}
\examples{
data(obsprecip)

(ts <- startbernlnorm(obsprecip[,1]))
hist(obsprecip[,1],freq=FALSE)
lines(seq(0,20),dbernlnorm(0:20,
                           prob=ts$prob,
                           meanlog=ts$meanlog,
                           sdlog=ts$sdlog),
      col="red")

pp <- seq(0.01,0.99,by=0.01)
qq <-quantile(obsprecip[,1],probs=pp) 

plot(qq,pp)
lines(qbernlnorm(pp,
                 prob=ts$prob,
                 meanlog=ts$meanlog,
                 sdlog=ts$sdlog),
      pp,col="red")

plot(qq,pp)
lines(qq,
      pbernlnorm(qq,
                 prob=ts$prob,
                 meanlog=ts$meanlog,
                 sdlog=ts$sdlog),
      col="red")

hist(rbernlnorm(1000,prob=ts$prob,
                meanlog=ts$meanlog,
                sdlog=ts$sdlog),freq=FALSE)

}
\keyword{distribution}

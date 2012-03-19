\name{bernexp}
\alias{bernexp}
\alias{dbernexp}
\alias{pbernexp}
\alias{qbernexp}
\alias{rbernexp}

\title{
  The Bernoulli-Exponential distribution
}

\description{
  Density, distribution function, quantile function and random
  generation for the Bernoulli-Exponential distribution with parameters 
  \code{prob}, and \code{rate}. 
}

\usage{
dbernexp(x, prob, rate)
pbernexp(q, prob, rate)
qbernexp(p, prob, rate)
rbernexp(n, prob, rate)
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
  \item{rate}{
    rate parameter of the Exponential distribution.
  }
}

\details{
  Mixture of the Bernoulli and the Exponential distribution. The mixture
  is analogue to the one described for the \code{\link{berngamma}}
  distribution.  
}

\value{
  \code{dbernexp} gives the density (pdf), \code{pbernexp} gives
  the distribution function (cdf), \code{qbernexp} gives the
  quantile function (inverse cdf), and \code{rbernexp} generates
  random numbers.  
}

\author{
  Lukas Gudmundsson
}

\seealso{
  \code{\link{Exponential}}, \code{\link{berngamma}}
}

\examples{
data(obsprecip)

(ts <- startbernexp(obsprecip[,1]))
hist(obsprecip[,1],freq=FALSE) 
lines(seq(0,max(obsprecip[,1])),
      dbernexp(seq(0,max(obsprecip[,1])),
               prob=ts$prob,
               rate=ts$rate),
      col="red")

pp <- seq(0.01,0.99,by=0.01)
qq <-quantile(obsprecip[,1],probs=pp) 

plot(qq,pp)
lines(qbernexp((0:100)/100,
                   prob=ts$prob,
                   rate=ts$rate),
      (0:100)/100,col="red")

plot(qq,pp)
lines(qq,
      pbernexp(qq,
               prob=ts$prob,
               rate=ts$rate),
      col="red")

hist(rbernexp(1000,prob=ts$prob,
              rate=ts$rate),freq=FALSE)

}
\keyword{distribution}


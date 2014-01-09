\name{startbernexp}
\alias{startbernexp}

\title{
  Rough parameter estimate for the Bernoulli-Exponential distribution
}

\description{
  Estimates rough starting values for the Bernoulli-Exponential distribution
  using the method of moments for the \code{rate} parameter. The
  probability of non-zero events is estimated as the fraction of values
  that are larger than zero. 
}

\usage{
startbernexp(x)
}

\arguments{
  \item{x}{
    numeric vector.
  }
}

\value{
  A list containing:
  \item{prob}{probability of non-zero event.}
  \item{rate}{rate parameter of the Exponential distribution.}
}

\author{
  Lukas Gudmundsson
}

\note{
  In this package \code{startbernexp} is intended to be used in
  conjunction with \code{\link{fitQmapDIST}} (and \code{\link{mledist}})
  with parameter \code{distr="bernexp"}.
}

\seealso{
  \code{\link{fitQmapDIST}}, \code{\link{bernexp}},
  \code{\link{fitdist}}
}

\examples{
gg <- rbernexp(n=300, prob=0.2, rate=1)
startbernexp(gg)
mledist(gg,"bernexp",startbernexp(gg))
}

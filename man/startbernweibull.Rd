\name{startbernweibull}
\alias{startbernweibull}

\title{
  Rough parameter estimate for the Bernoulli-Weibull distribution
}

\description{
  Estimates rough starting values for the Bernoulli-Weibull distribution
  using the method of moments for the \code{shape} and the \code{scale}
  parameters. The probability of non-zero events is estimated as the
  fraction of values that are larger than zero.
}

\usage{
startbernweibull(x)
}

\arguments{
  \item{x}{
    numeric vector.
  }
}

\value{
  A list containing:
  \item{prob}{probability of non-zero event.}
  \item{scale}{scale parameter of the weibull distribution.}
  \item{shape}{shape parameter of the weibull distribution.}
}

\author{
  Lukas Gudmundsson
}

\note{
  In this package \code{startbernweibull} is intended to be used in
  conjunction with \code{\link{fitQmapDIST}} (and
  \code{\link[fitdistrplus]{mledist}}) with parameter \code{distr="bernweibull"}. 
}

\seealso{
  \code{\link{fitQmapDIST}}, \code{\link{bernweibull}},
  \code{\link[fitdistrplus]{fitdist}}
}

\examples{
gg <- rbernweibull(n=300, prob=0.2, scale=1, shape=1)
startbernweibull(gg)
mledist(gg,"bernweibull",startbernweibull(gg))
}

\name{startberngamma}
\alias{startberngamma}

\title{
  Rough parameter estimate for the Bernoulli-Gamma distribution
}
\description{
  Estimates rough starting values for the Bernoulli-Gamma distribution
  using the method of moments for the \code{shape} and the \code{scale}
  parameters. The probability of non-zero events is estimated as the
  fraction of values that are larger than zero.
}

\usage{
startberngamma(x)
}

\arguments{
  \item{x}{
    numeric vector.
  }
}

\value{
  A list containing:
  \item{prob}{probability of non-zero event.}
  \item{scale}{scale parameter of the gamma distribution.}
  \item{shape}{shape parameter of the gamma distribution.}
}

\author{
  Lukas Gudmundsson
}

\note{
  In this package \code{startberngamma} is intended to be used in
  conjunction with \code{\link{fitQmapDIST}} (and \code{\link{mledist}})
  with parameter \code{distr="berngamma"}.
}

\seealso{
  \code{\link{fitQmapDIST}}, \code{\link{berngamma}},
  \code{\link{fitdist}} 
}
\examples{
gg <- rberngamma(n=300, prob=0.2, scale=1, shape=1)
startberngamma(gg)
mledist(gg,"berngamma",startberngamma(gg))
}

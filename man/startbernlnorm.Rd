\name{startbernlnorm}
\alias{startbernlnorm}

\title{
  Rough parameter estimate for the Bernoulli-Log-Normal distribution
}

\description{
  Estimates rough starting values for the Bernoulli-Log-Normal distribution
  using the method of moments for the \code{meanlog} and the \code{sdlog}
  parameters. The probability of non-zero events is estimated as the
  fraction of values that are larger than zero.
}

\usage{
startbernlnorm(x)
}

\arguments{
  \item{x}{
    numeric vector.
  }
}

\value{
  A list containing:
  \item{prob}{probability of non-zero event.}
  \item{meanlog}{meanlog parameter of the Log-Normal distribution.}
  \item{sdlog}{sdlog parameter of the Log-Normal distribution.}
}

\author{
  Lukas Gudmundsson
}

\note{
  In this package \code{startbernlnorm} is intended to be used in
  conjunction with \code{\link{fitQmapDIST}} (and \code{\link{mledist}})
  with parameter \code{distr="bernlnorm"}.
}

\seealso{
  \code{\link{fitQmapDIST}}, \code{\link{bernlnorm}},
  \code{\link{fitdist}}
}

\examples{
gg <- rbernlnorm(n=300, prob=0.2, meanlog=1, sdlog=1)
startbernlnorm(gg)
mledist(gg,"bernlnorm",startbernlnorm(gg))
}


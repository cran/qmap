\name{berngamma}
\alias{berngamma}
\alias{dberngamma}
\alias{pberngamma}
\alias{qberngamma}
\alias{rberngamma}

\title{
  The Bernoulli-Gamma distribution
}
\description{
  Density, distribution function, quantile function and random
  generation for the Bernoulli-Gamma distribution with parameters
  \code{prob}, \code{shape},  and \code{scale}. 
}

\usage{
dberngamma(x, prob, scale, shape)
pberngamma(q, prob, scale, shape)
qberngamma(p, prob, scale, shape)
rberngamma(n, prob, scale, shape)
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
    shape and scale parameters of the gamma distribution.
  }
}

\details{
  Mixture of the Bernoulli and the Gamma distribution. The Bernoulli
  distribution is used to model the occurrence of zero values with the
  probability of \code{1-prob}. Non-zero values follow the Gamma
  distribution with \code{shape} and \code{scale} parameters.

  The probability density function (PDF) is defined as:
  %%
  \deqn{g(x) = \left\{
    \begin{array}{l l}
    \pi*\gamma(x) & \quad \mbox{if } x > 0 \\
    1- \pi & \quad \mbox{if } x \leq 0    
    \end{array} \right.
  }{g(x) = if(x > 0) pi*gamma(x) else 1-pi}
  %%
  where \eqn{\gamma(x)}{gamma(x)} is the probability density function of
  the gamma distribution and \eqn{\pi} is probability of a non-zero
  event. 

  The cumulative distribution function (CDF) is defined as:
  %%
  \deqn{G(x) = \left\{
    \begin{array}{l l}
    1 - \pi + \pi*\Gamma(x) & \quad \mbox{if } x > 0 \\
    1 - \pi & \quad \mbox{if } x \leq 0    
    \end{array} \right.
  }{G(x) = if(x > 0) 1- pi + pi*Gamma(x) else 1-pi}
  %%
  where \eqn{\Gamma(x)}{Gamma(x)} is the cumulative distribution
  function of the gamma distribution.

  The quantile function (inverse of the CDF) is defined as
  %%
  \deqn{G^{-1}(p) = \left\{
    \begin{array}{l l}
    \Gamma^{-1}\left(\frac{p-1+\pi}{\pi}\right) & \quad \mbox{if } \pi > 1-p \\
    0 & \quad \mbox{if } p \leq 1-p    
    \end{array} \right.
  }{G^{-1}(x) = if(p > 1-p) Gamma^{-1}((p-1+pi)/pi) else 0}
  %%
  where \eqn{\Gamma^{-1}(p)}{Gamma^{-1}(p)} is the inverse CDF of the
  gamma distribution and \eqn{p} is a probability.  
}

\value{
  \code{dberngamma} gives the density (pdf), \code{pberngamma} gives
  the distribution function (cdf), \code{qberngamma} gives the
  quantile function (inverse cdf), and \code{rberngamma} generates
  random deviates.  
}

\note{
  The implementation is largely based on the \code{bgamma} family in
  the \code{CaDENCE}-package (Cannon, 2012) that was only available as
  test version at time of implementation (Mar. 2012). The
  \code{CaDENCE}-package is available at
  \url{http://www.eos.ubc.ca/~acannon/CaDENCE/}.

  For further details and meteorological application of Bernoulli-Gamma
  distributions (also referred to as 'Mixed Gamma' distribution) see
  Burger et al. 2012, Cannon 2008, Li et al. 2010, Mooley 1973,
  Piani et al. 2010, Thom 1968, Sloughter et al. 2007.
}

\references{
  Burger, G.; Murdock, T. Q.; Werner, A. T.; Sobie, S. R. & Cannon,
  A. J. Downscaling extremes - an intercomparison of multiple
  statistical methods for present climate. Journal of
  Climate, American Meteorological Society, early online release,
  2012, doi:10.1175/JCLI-D-11-00408.1.
  
  Cannon, A. J. Probabilistic Multisite Precipitation Downscaling by an
  Expanded Bernoulli-Gamma Density Network. Journal of
  Hydrometeorology, American Meteorological Society, 2008, 9,
  1284-1300, doi:10.1175/2008JHM960.1.

  Cannon, A. J. Neural networks for probabilistic environmental
  prediction: Conditional Density Estimation Network Creation and
  Evaluation (CaDENCE) in R. Computers & Geosciences, 2012, 41, 126 -
  135, doi:10.1016/j.cageo.2011.08.023.
  
  Li, H.; Sheffield, J. & Wood, E. F. Bias correction of monthly
  precipitation and temperature fields from Intergovernmental Panel on
  Climate Change AR4 models using equidistant quantile matching.
  J. Geophys. Res., AGU, 2010, 115, D10101, doi:10.1029/2009JD012882.

  Mooley, D. A. Gamma Distribution Probability Model for Asian Summer
  Monsoon Monthly Rainfall. Monthly Weather Review, 1973, 101,
  160-176, doi:10.1175/1520-0493(1973)101<0160:GDPMFA>2.3.CO;2.
  
  Piani, C.; Haerter, J. & Coppola, E. Statistical bias correction for
  daily precipitation in regional climate models over Europe. Theoretical
  and Applied Climatology, 2010, 99,
  187-192, doi:10.1007/s00704-009-0134-9.

  Thom, H. C. S. Approximate convolution of the gamma and mixed gamma
  distributions. Monthly Weather Review, 1968, 96,
  883-886, doi:10.1175/1520-0493(1968)096<0883:ACOTGA>2.0.CO;2.

  Sloughter, J. M. L.; Raftery, A. E.; Gneiting, T. & Fraley,
  C. Probabilistic Quantitative Precipitation Forecasting Using Bayesian
  Model Averaging. Monthly Weather Review, 2007, 135,
  3209-3220, doi:10.1175/MWR3441.1.
}

\author{
  Lukas Gudmundsson
}

\seealso{
  \code{\link{GammaDist}}
}
\examples{
data(obsprecip)

(ts <- startberngamma(obsprecip[,1]))
hist(obsprecip[,1],freq=FALSE) 
lines(seq(0,20),dberngamma(0:20,
                           prob=ts$prob,
                           scale=ts$scale,
                           shape=ts$shape),
      col="red")

pp <- seq(0.01,0.99,by=0.01)
qq <-quantile(obsprecip[,1],probs=pp) 

plot(qq,pp)
lines(qberngamma(pp,
                 prob=ts$prob,
                 scale=ts$scale,
                 shape=ts$shape),
      pp,col="red")

plot(qq,pp)
lines(qq,
      pberngamma(qq,
                 prob=ts$prob,
                 scale=ts$scale,
                 shape=ts$shape),
      col="red")

hist(rberngamma(1000,
                prob=ts$prob,
                scale=ts$scale,
                shape=ts$shape),freq=FALSE)
}
\keyword{distribution}
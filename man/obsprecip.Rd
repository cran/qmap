\name{obsprecip}
\alias{obsprecip}
\alias{modprecip}
\docType{data}

\title{Daily precipitation data at three locations in Norway.}

\description{
  Observed (\code{obsprecip}) and simulated (\code{modprecip}) daily
  precipitation data for three locations in Norway covering the 1961 -
  1990 period.
}

\usage{
data(obsprecip)
data(modprecip)
}

\format{
  Data frame(s) with rows representing days and with the following 3 variables.
  \describe{
    \item{\code{MOSS}}{Daily Precipitation at Moss [mm/day]}
    \item{\code{GEIRANGER}}{Daily Precipitation at Geiranger [mm/day]}
    \item{\code{BARKESTAD}}{Daily Precipitation at Barkestad [mm/day]}
  }
}

\details{
  The time series in \code{obsprecip} stem from the observation-system
  of the Norwegian Meteorological Institute.

  The time series in \code{modprecip} are based on simulations of
  HIRHAM2/NorACIA regional climate model forced with simulation the
  HadAM3H. The simulation setup is further described in Forland et
  al. 2011. The simulations are free-running and there is consequently
  no direct correspondence in the temporal evolution of \code{modprecip}
  and \code{obsprecip}.
  
  NOTE that all months in the modelled data (\code{modprecip}) have 30
  days (in contrast to the observations (\code{obsprecip}) which have
  true calender days. 
}

\source{
  The observations are taken form the observation network of the
  Norwegian meteorological institute (\url{https://www.met.no/}).
}

\references{
  Forland, E. J.; Benestad, R.; Hanssen-Bauer, I.; Haugen, J. E. &
  Skaugen, T. E. Temperature and Precipitation Development at Svalbard 
  1900-2100. Advances in Meteorology, 2011, Volume 2011, 893790, doi:
  10.1155/2011/893790.
}

\examples{
data(obsprecip)
data(modprecip)
}

\keyword{datasets}

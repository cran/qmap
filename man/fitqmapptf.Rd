\name{fitQmapPTF}
\alias{fitQmapPTF}
\alias{fitQmapPTF.default}
\alias{fitQmapPTF.matrix}
\alias{fitQmapPTF.data.frame}
\alias{doQmapPTF}
\alias{doQmapPTF.default}
\alias{doQmapPTF.matrix}
\alias{doQmapPTF.data.frame}

\title{
  Quantile mapping using parametric transformations
}

\description{
  \code{fitQmapPTF} fits a parametric transformations to the
  quantile-quantile relation of observed and modelled
  values. \code{doQmapPTF} uses the transformation to adjust the
  distribution of the modelled data to match the distribution of the
  observations. 
}

\usage{
fitQmapPTF(obs, mod, ...)
\method{fitQmapPTF}{default}(obs, mod, transfun=c("power","linear","expasympt",
"scale","power.x0","expasympt.x0"), wet.day=TRUE,
cost=c("RSS","MAE"), qstep=0.001,opar,...)
\method{fitQmapPTF}{matrix}(obs, mod, ...)
\method{fitQmapPTF}{data.frame}(obs, mod, ...)
%%
doQmapPTF(x,fobj,...)
\method{doQmapPTF}{default}(x,fobj,...)
\method{doQmapPTF}{matrix}(x,fobj,...)
\method{doQmapPTF}{data.frame}(x,fobj,...)
}

\arguments{
  \item{obs}{
    \code{numeric} vector, column \code{matrix} or \code{data.frame}
    with observed time series. 
  }
  \item{mod}{
    \code{numeric} vector, column \code{matrix} or \code{data.frame}
    with modelled time series, corresponding to \code{obs}.
  }
  \item{transfun}{
    either a character string specifying a predefined function used for
    the transformation (see Details) or a function with \code{x} as
    first argument e.g. \code{function(x,a,b){a*x^b}}
  }
  \item{wet.day}{   
    \code{logical} indicating whether to perform wet day correction or
    not. OR a \code{numeric} threshold below which all values are set to
    zero. See Details. 
  }
  \item{cost}{
    Criterion for optimisation. "RSS" minimises the residual sum of
    squares and produces a least square fit. "MAE" minimises the mean
    absolute error, which is less sensitive to outliers. 
  }
  \item{qstep}{
    \code{NULL} or a numeric value between 0 and 1. See Details.
  }
  \item{opar}{
     a named list with arguments passed to \code{optim}. Note that
     \code{method} is chosen automatically. If \code{transfun} is a
     character string  default values for \code{par} are available (but
     can be overwritten). See examples. 
   }
   \item{x}{
     \code{numeric} vector or a column \code{matrix} of modelled time
     series
   }
   \item{fobj}{
     output from \code{fitQmapDIST}
   }
  \item{\dots}{
     Further arguments passed to methods
  }
}

\details{
  Before further computations the empirical cumulative distribution
  functions (CDF) of the observed (\code{obs}) and modelled (\code{mod}) are
  estimated. If \code{!is.null(qstep)} than \code{mod} and \code{obs}
  are aggregated to quantiles before model identification as:
  \code{quantile(x,probs=seq(0,1,by=qstep)}. If \code{!is.null(qstep)} 
  than \code{mod} and \code{obs} are sorted to produce an estimate of
  the empirical CDF. In case of different length of \code{mod} and
  \code{obs} than \code{quantile(x,probs=seq(0,1,len=n)]} is used, where
  \code{n <- min(length(obs),length(mod))}. NOTE that large values of
  \code{qstep} effectively reduce the sample-size and can be used to
  speedup computations - but may render estimates less reliable.    

  \code{wet.day} is intended for the use for precipitation data. Wet day
  correction  attempts to equalise the fraction of days with
  precipitation between the observed and the modelled data. If
  \code{wet.day=TRUE} the empirical probability of nonzero observations
  is found (\code{obs>=0}) and the corresponding modelled value is
  selected as a threshold. All modelled  values below this threshold are
  set to zero. If \code{wet.day} is \code{numeric} the same procedure is
  performed after setting all \code{obs<wet.day} to zero. The
  transformations are then only fitted to the portion of the
  distributions corresponding to observed wet days. See Piani et. al
  (2010) for further explanations.

  \bold{Transformations} (\code{transfun}):

  NOTE: If wet day correction is performed (see \code{wet.day}), the
  transformations are only fitted to the portion of the empirical CDF
  with nonzero observations. 

  A series of predefined transformations are available and can be
  accessed by setting \code{transfun} to one of the following options
  (\eqn{P_o} refers to observed and \eqn{P_m} to modelled CDFs):

  \code{"power"}:
  %%
  \deqn{P_o=b*P_m^c}
  %%

  \code{"linear"}:
  %%
  \deqn{P_o=a+b*P_m}
  %%

  \code{"expasympt"} (exponential tendency to an asymptote):
  %%
  \deqn{P_o=(a+b*P_m)*(1-exp(-P_m/\tau))}{P_o=(a+b*P_m)*(1-exp(-P_m/tau))}
  %%

  \code{"scale"}:
  %%
  \deqn{P_o=b*P_m}
  %%

  \code{"power.x0"}:
  %%
  \deqn{P_o=b*(P_m-x0)^c}
  %%

  \code{"expasympt.x0"} (exponential tendency to an asymptote):
  %%
  \deqn{P_o=(a+b*P_m)*(1-exp(-(P_m-x0)/\tau))}{P_o=(a+b*P_m)*(1-exp(-(P_m-x0)/tau))}
  %%
}

\value{ 
  \code{fitQmapPTF} returns an object of class \code{fitQmapPTF}
  containing following elements:
  \item{tfun }{
    The function used to transform the distribution of the modelled
    values to match the distribution of the observations. 
  }
  \item{par }{
    A matrix. The (named) columns correspond to the parameters
    of the transfer function. The rows correspond to pairs of time
    series in \code{obs} and \code{mod}.
  }
  \item{wet.day}{
    \code{logical}, indicating whether to perform wet day correction or
    not. OR a \code{numeric} threshold below which all values are set to
    zero. 
  }

  \code{doQmapPTF} returns a \code{numeric} vector, \code{matrix} or
  \code{data.frame} depending on the format of \code{x}. 
}
\references{
  The implementation is closely related to the methods published in:

  Piani, C.; Weedon, G.; Best, M.; Gomes, S.; Viterbo, P.; Hagemann,
  S. & Haerter, J. Statistical bias correction of global simulated daily
  precipitation and temperature for the application of hydrological
  models. Journal of Hydrology, 2010, 395, 199 -
  215, doi:10.1016/j.jhydrol.2010.10.024.

  Dosio, A. & Paruolo, P. Bias correction of the ENSEMBLES
  high-resolution climate change projections for use by impact models:
  Evaluation on the present climate. J. Geophys. Res., AGU, 2011, 116,
  D16106, doi:10.1029/2011JD015934.

  For a general assessment of the methods see:

  Gudmundsson, L.; Bremnes, J. B.; Haugen, J. E. & Engen-Skaugen,
  T. Technical Note: Downscaling RCM precipitation to the station scale
  using statistical transformations - a comparison of methods. Hydrology
  and Earth System Sciences, 2012, 16, 3383-3390,
  doi:10.5194/hess-16-3383-2012.   

}
\author{
  Lukas Gudmundsson
}

\seealso{
  \code{\link{fitQmap}}, \code{\link{optim}}
}

\examples{
data(obsprecip)
data(modprecip)

## data.frame example
qm.fit <- fitQmapPTF(obsprecip,modprecip,
                     transfun="power.x0",
                     cost="RSS",wet.day=TRUE,
                     qstep=0.001)
qm <- doQmapPTF(modprecip,qm.fit)

## application to "single time series"
qm.b.fit <- fitQmapPTF(obsprecip[,1],modprecip[,1],
                     transfun="expasympt.x0",
                     cost="RSS",wet.day=0.1,
                     qstep=0.001)
qm.b <- doQmapPTF(modprecip[,1],qm.b.fit)
qm.c.fit <- fitQmapPTF(obsprecip[,1],modprecip[,1],
                     transfun="expasympt",
                     cost="RSS",wet.day=TRUE,
                     qstep=0.001)
qm.c <- doQmapPTF(modprecip[,1],qm.c.fit)

## user defined transfer function
## and usage of the 'opar' argument
## (same as transfun="power")
myff <- function(x,a,b) a*x^b

qm3.fit <- fitQmapPTF(obsprecip[,1],modprecip[,1],
                     transfun=myff,
                     opar=list(par=c(a=1,b=1)),
                     cost="RSS",wet.day=TRUE,
                     qstep=0.001)
qm3 <- doQmapPTF(modprecip[,1],qm3.fit)


sqrtquant <- function(x,qstep=0.01){
  qq <- quantile(x,prob=seq(0,1,by=qstep))
  sqrt(qq)
}
plot(sqrtquant(modprecip[,1]),
     sqrtquant(obsprecip[,1]))
lines(sqrtquant(modprecip[,1]),
      sqrtquant(qm[,1]),col="red")
lines(sqrtquant(modprecip[,1]),
      sqrtquant(qm.b),col="blue")
lines(sqrtquant(modprecip[,1]),
      sqrtquant(qm.c),col="green")
lines(sqrtquant(modprecip[,1]),
      sqrtquant(qm3),col="orange")
legend("topleft",
       legend=c("power.x0","expasympt.x0",
         "expasympt","myff"),
       col=c("red","blue","green","orange"),lty=1)


}


% % Add one or more standard keywords, see file 'KEYWORDS' in the
% % R documentation directory.
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

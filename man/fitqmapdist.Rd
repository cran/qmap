\name{fitQmapDIST}
\alias{fitQmapDIST}
\alias{fitQmapDIST.default}
\alias{fitQmapDIST.matrix}
\alias{fitQmapDIST.data.frame}
\alias{doQmapDIST}
\alias{doQmapDIST.default}
\alias{doQmapDIST.matrix}
\alias{doQmapDIST.data.frame}

\title{
  Quantile mapping using distribution derived transformations 
}

\description{
  \code{fitQmapDIST} fits a theoretical distribution to observed and to  
  modelled time series and returns these parameters as  well as a
  transfer function derived from the distribution. \code{doQmapDIST}
  uses the transfer function to transform the distribution of the
  modelled data to match the distribution of the observations. 
}

\usage{
fitQmapDIST(obs, mod, ...)
\method{fitQmapDIST}{default}(obs,mod,distr="berngamma",start.fun,
qstep=NULL,mlepar,...)
\method{fitQmapDIST}{matrix}(obs, mod, ...)
\method{fitQmapDIST}{data.frame}(obs, mod, ...)
%%
doQmapDIST(x,fobj,...)
\method{doQmapDIST}{default}(x,fobj,...)
\method{doQmapDIST}{matrix}(x,fobj,...)
\method{doQmapDIST}{data.frame}(x,fobj,...)
}

\arguments{
  \item{obs}{
    \code{numeric} vector, column \code{matrix} or \code{data.frame} with
    observed time series. 
  }
  \item{mod}{
    \code{numeric} vector, column \code{matrix} or \code{data.frame} with
    modelled time series, corresponding to \code{obs}.
  }
  \item{distr}{
    A character string \code{"name"} naming a distribution for which the
    corresponding density function (\code{dname}), the corresponding
    distribution function (\code{pname}) and the quantile function
    (\code{qname}) must be defined (see for example
    \code{\link{GammaDist}}, \code{\link{berngamma}} or
    \code{\link{bernweibull}}. 
  }
  \item{start.fun}{
    function estimating starting values for parameter
    optimisation. Default starting values are provided for
    \code{\link{berngamma}}, \code{\link{bernweibull}},
      \code{\link{bernlnorm}}, \code{\link{bernexp}} and the  
    distributions mentioned in the documentation of
    \code{\link{mledist}}.
  }
  \item{qstep}{
    \code{NULL} or a numeric value between 0 and 1.
    If \code{!is.null(qstep)} than \code{mod} and \code{obs} are
    aggregated to quantiles before model identification as:
    
    \code{quantile(x,probs=seq(0,1,by=qstep)}. This effectively reduces
    the sample-size and can be used to speedup computations - but may
    render estimates less reliable.
  }
  \item{mlepar}{
    a named list. Names correspond to parameters passed to
    \code{\link{mledist}} note that \code{start} may be overwritten by
    \code{start.fun} See examples.  
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
  Quantile mapping using distribution derived transformations to adjust
  the distribution of a modelled variable (\eqn{P_m}) such that it
  matches the distribution of an observed variable (\eqn{P_o}). The
  distribution derived transfer function is  defined as 
  %%
  \deqn{P_o=F^{-1}_o(F_m(P_m))}
  %%
  where \eqn{F} is a CDF and \eqn{F^{-1}} is the corresponding quantile
  function (inverse CDF). The subscripts \eqn{o}  and \eqn{m} indicate
  parameters of the distribution that correspond to observed and
  modelled data respectively.   
}

\value{
  \code{fitQmapDIST} returns an object of class \code{fitQmapDIST}
  containing following elements:
  \item{tfun }{The function used to transform the distribution of
    modelled values such that the distribution of observations. The
    function is build internally based on the distribution function
    ("pname") and quantile function ("qname") corresponding to
    \code{distr}.}  
  \item{par }{A matrix. The (named) columns correspond to the parameters
    of the distribution specified in \code{distr} estimated for the
    observed (suffix \code{.o}) and the modelled (suffix \code{.m})
    data. The rows correspond to each pair of time series in \code{obs}
    and \code{mod}.}
  \code{doQmapDIST} returns a \code{numeric} vector, \code{matrix} or
  \code{data.frame} depending on the format of \code{x}. 
}



\references{
  Piani, C.; Haerter, J. & Coppola, E. Statistical bias correction for
  daily precipitation in regional climate models over
  Europe. Theoretical and Applied Climatology, 2010, 99,
  187-192, doi:10.1007/s00704-009-0134-9.

  Li, H.; Sheffield, J. & Wood, E. F. Bias correction of monthly
  precipitation and temperature fields from Intergovernmental Panel on
  Climate Change AR4 models using equidistant quantile matching.
  J. Geophys. Res., 2010, 115, D10101, doi:10.1029/2009JD012882.

  Ines, A. V. & Hansen, J. W. Bias correction of daily GCM rainfall for
  crop simulation studies. Agricultural and Forest Meteorology, 2006,
  138, 44 - 53, doi: 10.1016/j.agrformet.2006.03.009.

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
    \code{\link{doQmap}}, \code{\link{startberngamma}},
    \code{\link{berngamma}}, \code{\link{startbernweibull}},
    \code{\link{bernweibull}}, \code{\link{startbernlnorm}},
    \code{\link{bernlnorm}}, \code{\link{startbernexp}},
    \code{\link{bernexp}}, \code{\link{mledist}}, \code{\link{fitdist}}
}
\examples{
data(obsprecip)
data(modprecip)

qm.fit <- fitQmapDIST(obsprecip[,1],modprecip[,1],
                      distr="berngamma",
                      qstep=0.001)
qm <- doQmapDIST(modprecip[,1],qm.fit)


qm.lnorm.fit <- fitQmapDIST(obsprecip[,1],modprecip[,1],
                      distr="bernlnorm",
                      qstep=0.001)
qm.lnorm <- doQmapDIST(modprecip[,1],qm.lnorm.fit)


qm.weibu.fit <- fitQmapDIST(obsprecip[,1],modprecip[,1],
                      distr="bernweibull",
                      qstep=0.001)
qm.weibu <- doQmapDIST(modprecip[,1],qm.weibu.fit)

qm.exp.fit <- fitQmapDIST(sqrt(obsprecip[,1]),sqrt(modprecip[,1]),
                      distr="bernexp",
                      qstep=0.001)
qm.exp <- doQmapDIST(sqrt(modprecip[,1]),qm.exp.fit)^2


## utility function. 
## plots are easier to investigate if
## precipitation data are sqrt transformed
sqrtquant <- function(x,qstep=0.01){
  qq <- quantile(x,prob=seq(0,1,by=qstep))
  sqrt(qq)
}

plot(sqrtquant(modprecip[,1]),
     sqrtquant(obsprecip[,1]))
lines(sqrtquant(modprecip[,1]),
      sqrtquant(qm),col="red")
lines(sqrtquant(modprecip[,1]),
      sqrtquant(qm.lnorm),col="blue")
lines(sqrtquant(modprecip[,1]),
      sqrtquant(qm.weibu),col="green")
lines(sqrtquant(modprecip[,1]),
      sqrtquant(qm.exp),col="orange")
legend("topleft",
       legend=c("berngamma","bernlnorm","bernweibull","bernexp"),
       lty=1,
       col=c("red","blue","green","orange"))

## effect of qstep on speed of fitting process:
system.time(
qm.a.fit <- fitQmapDIST(obsprecip[,2],modprecip[,2],
                       distr="berngamma",
                       start.fun=startberngamma,
                       qstep=0.001)
)

system.time(
qm.b.fit <- fitQmapDIST(obsprecip[,2],modprecip[,2],
                       distr="berngamma",
                       start.fun=startberngamma,
                       qstep=0.01)
)

qm.a <- doQmapDIST(modprecip[,2],qm.a.fit)
qm.b <- doQmapDIST(modprecip[,2],qm.b.fit)

plot(sqrtquant(modprecip[,2]),
     sqrtquant(obsprecip[,2]))
lines(sqrtquant(modprecip[,2]),
     sqrtquant(qm.a),col="red")
lines(sqrtquant(modprecip[,2]),
     sqrtquant(qm.b),col="blue")
legend("topleft",
       legend=c("qstep=0.001","qstep=0.01"),
       col=c("red","blue"),
       lty=1)


## method for matrix
## the sqrt() transformation renders the
## fitting procedure more stable
qm2.fit <- fitQmapDIST(sqrt(obsprecip),sqrt(modprecip),
                       distr="berngamma",
                       qstep=0.001)
qm2 <- doQmapDIST(sqrt(modprecip),qm2.fit)^2

if(!any(is.na(qm2.fit$par))){
  op <- par(mfrow=c(1,3))
  for(i in 1:3){
    plot(sqrtquant(modprecip[,i]),
         sqrtquant(obsprecip[,i]))
    lines(sqrtquant(modprecip[,i]),
          sqrtquant(qm2[,i]),col="red")
  }
 par(op)
}
}

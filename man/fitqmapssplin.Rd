\name{fitQmapSSPLIN}
\alias{fitQmapSSPLIN}
\alias{fitQmapSSPLIN.default}
\alias{fitQmapSSPLIN.matrix}
\alias{fitQmapSSPLIN.data.frame}
\alias{doQmapSSPLIN}
\alias{doQmapSSPLIN.default}
\alias{doQmapSSPLIN.matrix}
\alias{doQmapSSPLIN.data.frame}


%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Quantile mapping using a smoothing spline
}
\description{
  \code{fitQmapSSPLIN} fits a smoothing spline to the quantile-quantile
  plot of observed and modelled time series. \code{doQmapSSPLIN} uses
  the spline function to adjust the distribution of the modelled data
  to match the distribution of the observations.
}
\usage{
fitQmapSSPLIN(obs, mod, ...)
\method{fitQmapSSPLIN}{default}(obs,mod,wet.day=TRUE,qstep=0.01,
spline.par,...)
\method{fitQmapSSPLIN}{matrix}(obs, mod, ...)
\method{fitQmapSSPLIN}{data.frame}(obs, mod, ...)
%%
doQmapSSPLIN(x,fobj,...)
\method{doQmapSSPLIN}{default}(x,fobj,...)
\method{doQmapSSPLIN}{matrix}(x,fobj,...)
\method{doQmapSSPLIN}{data.frame}(x,fobj,...)
}

\arguments{
  \item{obs}{
    \code{numeric} vector, column \code{matrix} or \code{data.frame}
    with observed time  series.
  }
  \item{mod}{
    \code{numeric} vector, column \code{matrix} or \code{data.frame}
    with modelled time series, corresponding to \code{obs}.
  }
  \item{wet.day}{
    \code{logical}, indicating whether to perform wet day correction or
    not. OR a \code{numeric} threshold below which all values are set to
    zero. See details. 
  }
  \item{qstep}{
    \code{NULL} or a numeric value between 0 and 1. See Details.
  }
  \item{spline.par}{
    a named list with parameters passed to \code{\link{smooth.spline}}. 
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
  functions (CDF) of the observed (\code{obs}) and modelled (\code{mod})
  are estimated. If \code{!is.null(qstep)} than \code{mod} and
  \code{obs} are aggregated to quantiles before model identification as: 
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
  distributions corresponding to observed wet days.
}

\value{
  \code{fitQmapSSPLIN} returns an object of class \code{fitQmapSSPLIN}
  containing following elements:
  \item{par }{
    A list containing objects of class \code{smooth.spline.fit}, which
    are equivalent to the value of the element \code{fit} in the output
    of \code{\link{smooth.spline}}. The spline coefficients are checked
    for monotony and adjusted if necessary by replacement with the
    previous value. If \code{mod} is a matrix the names of \code{par}
    correspond to \code{colnames(mod)}. 
  }
  \item{wet.day}{
    \code{logical}, indicating whether to perform wet day correction or
    not. OR a \code{numeric} threshold below which all values are set to
    zero. 
  }

  \code{doQmapSSPLIN} returns a \code{numeric} vector or \code{matrix}
  depending on the format of \code{x}.
}

\author{
  Lukas Gudmundsson
}

\seealso{
  \code{\link{fitQmap}}, \code{\link{smooth.spline}}
}

\examples{
data(obsprecip)
data(modprecip)

qm.a.fit <- fitQmapSSPLIN(obsprecip[,2],modprecip[,2],
                      qstep=0.01,wet.day=TRUE)
qm.a <- doQmapSSPLIN(modprecip[,2],qm.a.fit)

## example on how to use spline.par
## (this example has little effect)
qm.b.fit <- fitQmapSSPLIN(obsprecip[,2],modprecip[,2],
                          qstep=0.01,wet.day=TRUE,
                          spline.par=list(cv=TRUE))
qm.b <- doQmapSSPLIN(modprecip[,2],qm.b.fit)

sqrtquant <- function(x,qstep=0.01){
  qq <- quantile(x,prob=seq(0,1,by=qstep))
  sqrt(qq)
}

plot(sqrtquant(modprecip[,2]),
     sqrtquant(obsprecip[,2]))
lines(sqrtquant(modprecip[,2]),
      sqrtquant(qm.a),col="red")
lines(sqrtquant(modprecip[,2]),
      sqrtquant(qm.b),col="blue")
legend("topleft",legend=c("cv=FALSE","cv=TRUE"),
       lty=1,col=c("red","blue"))

qm2.fit <- fitQmapSSPLIN(obsprecip,modprecip,
                      qstep=0.1,wet.day=TRUE)
qm2 <- doQmapSSPLIN(modprecip,qm2.fit)


op <- par(mfrow=c(1,3))
for(i in 1:3){
  plot(sqrtquant(modprecip[,i]),
       sqrtquant(obsprecip[,i]),
       main=names(qm2)[i])
  lines(sqrtquant(modprecip[,i]),
        sqrtquant(qm2[,i]),col="red")
}
par(op)

}


\name{fitQmapRQUANT}
\alias{fitQmapRQUANT}
\alias{fitQmapRQUANT.default}
\alias{fitQmapRQUANT.matrix}
\alias{fitQmapRQUANT.data.frame}
\alias{doQmapRQUANT}
\alias{doQmapRQUANT.default}
\alias{doQmapRQUANT.matrix}
\alias{doQmapRQUANT.data.frame}

\title{
  Non-parametric quantile mapping using robust empirical quantiles.  
}

\description{
  \code{fitQmapRQUANT} estimates the values of the quantile-quantile
  relation of observed and modelled time series for regularly spaced
  quantiles using local linear least square
  regression. \code{doQmapRQUANT} performs quantile mapping by
  interpolating the empirical quantiles.    
}

\usage{
fitQmapRQUANT(obs, mod, ...)
\method{fitQmapRQUANT}{default}(obs,mod,wet.day=TRUE,qstep=0.01,
nlls = 10,nboot = 10,...)
\method{fitQmapRQUANT}{matrix}(obs, mod, ...)
\method{fitQmapRQUANT}{data.frame}(obs, mod, ...)
%%
doQmapRQUANT(x,fobj,...)
\method{doQmapRQUANT}{default}(x,fobj,slope.bound=c(lower=0,upper=Inf), 
type=c("linear","linear2","tricub"),...)
\method{doQmapRQUANT}{matrix}(x,fobj,...)
\method{doQmapRQUANT}{data.frame}(x,fobj,...)
}

\arguments{
  \item{obs}{
    \code{numeric} vector, column \code{matrix} or \code{data.frame}
    with observed time series. 
  }
  \item{mod}{
    \code{numeric} vector or column \code{matrix}/\code{data.frame} with
    modelled time series, corresponding to \code{obs}
  }
  \item{wet.day}{
    \code{logical}, indicating whether to perform wet day correction or
    not. OR a \code{numeric} threshold below which all values are set to
    zero. See details. 
  }
  \item{qstep}{
    A numeric value between 0 and 1. The values quantile-quantile plot
    are estimated at the position of the values defined by:
    
    \code{quantile(mod,probs=seq(0,1,by=qstep)}.
  }
  \item{nlls}{
    number of nearest data points to apply in the local regression
  }
  \item{nboot}{
    number of bootstrap samples in the estimation of the
    transformation. If \code{nboot==1} the estimation is based on all 
    (and not resampled) data. 
  }
  \item{x}{
    \code{numeric} vector or a column \code{matrix} of modelled time
    series
  }
  \item{fobj}{
    output from \code{fitQmapRQUANT}
  }
  \item{slope.bound}{
    bounds for the slopes in case of extrapolation. Applies only if
    \code{type="linear2"}    
  }
  \item{type}{
    type of interpolation between the fitted transformed
    values. See details
  }
  \item{\dots}{
    Further arguments passed to methods
  }
}

\details{
  \code{fitQmapRQUANT} produces a robust estimate of the empirical
  quantile-quantile plot (QQ-plot) of \code{mod} vs \code{obs} for the
  \code{seq(0,1,by=qstep)} quantiles \code{mod}. The corresponding value 
  of the quantiles of \code{obs} is estimated using local linear least
  squares regression. For each quantile of \code{mod} the \code{nlls}
  nearest data points in the QQ-plot are identified and used to fit a
  local regression line. This regression line is then used to estimate
  value of the quantile of \code{obs}. The estimation is replicated for
  \code{nboot} bootstrap samples and the mean of the bootstrap
  replicates is returned.

  This procedure results in a table with empirical quantiles of
  \code{mod} and a corresponding table with robust estimates of the
  empirical quantiles of \code{obs}. 

  \code{doQmapRQUANT} uses the tables of robust empirical quantiles
  identified using \code{fitQmapRQUANT} to transform the variable
  \code{x}. For values that are not in

  \code{quantile(mod,probs=seq(0,1,by=qstep))} the transformation is
  estimated using interpolation of the fitted  values. Available
  interpolation options are:

  \code{type="linear"}: linear interpolation using \code{\link{approx}}, 
  but using the extrapolation suggested by Boe et al. (2007) for values
  of \code{x} larger than max(mod) (constant correction).
  
  \code{type="linear2"}: linear interpolation using
  \code{\link{approx}}. For any value of \code{x} outside
  \code{range(mod)} the transformation is extrapolated using the slope
  of the local linear least squares regression at the outer most
  points. 

  \code{type="tricube"}: monotonic  tricubic spline interpolation using
  \code{\link{splinefun}}. Spline  interpolation is performed using a
  _monotone_ Hermite spline (\code{method="monoH.FC"} in
  \code{\link{splinefun}}).

  \code{wet.day} is intended for the use for precipitation data. Wet day
  correction  attempts to equalise the fraction of days with
  precipitation between the observed and the modelled data. If
  \code{wet.day=TRUE} the empirical probability of nonzero observations
  is found (\code{obs>=0}) and the corresponding modelled value is
  selected as a threshold. All modelled  values below this threshold are
  set to zero. If \code{wet.day} is \code{numeric} the same procedure is
  performed after setting all \code{obs<wet.day} to zero.
}
\value{
  \code{fitQmapRQUANT} returns an object of class \code{fitQmapRQUANT}
  containing following elements:
  \item{par}{A list containing:}
  \item{par$modq}{
    a matrix. Each column \code{i} corresponds to the output
    of

    \code{quantile(mod[,i],probs=seq(0,1,by=qstep))}.
  }
  \item{par$fitq}{
    the fitted values of the local linear least square regression
    corresponding to \code{par$modq}
  }
  \item{par$slope}{
    a matrix. the columns correspond to the columns of \code{mod}. The
    rows contain the slope of the \code{"lower"} and the \code{"upper"} 
    extreme points of the local linear fit and is used for
    extrapolation if \code{type="linear2"}.    
  }
  \item{wet.day}{
    \code{logical}, indicating whether to perform wet day correction or
    not. OR a \code{numeric} threshold below which all values are set to
    zero. 
  }
  
  \code{doQmapRQUANT} returns a \code{numeric} vector or \code{matrix}
  depending on the format of \code{x}.
}
\references{
  Boe, J.; Terray, L.; Habets, F. & Martin, E. Statistical and dynamical
  downscaling of the Seine basin climate for hydro-meteorological
  studies. International Journal of Climatology, 2007, 27,
  1643-1655. doi: 10.1002/joc.1602.  
}
\author{
  John Bjornar Bremnes and Lukas Gudmundsson
}

\seealso{
\code{\link{fitQmap}}
}

\examples{
data(obsprecip)
data(modprecip)

## single series example
qm.fit <- fitQmapRQUANT(obsprecip[,2],modprecip[,2],
                      qstep=0.1,nboot=10,wet.day=TRUE)
qm.a <- doQmapRQUANT(modprecip[,2],qm.fit,type="linear")
qm.b <- doQmapRQUANT(modprecip[,2],qm.fit,type="tricub")

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
points(sqrt(qm.fit$par$modq),sqrt(qm.fit$par$fitq),
       pch=19,cex=1,col="green")
legend("topleft",
       legend=c("linear","tricub","support","data"),
       lty=c(1,1,NA,NA),pch=c(NA,NA,19,21),
       col=c("red","blue","green","black"))

qm2.fit <- fitQmapRQUANT(obsprecip,modprecip,
                       qstep=0.02,nboot=1,
                       wet.day=TRUE)
qm2 <- doQmapRQUANT(modprecip,qm2.fit,type="tricub")

op <- par(mfrow=c(1,3))
for(i in 1:3){
  plot(sqrtquant(modprecip[,i]),
       sqrtquant(obsprecip[,i]),
       main=names(qm2)[i])
  lines(sqrtquant(modprecip[,i]),
        sqrtquant(qm2[,i]),col="red")
  points(sqrt(qm2.fit$par$modq[,i]),
         sqrt(qm2.fit$par$fitq[,i]),
       pch=19,cex=0.5,col="green")

}
par(op)

}

\name{fitQmapQUANT}
\alias{fitQmapQUANT}
\alias{fitQmapQUANT.default}
\alias{fitQmapQUANT.matrix}
\alias{fitQmapQUANT.data.frame}
\alias{doQmapQUANT}
\alias{doQmapQUANT.default}
\alias{doQmapQUANT.matrix}
\alias{doQmapQUANT.data.frame}

\title{
  Non-parametric quantile mapping using empirical quantiles.  
}

\description{
  \code{fitQmapQUANT} estimates values of the empirical cumulative
  distribution function of observed and modelled time series for
  regularly spaced quantiles. \code{doQmapQUANT} uses these estimates to
  perform quantile mapping. 
}

\usage{
fitQmapQUANT(obs, mod, ...)
\method{fitQmapQUANT}{default}(obs,mod,wet.day=TRUE,qstep=0.01,
nboot = 1,...)
\method{fitQmapQUANT}{matrix}(obs, mod, ...)
\method{fitQmapQUANT}{data.frame}(obs, mod, ...)
%%
doQmapQUANT(x,fobj,...)
\method{doQmapQUANT}{default}(x,fobj, type=c("linear","tricub"),...)
\method{doQmapQUANT}{matrix}(x,fobj,...)
\method{doQmapQUANT}{data.frame}(x,fobj,...)
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
  \item{wet.day}{
    \code{logical} indicating whether to perform wet day correction or
    not. OR a \code{numeric} threshold below which all values are set to
    zero. See details.
  }
  \item{qstep}{
    a numeric value between 0 and 1. The quantile mapping is fitted only
    for the quantiles defined by
    \code{quantile(0,1,probs=seq(0,1,by=qstep)}. 
  }
  \item{nboot}{
    number of bootstrap samples used for estimation of the observed
    quantiles. If \code{nboot==1} the estimation is based on all (and
    not resampled) data. See details.   
  }
  \item{x}{
    \code{numeric} vector or a column \code{matrix} of modelled time
    series
  }
  \item{fobj}{
    output from \code{fitQmapQUANT}
  }
  \item{type}{
    type of interpolation between the fitted transformed
    values. See details.
  }
  \item{\dots}{
    Further arguments passed to methods
  }
}

\details{
  \code{fitQmapQUANT} estimates the empirical cumulative distribution
  function of \code{mod} and \code{obs} for the quantiles defined by
  \code{seq(0,1,by=qstep)}. The quantiles of \code{mod} are estimated
  using the empirical quantiles. If \code{nboot>1} the quantiles of
  \code{obs} are estimated as the mean of \code{nboot} bootstrap
  samples (if \code{nboot>1}).  

  \code{doQmapQUANT} transforms the variable \code{x} based on the
  transformation identified using \code{fitQmapQUANT}. 
  For all values that are not in
  \code{quantile(mod,probs=seq(0,1,by=qstep))} the  transformation is
  estimated using interpolation of the fitted  values. Available
  interpolation options are: 

  \code{type="linear"}: linear interpolation using \code{\link{approx}}, 
  but using the extrapolation suggested by Boe et al. (2007) for values
  of \code{x} larger than \code{max(mod)} (constant correction). 
   
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
  \code{fitQmapQUANT} returns an object of class \code{fitQmapQUANT}
  containing following elements:
  \item{par}{A list containing:}
  \item{par$modq}{
    a matrix. Each column \code{i} corresponds to the output
    of \code{quantile(mod[,i],probs=seq(0,1,by=qstep))}.
  }
  \item{par$fitq}{
    observed empirical quantiles corresponding to \code{par$modq}. 
  }
  \item{wet.day}{
    \code{logical}, indicating whether to perform wet day correction or
    not. OR a \code{numeric} threshold below which all values are set to
    zero. 
  }
  
  \code{doQmapQUANT} returns a \code{numeric} vector or \code{matrix}
  depending on the format of \code{x}.
}
\references{
  Boe, J.; Terray, L.; Habets, F. & Martin, E. Statistical and dynamical
  downscaling of the Seine basin climate for hydro-meteorological
  studies. International Journal of Climatology, 2007, 27,
  1643-1655, <doi:10.1002/joc.1602>.

  For a general assessment of the methods see:

  Gudmundsson, L.; Bremnes, J. B.; Haugen, J. E. & Engen-Skaugen,
  T. Technical Note: Downscaling RCM precipitation to the station scale
  using statistical transformations - a comparison of methods. Hydrology
  and Earth System Sciences, 2012, 16, 3383-3390,
  <doi:10.5194/hess-16-3383-2012>.   

}
\author{
  Lukas Gudmundsson
}

\seealso{
\code{\link{fitQmap}}
}

\examples{
data(obsprecip)
data(modprecip)

qm.fit <- fitQmapQUANT(obsprecip[,2],modprecip[,2],
                      qstep=0.1,nboot=1,wet.day=TRUE)
qm.a <- doQmapQUANT(modprecip[,2],qm.fit,type="linear")
qm.s <- doQmapQUANT(modprecip[,2],qm.fit,type="tricub")


sqrtquant <- function(x,qstep=0.01){
  qq <- quantile(x,prob=seq(0,1,by=qstep))
  sqrt(qq)
}

plot(sqrtquant(modprecip[,2]),
     sqrtquant(obsprecip[,2]))
lines(sqrtquant(modprecip[,2]),
      sqrtquant(qm.a),col="red")
lines(sqrtquant(modprecip[,2]),
      sqrtquant(qm.s),col="blue")
points(sqrt(qm.fit$par$modq),sqrt(qm.fit$par$fitq),
       pch=19,cex=0.5,col="green")
legend("topleft",
       legend=c("linear","tricub","support"),
       lty=c(1,1,NA),pch=c(NA,NA,19),
       col=c("red","blue","green"))
         

qm2.fit <- fitQmapQUANT(obsprecip,modprecip,
                      qstep=0.01,nboot=1,wet.day=TRUE)
qm2 <- doQmapQUANT(modprecip,qm2.fit,type="tricub")

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
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

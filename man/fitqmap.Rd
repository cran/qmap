\name{fitQmap}
\alias{fitQmap}
\alias{doQmap}

\title{
  Quantile mapping
}

\description{
  \code{fitQmap} identifyes the parameters of different quantile mapping
  methods. \code{doQmap} performs quantile  mapping using previously
  identified parameters.  
}

\usage{
fitQmap(obs,mod,method=c("PTF","DIST","RQUANT","QUANT","SSPLIN"),...)
doQmap(x, fobj, ...)
}

\arguments{
  \item{obs}{
    \code{numeric} vector, column \code{matrix} or \code{data.frame} with
    observed time series. 
  }
  \item{mod}{
    \code{numeric} vector, column \code{matrix} or \code{data.frame} with
    modelled time series corresponding to \code{obs}.
  }
  \item{method}{
    A character string indicating the method to be used. See Details.
  }
  \item{x}{
    \code{numeric} vector or a column \code{matrix} of modelled time
    series. Should have the same number of columns as \code{obs}.
  }
  \item{fobj}{
    output from \code{fitQmap} (or of method defined via
    \code{method}).
  }

  \item{\dots}{
    arguments passed to the method specified by \code{method}. 
  }
}

\details{
  The \code{method} argument decides upon which method for quantile
  mapping is used:

  \code{"PTF"} selects \code{\link{fitQmapPTF}}.

  \code{"DIST"} selects \code{\link{fitQmapDIST}}

  \code{"RQUANT"} selects \code{\link{fitQmapRQUANT}}

  \code{"QUANT"} selects \code{\link{fitQmapQUANT}}

  \code{"SSPLIN"} selects \code{\link{fitQmapSSPLIN}}  

  \code{doQmap} investigates the class of \code{fobj} and chooses the
  appropriate method for quantile mapping.
}

\value{
  \code{fitQmap} returns an object which class and structure depends on
  the selected \code{method} (see Details). 

  \code{doQmap} returns a \code{numeric} vector, \code{matrix} or
  \code{data.frame} depending on the format of \code{x}. 
}

\references{
  Gudmundsson, L.; Bremnes, J. B.; Haugen, J. E. & Engen-Skaugen,
  T. Technical Note: Downscaling RCM precipitation to the station scale
  using statistical transformations - a comparison of methods, Hydrology
  and Earth System Sciences, 2012, 16, 3383-3390,
  doi:10.5194/hess-16-3383-2012.  
}

\author{
  Lukas Gudmundsson
}



\seealso{
  \code{\link{fitQmapDIST}}, \code{\link{fitQmapPTF}},
  \code{\link{fitQmapRQUANT}}, \code{\link{fitQmapQUANT}},
  \code{\link{fitQmapSSPLIN}} 
}

\examples{
data(obsprecip)
data(modprecip)

## call to fitQmapPTF and doQmapPTF
qm1.fit <- fitQmap(obsprecip,modprecip,
              method="PTF",
              transfun="expasympt",
              cost="RSS",wett.day=TRUE)
qm1 <- doQmap(modprecip,qm1.fit)

## call to fitQmapDIST and doQmapDIST
qm2.fit <- fitQmap(sqrt(obsprecip),sqrt(modprecip),
              method="DIST",qstep=0.001,
              transfun="berngamma")
qm2 <- doQmap(sqrt(modprecip),qm2.fit)^2

## call to fitQmapRQUANT and doQmapRQUANT
qm3.fit <- fitQmap(obsprecip,modprecip,
              method="RQUANT",qstep=0.01)
qm3 <- doQmap(modprecip,qm3.fit,type="linear")


## call to fitQmapRQUANT and doQmapRQUANT
qm4.fit <- fitQmap(obsprecip,modprecip,
              method="QUANT",qstep=0.01)
qm4 <- doQmap(modprecip,qm4.fit,type="tricub")

## call to fitQmapSSPLIN and doQmapSSPLIN
qm5.fit <- fitQmap(obsprecip,modprecip,qstep=0.01,
                   method="SSPLIN")
qm5 <- doQmap(modprecip,qm5.fit)

sqrtquant <- function(x,qstep=0.001){
  qq <- quantile(x,prob=seq(0,1,by=qstep))
  sqrt(qq)
}

op <- par(mfrow=c(1,3))
for(i in 1:3){
  plot(sqrtquant(modprecip[,i]),
       sqrtquant(obsprecip[,i]),pch=19,col="gray",
       main=names(obsprecip)[i])
  lines(sqrtquant(modprecip[,i]),
        sqrtquant(qm1[,i]),col=1)
  lines(sqrtquant(modprecip[,i]),
        sqrtquant(qm2[,i]),col=2)
  lines(sqrtquant(modprecip[,i]),
        sqrtquant(qm3[,i]),col=3)
  lines(sqrtquant(modprecip[,i]),
        sqrtquant(qm4[,i]),col=4)
  lines(sqrtquant(modprecip[,i]),
        sqrtquant(qm5[,i]),col=5)
}
legend("topleft",
       legend=c("PTF","DIST","RQUANT","QUANT","SSPLIN"),
       lty=1, col=1:5)
par(op)
}

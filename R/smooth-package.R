#' Smooth package
#'
#' Package contains several exponential (and not) smoothing functions used in
#' time series analysis and forecasting.
#'
#' \tabular{ll}{ Package: \tab smooth\cr Type: \tab Package\cr Date: \tab
#' 2016-01-27 - Inf\cr License: \tab GPL-2 \cr } The following functions are
#' included in the package:
#' \itemize{
#' \item \link[smooth]{es} - Exponential Smoothing in Single Source of Errors State Space form.
#' \item \link[smooth]{ces} - Complex Exponential Smoothing.
#' \item \link[smooth]{ges} - Generalised Exponential Smoothing.
#' \item \link[smooth]{ssarima} - SARIMA in state-space framework.
#' % \item \link[smooth]{nus} - Non-Uniform Smoothing.
#' \item \link[smooth]{auto.ces} - Automatic selection between seasonal and non-seasonal CES.
#' \item \link[smooth]{auto.ssarima} - Automatic selection of ARIMA orders.
#' \item \link[smooth]{sma} - Simple Moving Average in state-space form.
#' \item \link[smooth]{sim.es} - simulate time series using ETS as a model.
#' \item \link[smooth]{sim.ces} - simulate time series using CES as a model.
#' \item \link[smooth]{sim.ssarima} - simulate time series using SARIMA as a model.
#' % \item \link[smooth]{sim.ges} - simulate time series using GES as a model.
#' \item \link[smooth]{iss} - intermittent data state-space model. This
#' function models the part with data occurances using one of three methods.
#' }
#' There are also several methods implemented in the package for the classes
#' "smooth" and "smooth.sim":
#' \itemize{
#' \item \link[smooth]{orders} - extracts orders of the fitted model.
#' \item \link[smooth]{lags} - extracts lags of the fitted model.
#' \item \link[smooth]{model.type} - extracts type of the fitted model.
#' \item \link[smooth]{AICc} - extracts AICc of the fitted model.
#' \item forecast - produces forecast using provided model.
#' \item fitted - extracts fitted values from provided model.
#' \item getResponse - returns actual values from the provided model.
#' \item residuals - extracts residuals of provided model.
#' \item plot - plots either states of the model or produced forecast (depending on what object is passed).
#' \item simulate - uses sim functions in order to simulate data using the provided object.
#' \item summary - provides summary of the object.
#' }
#'
#' @name smooth
#' @docType package
#' @author Ivan Svetunkov
#'
#' Maintainer: Ivan Svetunkov <ivan@@svetunkov.ru>
#' @seealso \code{\link[forecast:forecast]{forecast}, \link[smooth]{es},
#' \link[smooth]{ssarima}, \link[smooth]{ces}, \link[smooth]{ges}}
#' @references \itemize{
#' \item Croston, J. (1972) Forecasting and stock control for intermittent demands. Operational Research Quarterly, 23(3), 289-303.
#' \item Hyndman, R.J., Koehler, A.B., Ord, J.K., and Snyder, R.D. (2008) Forecasting with exponential smoothing: the state space approach, Springer-Verlag. \url{http://www.exponentialsmoothing.net}.
#' \item Kolassa, S. (2011) Combining exponential smoothing forecasts using Akaike weights. International Journal of Forecasting, 27, pp 238 - 251.
#' \item Svetunkov, I., Kourentzes, N. (February 2015). Complex exponential smoothing. Working Paper of Department of Management Science, Lancaster University 2015:1, 1-31.
#' \item Svetunkov I., Kourentzes N. (2016) Complex Exponential Smoothing for Time Series Forecasting. Not yet published.
#' \item Svetunkov I., Kourentzes N. (2016) Trace forecast likelihood and shrinkage in time series models. Not yet published.
#' \item Svetunkov S. (2012) Complex-Valued Modeling in Economics and Finance. SpringerLink: Bucher. Springer.
#' \item Taylor, J.W. and Bunn, D.W. (1999) A Quantile Regression Approach to Generating Prediction Intervals. Management Science, Vol 45, No 2, pp 225-237.
#' \item Teunter R., Syntetos A., Babai Z. (2011). Intermittent demand: Linking forecasting to inventory obsolescence. European Journal of Operational Research, 214, 606-615.
#' }
#' @keywords univar ts models smooth regression nonlinear
#' @examples
#'
#' \dontrun{y <- ts(rnorm(100,10,3),frequency=12)
#'
#' es(y,h=20,holdout=TRUE)
#' ges(y,h=20,holdout=TRUE)
#' auto.ces(y,h=20,holdout=TRUE)
#' auto.ssarima(y,h=20,holdout=TRUE)}
#'
#' @import zoo Rcpp
#' @importFrom nloptr nloptr
#' @importFrom graphics abline layout legend lines par points polygon
#' @importFrom stats AIC BIC cov dbeta decompose deltat end frequency is.ts median coef optimize nlminb cor qnorm qt qlnorm quantile rbinom rlnorm rnorm rt runif start time ts var simulate lm as.formula residuals plnorm pnorm
#' @importFrom utils packageVersion
#' @useDynLib smooth, .registration=TRUE
NULL




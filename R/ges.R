utils::globalVariables(c("measurementEstimate","transitionEstimate", "C",
                         "persistenceEstimate","obsAll","obsInsample","multisteps","ot","obsNonzero","ICs","cfObjective",
                         "y.for","y.low","y.high","normalizer"));

#' General Exponential Smoothing
#'
#' Function constructs General Exponential Smoothing, estimating matrices F, w,
#' vector g and initial parameters.
#'
#' The function estimates the Single Source of Error State-space model of the
#' following type:
#'
#' \eqn{y_[t] = o_[t] (w' v_[t-l] + x_t a_[t-1] + \epsilon_[t])}
#'
#' \eqn{v_[t] = F v_[t-l] + g \epsilon_[t]}
#'
#' \eqn{a_[t] = F_[X] a_[t-1] + g_[X] \epsilon_[t] / x_[t]}
#'
#' Where \eqn{o_[t]} is Bernoulli distributed random variable (in case of
#' normal data equal to 1), \eqn{v_[t]} is a state vector (defined using
#' \code{orders}) and \eqn{l} is a vector of \code{lags}, \eqn{x_t} vector of
#' exogenous parameters.
#'
#' @param data The data that needs to be forecasted.
#' @param orders Order of the model. Specified as vector of number of states
#' with different lags. For example, \code{orders=c(1,1)} means that there are
#' two states: one of the first lag type, the second of the second type.
#' @param lags Defines lags for the corresponding orders. If, for example,
#' \code{orders=c(1,1)} and lags are defined as \code{lags=c(1,12)}, then the
#' model will have two states: the first will have lag 1 and the second will
#' have lag 12. The length of \code{lags} must correspond to the length of
#' \code{orders}.
#' @param persistence Persistence vector \eqn{g}, containing smoothing
#' parameters. If \code{NULL}, then estimated.
#' @param transition Transition matrix \eqn{F}. Can be provided as a vector.
#' Matrix will be formed using the default \code{matrix(transition,nc,nc)},
#' where \code{nc} is the number of components in state vector. If \code{NULL},
#' then estimated.
#' @param measurement Measurement vector \eqn{w}. If \code{NULL}, then
#' estimated.
#' @param initial Can be either character or a vector of initial states. If it
#' is character, then it can be \code{"optimal"}, meaning that the initial
#' states are optimised, or \code{"backcasting"}, meaning that the initials are
#' produced using backcasting procedure.
#' @param ic Information criterion to use in model selection.
#' @param cfType Type of Cost Function used in optimization. \code{cfType} can
#' be: \code{MSE} (Mean Squared Error), \code{MAE} (Mean Absolute Error),
#' \code{HAM} (Half Absolute Moment), \code{MLSTFE} - Mean Log Squared Trace
#' Forecast Error, \code{MSTFE} - Mean Squared Trace Forecast Error and
#' \code{MSEh} - optimisation using only h-steps ahead error. If
#' \code{cfType!="MSE"}, then likelihood and model selection is done based on
#' equivalent \code{MSE}. Model selection in this cases becomes not optimal.
#'
#' There are also available analytical approximations for multistep functions:
#' \code{aMSEh}, \code{aMSTFE} and \code{aMLSTFE}. These can be useful in cases
#' of small samples.
#' @param h The forecasting horizon.
#' @param holdout If \code{TRUE}, holdout of size \code{h} is taken from the
#' end of the data.
#' @param intervals Type of intervals to construct. This can be:
#'
#' \itemize{
#' \item \code{none}, aka \code{n} - do not produce prediction
#' intervals.
#' \item \code{parametric}, \code{p} - use state-space structure of ETS. In
#' case of mixed models this is done using simulations, which may take longer
#' time than for the pure additive and pure multiplicative models.
#' \item \code{semiparametric}, \code{sp} - intervals based on covariance
#' matrix of 1 to h steps ahead errors and assumption of normal / log-normal
#' distribution (depending on error type).
#' \item \code{nonparametric}, \code{np} - intervals based on values from a
#' quantile regression on error matrix (see Taylor and Bunn, 1999). The model
#' used in this process is e[j] = a j^b, where j=1,..,h.
#' %\item Finally \code{asymmetric} are based on half moment of distribution.
#' }
#'
#' The parameter also accepts \code{TRUE} and \code{FALSE}. Former means that
#' parametric intervals are constructed, while latter is equivalent to
#' \code{none}.
#' @param level Confidence level. Defines width of prediction interval.
#' @param intermittent Defines type of intermittent model used. Can be: 1.
#' \code{none}, meaning that the data should be considered as non-intermittent;
#' 2. \code{fixed}, taking into account constant Bernoulli distribution of
#' demand occurancies; 3. \code{croston}, based on Croston, 1972 method with
#' SBA correction; 4. \code{tsb}, based on Teunter et al., 2011 method. 5.
#' \code{auto} - automatic selection of intermittency type based on information
#' criteria. The first letter can be used instead. 6. \code{"sba"} -
#' Syntetos-Boylan Approximation for Croston's method (bias correction)
#' discussed in Syntetos and Boylan, 2005.
#' @param bounds What type of bounds to use for smoothing parameters
#' ("admissible" or "usual"). The first letter can be used instead of the whole
#' word.
#' @param silent If \code{silent="none"}, then nothing is silent, everything is
#' printed out and drawn. \code{silent="all"} means that nothing is produced or
#' drawn (except for warnings). In case of \code{silent="graph"}, no graph is
#' produced. If \code{silent="legend"}, then legend of the graph is skipped.
#' And finally \code{silent="output"} means that nothing is printed out in the
#' console, but the graph is produced. \code{silent} also accepts \code{TRUE}
#' and \code{FALSE}. In this case \code{silent=TRUE} is equivalent to
#' \code{silent="all"}, while \code{silent=FALSE} is equivalent to
#' \code{silent="none"}. The parameter also accepts first letter of words ("n",
#' "a", "g", "l", "o").
#' @param xreg Vector (either numeric or time series) or matrix (or data.frame)
#' of exogenous variables that should be included in the model. If matrix
#' included than columns should contain variables and rows - observations. Note
#' that \code{xreg} should have number of observations equal either to
#' in-sample or to the whole series. If the number of observations in
#' \code{xreg} is equal to in-sample, then values for the holdout sample are
#' produced using Naive.
#' @param xregDo Variable defines what to do with the provided xreg:
#' \code{"use"} means that all of the data should be used, whilie
#' \code{"select"} means that a selection using \code{ic} should be done.
#' \code{"combine"} will be available at some point in future...
#' @param initialX Vector of initial parameters for exogenous variables.
#' Ignored if \code{xreg} is NULL.
#' @param updateX If \code{TRUE}, transition matrix for exogenous variables is
#' estimated, introducing non-linear interractions between parameters.
#' Prerequisite - non-NULL \code{xreg}.
#' @param persistenceX Persistence vector \eqn{g_X}, containing smoothing
#' parameters for exogenous variables. If \code{NULL}, then estimated.
#' Prerequisite - non-NULL \code{xreg}.
#' @param transitionX Transition matrix \eqn{F_x} for exogenous variables. Can
#' be provided as a vector. Matrix will be formed using the default
#' \code{matrix(transition,nc,nc)}, where \code{nc} is number of components in
#' state vector. If \code{NULL}, then estimated. Prerequisite - non-NULL
#' \code{xreg}.
#' @param ...  Other non-documented parameters.  For example parameter
#' \code{model} can accept a previously estimated GES model and use all its
#' parameters.  \code{FI=TRUE} will make the function produce Fisher
#' Information matrix, which then can be used to calculated variances of
#' parameters of the model.
#' @return Object of class "smooth" is returned. It contains:
#'
#' \itemize{
#' \item \code{model} - name of the estimated model.
#' \item \code{timeElapsed} - time elapsed for the construction of the model.
#' \item \code{states} - matrix of fuzzy components of GES, where \code{rows}
#' correspond to time and \code{cols} to states.
#' \item \code{initialType} - Typetof initial values used.
#' \item \code{initial} - initial values of state vector (extracted from
#' \code{states}).
#' \item \code{nParam} - number of estimated parameters.
#' \item \code{measurement} - matrix w.
#' \item \code{transition} - matrix F.
#' \item \code{persistence} - persistence vector. This is the place, where
#' smoothing parameters live.
#' \item \code{fitted} - fitted values of ETS.
#' \item \code{forecast} - point forecast of ETS.
#' \item \code{lower} - lower bound of prediction interval. When
#' \code{intervals="none"} then NA is returned.
#' \item \code{upper} - higher bound of prediction interval. When
#' \code{intervals="none"} then NA is returned.
#' \item \code{residuals} - the residuals of the estimated model.
#' \item \code{errors} - matrix of 1 to h steps ahead errors.
#' \item \code{s2} - variance of the residuals (taking degrees of freedom
#' into account).
#' \item \code{intervals} - type of intervals asked by user.
#' \item \code{level} - confidence level for intervals.
#' \item \code{actuals} - original data.
#' \item \code{holdout} - holdout part of the original data.
#' \item \code{iprob} - fitted and forecasted values of the probability of demand
#' occurrence.
#' \item \code{intermittent} - type of intermittent model fitted to the data.
#' \item \code{xreg} - provided vector or matrix of exogenous variables. If
#' \code{xregDo="s"}, then this value will contain only selected exogenous variables.
#' \item \code{updateX} - boolean, defining, if the states of exogenous variables
#' were estimated as well.
#' \item \code{initialX} - initial values for parameters of exogenous variables.
#' \item \code{persistenceX} - persistence vector g for exogenous variables.
#' \item \code{transitionX} - transition matrix F for exogenous variables.
#' \item \code{ICs} - values of information criteria of the model. Includes
#' AIC, AICc and BIC.
#' \item \code{logLik} - log-likelihood of the function.
#' \item \code{cf} - Cost function value.
#' \item \code{cfType} - Type of cost function used in the estimation.
#' \item \code{FI} - Fisher Information. Equal to NULL if \code{FI=FALSE} or
#' when \code{FI} variable is not provided at all.
#' \item \code{accuracy} - vector of accuracy measures for the holdout sample.
#' In case of non-intermittent data includes: MPE, MAPE, SMAPE, MASE, sMAE,
#' RelMAE, sMSE and Bias coefficient (based on complex numbers). In case of
#' intermittent data the set of errors will be: sMSE, sPIS, sCE (scaled
#' cumulative error) and Bias coefficient. This is available only when
#' \code{holdout=TRUE}.
#' }
#' @seealso \code{\link[forecast]{ets}, \link[smooth]{es}, \link[smooth]{ces},
#' \link[smooth]{sim.es}}
#' @references \enumerate{
#' \item Teunter R., Syntetos A., Babai Z. (2011). Intermittent demand:
#' Linking forecasting to inventory obsolescence. European Journal of
#' Operational Research, 214, 606-615.
#' \item Croston, J. (1972) Forecasting and stock control for intermittent
#' demands. Operational Research Quarterly, 23(3), 289-303.
#' \item Syntetos, A., Boylan J. (2005) The accuracy of intermittent demand
#' estimates. International Journal of Forecasting, 21(2), 303-314.
#' }
#' @keywords ges Exponential Smoothing
#' @examples
#'
#' # Something simple:
#' ges(rnorm(118,100,3),orders=c(1),lags=c(1),h=18,holdout=TRUE,bounds="a",intervals="p")
#'
#' # A more complicated model with seasonality
#' \dontrun{ourModel <- ges(rnorm(118,100,3),orders=c(2,1),lags=c(1,4),h=18,holdout=TRUE)}
#'
#' # Redo previous model on a new data and produce prediction intervals
#' \dontrun{ges(rnorm(118,100,3),model=ourModel,h=18,intervals="sp")}
#'
#' # Produce something crazy with optimal initials (not recommended)
#' \dontrun{ges(rnorm(118,100,3),orders=c(1,1,1),lags=c(1,3,5),h=18,holdout=TRUE,initial="o")}
#'
#' # Simpler model estiamted using trace forecast error cost function and its analytical analogue
#' \dontrun{ges(rnorm(118,100,3),orders=c(1),lags=c(1),h=18,holdout=TRUE,bounds="n",cfType="MSTFE")
#' ges(rnorm(118,100,3),orders=c(1),lags=c(1),h=18,holdout=TRUE,bounds="n",cfType="aMSTFE")}
#'
#' # Introduce exogenous variables
#' \dontrun{ges(rnorm(118,100,3),orders=c(1),lags=c(1),h=18,holdout=TRUE,xreg=c(1:118))}
#'
#' # Ask for their update
#' \dontrun{ges(rnorm(118,100,3),orders=c(1),lags=c(1),h=18,holdout=TRUE,xreg=c(1:118),updateX=TRUE)}
#'
#' # Do the same but now let's shrink parameters...
#' \dontrun{ges(rnorm(118,100,3),orders=c(1),lags=c(1),h=18,xreg=c(1:118),updateX=TRUE,cfType="MSTFE")
#' ourModel <- ges(rnorm(118,100,3),orders=c(1),lags=c(1),h=18,holdout=TRUE,cfType="aMSTFE")}
#'
#' # Or select the most appropriate one
#' \dontrun{ges(rnorm(118,100,3),orders=c(1),lags=c(1),h=18,holdout=TRUE,xreg=c(1:118),xregDo="s")
#'
#' summary(ourModel)
#' forecast(ourModel)
#' plot(forecast(ourModel))}
#'
#' @export ges
ges <- function(data, orders=c(1,1), lags=c(1,frequency(data)),
                persistence=NULL, transition=NULL, measurement=NULL,
                initial=c("optimal","backcasting"), ic=c("AICc","AIC","BIC"),
                cfType=c("MSE","MAE","HAM","MLSTFE","MSTFE","MSEh"),
                h=10, holdout=FALSE,
                intervals=c("none","parametric","semiparametric","nonparametric"), level=0.95,
                intermittent=c("none","auto","fixed","croston","tsb","sba"),
                bounds=c("admissible","none"),
                silent=c("none","all","graph","legend","output"),
                xreg=NULL, xregDo=c("use","select"), initialX=NULL,
                updateX=FALSE, persistenceX=NULL, transitionX=NULL, ...){
# General Exponential Smoothing function. Crazy thing...
#
#    Copyright (C) 2016  Ivan Svetunkov

# Start measuring the time of calculations
    startTime <- Sys.time();

# Add all the variables in ellipsis to current environment
    list2env(list(...),environment());

    # If a previous model provided as a model, write down the variables
    if(exists("model",inherits=FALSE)){
        if(is.null(model$model)){
            stop("The provided model is not GES.",call.=FALSE);
        }
        else if(gregexpr("GES",model$model)==-1){
            stop("The provided model is not GES.",call.=FALSE);
        }
        intermittent <- model$intermittent;
        if(any(intermittent==c("p","provided"))){
            warning("The provided model had predefined values of occurences for the holdout. We don't have them.",call.=FALSE);
            warning("Switching to intermittent='auto'.",call.=FALSE);
            intermittent <- "a";
        }
        initial <- model$initial;
        persistence <- model$persistence;
        transition <- model$transition;
        measurement <- model$measurement;
        if(is.null(xreg)){
            xreg <- model$xreg;
        }
        initialX <- model$initialX;
        persistenceX <- model$persistenceX;
        transitionX <- model$transitionX;
        if(any(c(persistenceX)!=0) | any((transitionX!=0)&(transitionX!=1))){
            updateX <- TRUE;
        }
        model <- model$model;
        orders <- as.numeric(substring(model,unlist(gregexpr("\\[",model))-1,unlist(gregexpr("\\[",model))-1));
        lags <- as.numeric(substring(model,unlist(gregexpr("\\[",model))+1,unlist(gregexpr("\\]",model))-1));
    }

##### Set environment for ssInput and make all the checks #####
    environment(ssInput) <- environment();
    ssInput(modelType="ges",ParentEnvironment=environment());

##### Initialise ges #####
ElementsGES <- function(C){
    n.coef <- 0;
    if(measurementEstimate){
        matw <- matrix(C[n.coef+(1:nComponents)],1,nComponents);
        n.coef <- n.coef + nComponents;
    }
    else{
        matw <- matrix(measurement,1,nComponents);
    }

    if(transitionEstimate){
        matF <- matrix(C[n.coef+(1:(nComponents^2))],nComponents,nComponents);
        n.coef <- n.coef + nComponents^2;
    }
    else{
        matF <- matrix(transition,nComponents,nComponents);
    }

    if(persistenceEstimate){
        vecg <- matrix(C[n.coef+(1:nComponents)],nComponents,1);
        n.coef <- n.coef + nComponents;
    }
    else{
        vecg <- matrix(persistence,nComponents,1);
    }

    vt <- matrix(NA,maxlag,nComponents);
    if(initialType!="b"){
        if(initialType=="o"){
            vtvalues <- C[n.coef+(1:(orders %*% lags))];
            n.coef <- n.coef + orders %*% lags;

            for(i in 1:nComponents){
                vt[(maxlag - modellags + 1)[i]:maxlag,i] <- vtvalues[((cumsum(c(0,modellags))[i]+1):cumsum(c(0,modellags))[i+1])];
                vt[is.na(vt[1:maxlag,i]),i] <- rep(rev(vt[(maxlag - modellags + 1)[i]:maxlag,i]),
                                                   ceiling((maxlag - modellags + 1) / modellags)[i])[is.na(vt[1:maxlag,i])];
            }
        }
        else if(initialType=="p"){
            vt[,] <- initialValue;
        }
    }
    else{
        vt[,] <- matvt[1:maxlag,nComponents];
    }

# If exogenous are included
    if(xregEstimate){
        at <- matrix(NA,maxlag,nExovars);
        if(initialXEstimate){
            at[,] <- rep(C[n.coef+(1:nExovars)],each=maxlag);
            n.coef <- n.coef + nExovars;
        }
        else{
            at <- matat[1:maxlag,];
        }
        if(FXEstimate){
            matFX <- matrix(C[n.coef+(1:(nExovars^2))],nExovars,nExovars);
            n.coef <- n.coef + nExovars^2;
        }

        if(gXEstimate){
            vecgX <- matrix(C[n.coef+(1:nExovars)],nExovars,1);
            n.coef <- n.coef + nExovars;
        }
    }
    else{
        at <- matrix(matat[1:maxlag,],maxlag,nExovars);
    }

    return(list(matw=matw,matF=matF,vecg=vecg,vt=vt,at=at,matFX=matFX,vecgX=vecgX));
}

##### Cost Function for GES #####
CF <- function(C){
    elements <- ElementsGES(C);
    matw <- elements$matw;
    matF <- elements$matF;
    vecg <- elements$vecg;
    matvt[1:maxlag,] <- elements$vt;
    matat[1:maxlag,] <- elements$at;
    matFX <- elements$matFX;
    vecgX <- elements$vecgX;

    cfRes <- costfunc(matvt, matF, matw, y, vecg,
                       h, modellags, Etype, Ttype, Stype,
                       multisteps, cfType, normalizer, initialType,
                       matxt, matat, matFX, vecgX, ot,
                       bounds);

    if(is.nan(cfRes) | is.na(cfRes)){
        cfRes <- 1e100;
    }
    return(cfRes);
}

##### Estimate ges or just use the provided values #####
CreatorGES <- function(silentText=FALSE,...){
    environment(likelihoodFunction) <- environment();
    environment(ICFunction) <- environment();

# 1 stands for the variance
    nParam <- 2*nComponents + nComponents^2 + orders %*% lags * (initialType!="b") + (!is.null(xreg)) * nExovars + (updateX)*(nExovars^2 + nExovars) + 1;

# If there is something to optimise, let's do it.
    if(any((initialType=="o"),(measurementEstimate),(transitionEstimate),(persistenceEstimate),
       (xregEstimate),(FXEstimate),(gXEstimate))){

        C <- NULL;
# matw, matF, vecg, vt
        if(measurementEstimate){
            C <- c(C,rep(1,nComponents));
        }
        if(transitionEstimate){
            #C <- c(C,as.vector(test$transition));
            #C <- c(C,rep(1,nComponents^2 - length(test$transition)))
            C <- c(C,rep(1,nComponents^2));
            #C <- c(C,c(diag(1,nComponents)));
        }
        if(persistenceEstimate){
            C <- c(C,rep(0.1,nComponents));
        }
        if(initialType=="o"){
            C <- c(C,intercept);
            if((orders %*% lags)>1){
                C <- c(C,slope);
            }
            if((orders %*% lags)>2){
                C <- c(C,yot[1:(orders %*% lags-2),]);
            }
        }

# initials, transition matrix and persistence vector
        if(xregEstimate){
            if(initialXEstimate){
                C <- c(C,matat[maxlag,]);
            }
            if(updateX){
                if(FXEstimate){
                    C <- c(C,c(diag(nExovars)));
                }
                if(gXEstimate){
                    C <- c(C,rep(0,nExovars));
                }
            }
        }

# Optimise model. First run
        res <- nloptr(C, CF, opts=list("algorithm"="NLOPT_LN_BOBYQA", "xtol_rel"=1e-8, "maxeval"=5000));
        C <- res$solution;

# Optimise model. Second run
        res2 <- nloptr(C, CF, opts=list("algorithm"="NLOPT_LN_NELDERMEAD", "xtol_rel"=1e-10, "maxeval"=1000));
        # This condition is needed in order to make sure that we did not make the solution worse
        if(res2$objective <= res$objective){
            res <- res2;
        }

        C <- res$solution;
        cfObjective <- res$objective;
    }
    else{
# matw, matF, vecg, vt
        C <- c(measurement,
               c(transition),
               c(persistence),
               c(initialValue));

        C <- c(C,matat[maxlag,],
               c(transitionX),
               c(persistenceX));

        cfObjective <- CF(C);
    }

# Change cfType for model selection
    if(multisteps){
        cfType <- "aTFL";
    }
    else{
        cfType <- "MSE";
    }

    ICValues <- ICFunction(nParam=nParam+nParamIntermittent,C=C,Etype=Etype);
    ICs <- ICValues$ICs;
    logLik <- ICValues$llikelihood;

    icBest <- ICs[ic];

# Revert to the provided cost function
    cfType <- cfTypeOriginal

    return(list(cfObjective=cfObjective,C=C,ICs=ICs,icBest=icBest,nParam=nParam,logLik=logLik));
}

##### Preset y.fit, y.for, errors and basic parameters #####
    matvt <- matrix(NA,nrow=obsStates,ncol=nComponents);
    y.fit <- rep(NA,obsInsample);
    y.for <- rep(NA,h);
    errors <- rep(NA,obsInsample);

##### Prepare exogenous variables #####
    xregdata <- ssXreg(data=data, xreg=xreg, updateX=updateX,
                       persistenceX=persistenceX, transitionX=transitionX, initialX=initialX,
                       obsInsample=obsInsample, obsAll=obsAll, obsStates=obsStates, maxlag=maxlag, h=h, silent=silentText);

    if(xregDo=="u"){
        nExovars <- xregdata$nExovars;
        matxt <- xregdata$matxt;
        matat <- xregdata$matat;
        xregEstimate <- xregdata$xregEstimate;
        matFX <- xregdata$matFX;
        vecgX <- xregdata$vecgX;
        xregNames <- colnames(matxt);
    }
    else{
        nExovars <- 1;
        nExovarsOriginal <- xregdata$nExovars;
        matxtOriginal <- xregdata$matxt;
        matatOriginal <- xregdata$matat;
        xregEstimateOriginal <- xregdata$xregEstimate;
        matFXOriginal <- xregdata$matFX;
        vecgXOriginal <- xregdata$vecgX;

        matxt <- matrix(1,nrow(matxtOriginal),1);
        matat <- matrix(0,nrow(matatOriginal),1);
        xregEstimate <- FALSE;
        matFX <- matrix(1,1,1);
        vecgX <- matrix(0,1,1);
        xregNames <- NULL;
    }
    xreg <- xregdata$xreg;
    FXEstimate <- xregdata$FXEstimate;
    gXEstimate <- xregdata$gXEstimate;
    initialXEstimate <- xregdata$initialXEstimate;

    # These three are needed in order to use ssgeneralfun.cpp functions
    Etype <- "A";
    Ttype <- "N";
    Stype <- "N";

# Check number of parameters vs data
    nParamExo <- FXEstimate*length(matFX) + gXEstimate*nrow(vecgX) + initialXEstimate*ncol(matat);
    nParamMax <- nParamMax + nParamExo + (intermittent!="n");

##### Check number of observations vs number of max parameters #####
    if(obsNonzero <= nParamMax){
        if(!silentText){
            message(paste0("Number of non-zero observations is ",obsNonzero,
                           ", while the number of parameters to estimate is ", nParamMax,"."));
        }
        stop("Not enough observations. Can't fit the model you ask.",call.=FALSE);
    }

##### Preset values of matvt ######
    slope <- cov(yot[1:min(12,obsNonzero),],c(1:min(12,obsNonzero)))/var(c(1:min(12,obsNonzero)));
    intercept <- sum(yot[1:min(12,obsNonzero),])/min(12,obsNonzero) - slope * (sum(c(1:min(12,obsNonzero)))/min(12,obsNonzero) - 1);

    vtvalues <- intercept;
    if((orders %*% lags)>1){
        vtvalues <- c(vtvalues,slope);
    }
    if((orders %*% lags)>2){
        vtvalues <- c(vtvalues,yot[1:(orders %*% lags-2),]);
    }

    vt <- matrix(NA,maxlag,nComponents);
    for(i in 1:nComponents){
        vt[(maxlag - modellags + 1)[i]:maxlag,i] <- vtvalues[((cumsum(c(0,modellags))[i]+1):cumsum(c(0,modellags))[i+1])];
        vt[is.na(vt[1:maxlag,i]),i] <- rep(rev(vt[(maxlag - modellags + 1)[i]:maxlag,i]),
                                           ceiling((maxlag - modellags + 1) / modellags)[i])[is.na(vt[1:maxlag,i])];
    }
    matvt[1:maxlag,] <- vt;

##### Start the calculations #####
    environment(intermittentParametersSetter) <- environment();
    environment(intermittentMaker) <- environment();
    environment(ssForecaster) <- environment();
    environment(ssFitter) <- environment();

    # If auto intermittent, then estimate model with intermittent="n" first.
    if(any(intermittent==c("a","n"))){
        intermittentParametersSetter(intermittent="n",ParentEnvironment=environment());
    }
    else{
        intermittentParametersSetter(intermittent=intermittent,ParentEnvironment=environment());
        intermittentMaker(intermittent=intermittent,ParentEnvironment=environment());
    }

    gesValues <- CreatorGES(silentText=silentText);

##### If intermittent=="a", run a loop and select the best one #####
    if(intermittent=="a"){
        if(cfType!="MSE"){
            warning(paste0("'",cfType,"' is used as cost function instead of 'MSE'. A wrong intermittent model may be selected"),call.=FALSE);
        }
        if(!silentText){
            cat("Selecting appropriate type of intermittency... ");
        }
# Prepare stuff for intermittency selection
        intermittentModelsPool <- c("n","f","c","t","s");
        intermittentICs <- rep(1e+10,length(intermittentModelsPool));
        intermittentModelsList <- list(NA);
        intermittentICs <- gesValues$icBest;

        for(i in 2:length(intermittentModelsPool)){
            intermittentParametersSetter(intermittent=intermittentModelsPool[i],ParentEnvironment=environment());
            intermittentMaker(intermittent=intermittentModelsPool[i],ParentEnvironment=environment());
            intermittentModelsList[[i]] <- CreatorGES(silentText=TRUE);
            intermittentICs[i] <- intermittentModelsList[[i]]$icBest;
            if(intermittentICs[i]>intermittentICs[i-1]){
                break;
            }
        }
        intermittentICs[is.nan(intermittentICs)] <- 1e+100;
        intermittentICs[is.na(intermittentICs)] <- 1e+100;
        iBest <- which(intermittentICs==min(intermittentICs));

        if(!silentText){
            cat("Done!\n");
        }
        if(iBest!=1){
            intermittent <- intermittentModelsPool[iBest];
            intermittentModel <- intermittentModelsList[[iBest]];
            gesValues <- intermittentModelsList[[iBest]];
        }
        else{
            intermittent <- "n"
        }

        intermittentParametersSetter(intermittent=intermittent,ParentEnvironment=environment());
        intermittentMaker(intermittent=intermittent,ParentEnvironment=environment());
    }

    list2env(gesValues,environment());

    if(xregDo!="u"){
# Prepare for fitting
        elements <- ElementsGES(C);
        matw <- elements$matw;
        matF <- elements$matF;
        vecg <- elements$vecg;
        matvt[1:maxlag,] <- elements$vt;
        matat[1:maxlag,] <- elements$at;
        matFX <- elements$matFX;
        vecgX <- elements$vecgX;

        ssFitter(ParentEnvironment=environment());

        xregNames <- colnames(matxtOriginal);
        xregNew <- cbind(errors,xreg[1:nrow(errors),]);
        colnames(xregNew)[1] <- "errors";
        colnames(xregNew)[-1] <- xregNames;
        xregNew <- as.data.frame(xregNew);
        xregResults <- stepwise(xregNew, ic=ic, silent=TRUE, df=nParam+nParamIntermittent-1);
        xregNames <- names(coef(xregResults))[-1];
        nExovars <- length(xregNames);
        if(nExovars>0){
            xregEstimate <- TRUE;
            matxt <- as.data.frame(matxtOriginal)[,xregNames];
            matat <- as.data.frame(matatOriginal)[,xregNames];
            matFX <- diag(nExovars);
            vecgX <- matrix(0,nExovars,1);

            if(nExovars==1){
                matxt <- matrix(matxt,ncol=1);
                matat <- matrix(matat,ncol=1);
                colnames(matxt) <- colnames(matat) <- xregNames;
            }
            else{
                matxt <- as.matrix(matxt);
                matat <- as.matrix(matat);
            }
        }
        else{
            nExovars <- 1;
            xreg <- NULL;
        }

        if(!is.null(xreg)){
            gesValues <- CreatorGES(silentText=TRUE);
            list2env(gesValues,environment());
        }
    }

    if(!is.null(xreg)){
        if(ncol(matat)==1){
            colnames(matxt) <- colnames(matat) <- xregNames;
        }
        xreg <- matxt;
    }
# Prepare for fitting
    elements <- ElementsGES(C);
    matw <- elements$matw;
    matF <- elements$matF;
    vecg <- elements$vecg;
    matvt[1:maxlag,] <- elements$vt;
    matat[1:maxlag,] <- elements$at;
    matFX <- elements$matFX;
    vecgX <- elements$vecgX;

    # Write down Fisher Information if needed
    if(FI){
        environment(likelihoodFunction) <- environment();
        FI <- numDeriv::hessian(likelihoodFunction,C);
    }

##### Fit simple model and produce forecast #####
    ssFitter(ParentEnvironment=environment());
    ssForecaster(ParentEnvironment=environment());

##### Do final check and make some preparations for output #####

# Write down initials of states vector and exogenous
    if(initialType!="p"){
        initialValue <- matvt[1:maxlag,];
    }
    if(initialXEstimate){
        initialX <- matat[1,];
    }

    # Write down the probabilities from intermittent models
    pt <- ts(c(as.vector(pt),as.vector(pt.for)),start=start(data),frequency=datafreq);
    if(intermittent=="f"){
        intermittent <- "fixed";
    }
    else if(intermittent=="c"){
        intermittent <- "croston";
    }
    else if(intermittent=="t"){
        intermittent <- "tsb";
    }
    else if(intermittent=="n"){
        intermittent <- "none";
    }
    else if(intermittent=="p"){
        intermittent <- "provided";
    }

# Make some preparations
    matvt <- ts(matvt,start=(time(data)[1] - deltat(data)*maxlag),frequency=frequency(data));
    if(!is.null(xreg)){
        matvt <- cbind(matvt,matat);
        colnames(matvt) <- c(paste0("Component ",c(1:nComponents)),colnames(matat));
        if(updateX){
            rownames(vecgX) <- xregNames;
            dimnames(matFX) <- list(xregNames,xregNames);
        }
    }
    else{
        colnames(matvt) <- paste0("Component ",c(1:nComponents));
    }

    if(holdout==T){
        y.holdout <- ts(data[(obsInsample+1):obsAll],start=start(y.for),frequency=frequency(data));
        errormeasures <- errorMeasurer(y.holdout,y.for,y);
    }
    else{
        y.holdout <- NA;
        errormeasures <- NA;
    }

    if(!is.null(xreg)){
        modelname <- "GESX";
    }
    else{
        modelname <- "GES";
    }
    modelname <- paste0(modelname,"(",paste(orders,"[",lags,"]",collapse=",",sep=""),")");
    if(all(intermittent!=c("n","none"))){
        modelname <- paste0("i",modelname);
    }

##### Print output #####
    if(!silentText){
        if(any(abs(eigen(matF - vecg %*% matw)$values)>(1 + 1E-10))){
            if(bounds!="a"){
                warning("Unstable model was estimated! Use bounds='admissible' to address this issue!",
                        call.=FALSE);
            }
            else{
                warning("Something went wrong in optimiser - unstable model was estimated! Please report this error to the maintainer.",
                        call.=FALSE);
            }
        }
    }

##### Make a plot #####
    if(!silentGraph){
        if(intervals){
            graphmaker(actuals=data,forecast=y.for,fitted=y.fit, lower=y.low,upper=y.high,
                       level=level,legend=!silentLegend,main=modelname);
        }
        else{
            graphmaker(actuals=data,forecast=y.for,fitted=y.fit,
                    level=level,legend=!silentLegend,main=modelname);
        }
    }
##### Return values #####
    model <- list(model=modelname,timeElapsed=Sys.time()-startTime,
                  states=matvt,measurement=matw,transition=matF,persistence=vecg,
                  initialType=initialType,initial=initialValue,
                  nParam=nParam,
                  fitted=y.fit,forecast=y.for,lower=y.low,upper=y.high,residuals=errors,
                  errors=errors.mat,s2=s2,intervals=intervalsType,level=level,
                  actuals=data,holdout=y.holdout,iprob=pt,intermittent=intermittent,
                  xreg=xreg,updateX=updateX,initialX=initialX,persistenceX=vecgX,transitionX=matFX,
                  ICs=ICs,logLik=logLik,cf=cfObjective,cfType=cfType,FI=FI,accuracy=errormeasures);
    return(structure(model,class="smooth"));
}

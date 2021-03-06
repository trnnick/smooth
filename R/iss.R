utils::globalVariables(c("y","obs"))

intermittentParametersSetter <- function(intermittent="n",...){
# Function returns basic parameters based on intermittent type
    ellipsis <- list(...);
    ParentEnvironment <- ellipsis[['ParentEnvironment']];

    if(all(intermittent!=c("n","p"))){
        ot <- (y!=0)*1;
        obsNonzero <- sum(ot);
        # 1 parameter for estimating initial probability
        nParamIntermittent <- 1;
#         if(intermittent=="c"){
#             # In Croston we also need to estimate smoothing parameter and variance
#            nParamIntermittent <- nParamIntermittent + 2;
#         }
#         else if(any(intermittent==c("t","a"))){
#             # In TSB we also need to estimate smoothing parameter and two parameters of distribution...
#            nParamIntermittent <- nParamIntermittent + 3;
#         }
        yot <- matrix(y[y!=0],obsNonzero,1);
        pt <- matrix(mean(ot),obsInsample,1);
        pt.for <- matrix(1,h,1);
    }
    else{
        obsNonzero <- obsInsample;
    }

# If number of observations is low, set intermittency to "none"
    if(obsNonzero < 5){
        warning(paste0("Not enough non-zero observations for intermittent state-space model. We need at least 5.\n",
                       "Changing intermittent to 'n'."),call.=FALSE);
        intermittent <- "n";
    }

    if(intermittent=="n"){
        ot <- rep(1,obsInsample);
        obsNonzero <- obsInsample;
        yot <- y;
        pt <- matrix(1,obsInsample,1);
        pt.for <- matrix(1,h,1);
        nParamIntermittent <- 0;
    }
    iprob <- pt[1];
    ivar <- iprob * (1-iprob);

    assign("ot",ot,ParentEnvironment);
    assign("obsNonzero",obsNonzero,ParentEnvironment);
    assign("yot",yot,ParentEnvironment);
    assign("pt",pt,ParentEnvironment);
    assign("pt.for",pt.for,ParentEnvironment);
    assign("nParamIntermittent",nParamIntermittent,ParentEnvironment);
    assign("iprob",iprob,ParentEnvironment);
    assign("ivar",ivar,ParentEnvironment);
}

intermittentMaker <- function(intermittent="n",...){
# Function returns all the necessary stuff from intermittent models
    ellipsis <- list(...);
    ParentEnvironment <- ellipsis[['ParentEnvironment']];

##### If intermittent is not auto, then work normally #####
    if(all(intermittent!=c("n","p","a"))){
        intermittent_model <- iss(y,intermittent=intermittent,h=h);
        pt[,] <- intermittent_model$fitted;
        pt.for <- intermittent_model$forecast;
        iprob <- pt.for[1];
        ivar <- intermittent_model$variance;
    }
    else{
        ivar <- 1;
    }

    assign("pt",pt,ParentEnvironment);
    assign("pt.for",pt.for,ParentEnvironment);
    assign("iprob",iprob,ParentEnvironment);
    assign("ivar",ivar,ParentEnvironment);
}



#' Intermittent State Space
#'
#' Functin calculates the probability for intermittent state space model. This
#' is needed in order to forecast intermittent demand using other functions.
#'
#' The function estimates probability of demand occurance, using one of the ETS
#' state-space models.
#'
#' @param data Either numeric vector or time series vector.
#' @param intermittent Type of method used in probability estimation. Can be
#' \code{"none"} - none, \code{"fixed"} - constant probability,
#' \code{"croston"} - estimated using Croston, 1972 method and \code{"TSB"} -
#' Teunter et al., 2011 method., \code{"sba"} - Syntetos-Boylan Approximation
#' for Croston's method (bias correction) discussed in Syntetos and Boylan,
#' 2005.
#' @param h Forecast horizon.
#' @param holdout If \code{TRUE}, holdout sample of size \code{h} is taken from
#' the end of the data.
#' @param model Type of ETS model used for the estimation. Normally this should
#' be either \code{"ANN"} or \code{"MNN"}.
#' @param persistence Persistence vector. If \code{NULL}, then it is estimated.
#' @return The object of class "iss" is returned. It contains following list of
#' values:
#'
#' \itemize{
#' \item \code{fitted} - fitted values of the constructed model;
#' \item \code{states} - values of states (currently level only);
#' \item \code{forecast} - forecast for \code{h} observations ahead;
#' \item \code{variance} - conditional variance of the forecast;
#' \item \code{logLik} - likelihood value for the model
#' \item \code{nParam} - number of parameters used in the model;
#' \item \code{residuals} - residuals of the model;
#' \item \code{C} - vector of all the parameters.
#' \item \code{actuals} - actual values of probabilities (zeroes and ones).
#' }
#' @author Ivan Svetunkov
#' @seealso \code{\link[forecast]{ets}, \link[forecast]{forecast},
#' \link[smooth]{es}}
#' @references \itemize{
#' \item Teunter R., Syntetos A., Babai Z. (2011). Intermittent demand: Linking
#' forecasting to inventory obsolescence. European Journal of Operational
#' Research, 214, 606-615.
#' \item Croston, J. (1972) Forecasting and stock control for intermittent
#' demands. Operational Research Quarterly, 23(3), 289-303.
#' \item Syntetos, A., Boylan J. (2005) The accuracy of intermittent demand
#' estimates. International Journal of Forecasting, 21(2), 303-314.
#' }
#' @keywords iss intermittent demand intermittent demand state space model
#' exponential smoothing forecasting
#' @examples
#'
#'     y <- rpois(100,0.1)
#'     iss(y, intermittent="t")
#'
#'     iss(y, intermittent="c", persistence=0.1)
#'
#' @export iss
iss <- function(data, intermittent=c("none","fixed","croston","tsb","sba"),
                h=10, holdout=FALSE, model=NULL, persistence=NULL){
# Function estimates and returns mean and variance of probability for intermittent State-Space model based on the chosen method
    intermittent <- substring(intermittent[1],1,1);
    if(all(intermittent!=c("n","f","c","t","s"))){
        intermittent <- "f";
    }
    if(intermittent=="s"){
        intermittent <- "c";
        sbaCorrection <- TRUE;
    }
    else{
        sbaCorrection <- FALSE;
    }

    obsInsample <- length(data) - holdout*h;
    obsAll <- length(data) + (1 - holdout)*h;
    y <- ts(data[1:obsInsample],frequency=frequency(data),start=start(data));

    ot <- abs((y!=0)*1);
    otAll <- abs((data!=0)*1);
    iprob <- mean(ot);
    obsOnes <- sum(ot);
# Sizes of demand
    yot <- matrix(y[y!=0],obsOnes,1);

    if(!is.null(model)){
        # If chosen model is "AAdN" or anything like that, we are taking the appropriate values
        if(nchar(model)==4){
            Etype <- substring(model,1,1);
            Ttype <- substring(model,2,2);
            Stype <- substring(model,4,4);
            damped <- TRUE;
            if(substring(model,3,3)!="d"){
                message(paste0("You have defined a strange model: ",model));
                sowhat(model);
                model <- paste0(Etype,Ttype,"d",Stype);
            }
        }
        else if(nchar(model)==3){
            Etype <- substring(model,1,1);
            Ttype <- substring(model,2,2);
            Stype <- substring(model,3,3);
            damped <- FALSE;
        }
    }
    else{
        model <- "MNN";
        Etype <- "M";
        Ttype <- "N";
        Stype <- "N";
    }

#### Fixed probability ####
    if(intermittent=="f"){
        pt <- ts(matrix(rep(iprob,obsInsample),obsInsample,1), start=start(y), frequency=frequency(y));
        pt.for <- ts(rep(iprob,h), start=time(y)[obsInsample]+deltat(y), frequency=frequency(y));
        errors <- ts(ot-iprob, start=start(y), frequency=frequency(y));
        logLik <- structure((sum(log(pt[ot==1])) + sum(log((1-pt[ot==0])))),df=1,class="logLik");

        output <- list(fitted=pt,forecast=pt.for,states=pt,variance=pt.for*(1-pt.for),
                      logLik=logLik,nParam=1,residuals=errors,C=c(0,iprob),actuals=otAll)
    }
#### Croston's method ####
    else if(intermittent=="c"){
# Define the matrix of states
        ivt <- matrix(rep(iprob,obsInsample+1),obsInsample+1,1);
# Define the matrix of actuals as intervals between demands
        # zeroes <- c(0,which(y!=0),obsInsample+1);
        zeroes <- c(0,which(y!=0));
### With this thing we fit model of the type 1/(1+qt)
#        zeroes <- diff(zeroes)-1;
        zeroes <- diff(zeroes);
# Number of intervals in Croston
        iyt <- matrix(zeroes,length(zeroes),1);
        newh <- which(y!=0)
        newh <- newh[length(newh)];
        newh <- obsInsample - newh + h
        crostonModel <- es(iyt,model=model,silent=TRUE,h=newh,persistence=persistence);

        zeroes[length(zeroes)] <- zeroes[length(zeroes)];
        pt <- rep((crostonModel$fitted),zeroes);
        tailNumber <- obsInsample - length(pt);
        if(tailNumber>0){
            pt <- c(pt,crostonModel$forecast[1:tailNumber]);
        }
        pt.for <- crostonModel$forecast[(tailNumber+1):newh];

        if(sbaCorrection){
            pt <- ts((1-sum(crostonModel$persistence)/2)/pt,start=start(y),frequency=frequency(y));
            pt.for <- ts((1-sum(crostonModel$persistence)/2)/pt.for, start=time(y)[obsInsample]+deltat(y),frequency=frequency(y));
            states <- 1/crostonModel$states;
        }
        else{
            pt <- ts(1/pt,start=start(y),frequency=frequency(y));
            pt.for <- ts(1/pt.for, start=time(y)[obsInsample]+deltat(y),frequency=frequency(y));
            states <- 1/crostonModel$states;
        }

        logLik <- logLik(crostonModel);
        C <- c(crostonModel$persistence,crostonModel$states[1,]);
        names(C) <- c(paste0("persistence ",c(1:length(crostonModel$persistence))),
                      paste0("state ",c(1:length(crostonModel$states[1,]))))

        output <- list(fitted=pt,forecast=pt.for,states=states,variance=pt.for*(1-pt.for),
                      logLik=logLik,nParam=crostonModel$nParam,residuals=crostonModel$residuals,C=C,actuals=otAll);
    }
#### TSB method ####
    else if(intermittent=="t"){
        ivt <- matrix(rep(iprob,obsInsample+1),obsInsample+1,1);
        iyt <- matrix(ot,obsInsample,1);
        modellags <- matw <- matF <- matrix(1,1,1);

        if(!is.null(model)){
            if(model!="MNN"){
                warning("Sorry, but currently TSB can only use ETS(M,N,N) model.", call.=FALSE);
                model <- "MNN";
                Etype <- "M";
                Ttype <- "N";
                Stype <- "N";
            }
        }

        if(!is.null(persistence)){
            if(length(persistence)!=1){
                warning("Only one smoothing parameter is currently supported for TSB. Using the first value.", call.=FALSE);
                persistence <- persistence[1];
            }
            persistenceEstimate <- FALSE;
            vecg <- matrix(persistence,1,1);
            C <- c(ivt[1]);
            CLower <- c(0);
            CUpper <- c(1);
        }
        else{
            persistenceEstimate <- TRUE;
            vecg <- matrix(0.1,1,1);
            C <- c(ivt[1],vecg[1]);
            CLower <- c(0,0);
            CUpper <- c(1,1);
        }

        errors <- matrix(NA,obsInsample,1);
        iyt.fit <- matrix(NA,obsInsample,1);

#### CF for initial and persistence ####
        CF <- function(C){
            ivt[1,] <- C[1];
            if(persistenceEstimate){
                vecg[,] <- C[2];
            }

            fitting <- fitterwrap(ivt, matF, matw, iy_kappa, vecg,
                                  modellags, Etype, Ttype, Stype, "o",
                                  matrix(0,obsInsample,1), matrix(0,obsInsample+1,1),
                                  matrix(1,1,1), matrix(1,1,1), matrix(1,obsInsample,1));

            iyt.fit <- fitting$yfit;

            CF.res <- -(sum(log(iyt.fit[ot==1])) + sum(log((1-iyt.fit[ot==0]))));
            return(CF.res);
        }

        kappa <- 1E-5;
        iy_kappa <- iyt*(1 - 2*kappa) + kappa;

        # Another run, now to define persistence and initial
        res <- nloptr(C, CF, lb=CLower, ub=CUpper,
                      opts=list("algorithm"="NLOPT_LN_BOBYQA", "xtol_rel"=1e-6, "maxeval"=100));

        ivt[1,] <- res$solution[1];
        if(persistenceEstimate){
            vecg[,] <- res$solution[2];
            C <- c(rev(res$solution));
        }
        else{
            C <- c(persistence,res$solution);
        }

        names(C) <- c("persistence","initial");
        logLik <- structure(-res$objective,df=3,class="logLik");

        iy_kappa <- iyt*(1 - 2*kappa) + kappa;
        fitting <- fitterwrap(ivt, matF, matw, iy_kappa, vecg,
                              modellags, Etype, Ttype, Stype, "o",
                              matrix(0,obsInsample,1), matrix(0,obsInsample+1,1),
                              matrix(1,1,1), matrix(1,1,1), matrix(1,obsInsample,1));

        ivt <- ts(fitting$matvt,start=(time(y)[1] - deltat(y)),frequency=frequency(y));
        iyt.fit <- ts(fitting$yfit,start=start(y),frequency=frequency(y));
        errors <- ts(fitting$errors,start=start(y),frequency=frequency(y));
        iyt.for <- ts(rep(iyt.fit[obsInsample],h),
                     start=time(y)[obsInsample]+deltat(y),frequency=frequency(y));

        # Correction so we can return from those iy_kappa values
        iyt.fit <- (iyt.fit - kappa) / (1 - 2*kappa);
        iyt.for <- (iyt.for - kappa) / (1 - 2*kappa);

        output <- list(fitted=iyt.fit,states=ivt,forecast=iyt.for,variance=iyt.for*(1-iyt.for),
                      logLik=logLik,nParam=3,residuals=errors,C=C,actuals=otAll);
    }
#### None ####
    else{
        pt <- ts(rep(1,obsAll),start=start(y),frequency=frequency(y));
        pt.for <- ts(rep(1,h), start=time(y)[obsInsample]+deltat(y),frequency=frequency(y));
        errors <- ts(rep(0,obsInsample), start=start(y), frequency=frequency(y));
        output <- list(fitted=pt,states=pt,forecast=pt.for,variance=rep(0,h),
                      logLik=NA,nParam=0,residuals=errors,C=c(0,1),actuals=pt);
    }
    output$intermittent <- intermittent;
    return(structure(output,class="iss"));
}

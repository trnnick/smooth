// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// matrixPowerWrap
RcppExport SEXP matrixPowerWrap(SEXP matA, SEXP power);
RcppExport SEXP smooth_matrixPowerWrap(SEXP matASEXP, SEXP powerSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type matA(matASEXP);
    Rcpp::traits::input_parameter< SEXP >::type power(powerSEXP);
    rcpp_result_gen = Rcpp::wrap(matrixPowerWrap(matA, power));
    return rcpp_result_gen;
END_RCPP
}
// initparams
RcppExport SEXP initparams(SEXP Ttype, SEXP Stype, SEXP datafreq, SEXP obsR, SEXP obsallR, SEXP yt, SEXP damped, SEXP phi, SEXP smoothingparameters, SEXP initialstates, SEXP seasonalcoefs);
RcppExport SEXP smooth_initparams(SEXP TtypeSEXP, SEXP StypeSEXP, SEXP datafreqSEXP, SEXP obsRSEXP, SEXP obsallRSEXP, SEXP ytSEXP, SEXP dampedSEXP, SEXP phiSEXP, SEXP smoothingparametersSEXP, SEXP initialstatesSEXP, SEXP seasonalcoefsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type Ttype(TtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Stype(StypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type datafreq(datafreqSEXP);
    Rcpp::traits::input_parameter< SEXP >::type obsR(obsRSEXP);
    Rcpp::traits::input_parameter< SEXP >::type obsallR(obsallRSEXP);
    Rcpp::traits::input_parameter< SEXP >::type yt(ytSEXP);
    Rcpp::traits::input_parameter< SEXP >::type damped(dampedSEXP);
    Rcpp::traits::input_parameter< SEXP >::type phi(phiSEXP);
    Rcpp::traits::input_parameter< SEXP >::type smoothingparameters(smoothingparametersSEXP);
    Rcpp::traits::input_parameter< SEXP >::type initialstates(initialstatesSEXP);
    Rcpp::traits::input_parameter< SEXP >::type seasonalcoefs(seasonalcoefsSEXP);
    rcpp_result_gen = Rcpp::wrap(initparams(Ttype, Stype, datafreq, obsR, obsallR, yt, damped, phi, smoothingparameters, initialstates, seasonalcoefs));
    return rcpp_result_gen;
END_RCPP
}
// etsmatrices
RcppExport SEXP etsmatrices(SEXP matvt, SEXP vecg, SEXP phi, SEXP Cvalues, SEXP ncomponentsR, SEXP modellags, SEXP fittertype, SEXP Ttype, SEXP Stype, SEXP nexovars, SEXP matat, SEXP estimpersistence, SEXP estimphi, SEXP estiminit, SEXP estiminitseason, SEXP estimxreg, SEXP matFX, SEXP vecgX, SEXP gowild, SEXP estimFX, SEXP estimgX, SEXP estiminitX);
RcppExport SEXP smooth_etsmatrices(SEXP matvtSEXP, SEXP vecgSEXP, SEXP phiSEXP, SEXP CvaluesSEXP, SEXP ncomponentsRSEXP, SEXP modellagsSEXP, SEXP fittertypeSEXP, SEXP TtypeSEXP, SEXP StypeSEXP, SEXP nexovarsSEXP, SEXP matatSEXP, SEXP estimpersistenceSEXP, SEXP estimphiSEXP, SEXP estiminitSEXP, SEXP estiminitseasonSEXP, SEXP estimxregSEXP, SEXP matFXSEXP, SEXP vecgXSEXP, SEXP gowildSEXP, SEXP estimFXSEXP, SEXP estimgXSEXP, SEXP estiminitXSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type matvt(matvtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecg(vecgSEXP);
    Rcpp::traits::input_parameter< SEXP >::type phi(phiSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Cvalues(CvaluesSEXP);
    Rcpp::traits::input_parameter< SEXP >::type ncomponentsR(ncomponentsRSEXP);
    Rcpp::traits::input_parameter< SEXP >::type modellags(modellagsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type fittertype(fittertypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Ttype(TtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Stype(StypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type nexovars(nexovarsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matat(matatSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimpersistence(estimpersistenceSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimphi(estimphiSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estiminit(estiminitSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estiminitseason(estiminitseasonSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimxreg(estimxregSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matFX(matFXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecgX(vecgXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type gowild(gowildSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimFX(estimFXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimgX(estimgXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estiminitX(estiminitXSEXP);
    rcpp_result_gen = Rcpp::wrap(etsmatrices(matvt, vecg, phi, Cvalues, ncomponentsR, modellags, fittertype, Ttype, Stype, nexovars, matat, estimpersistence, estimphi, estiminit, estiminitseason, estimxreg, matFX, vecgX, gowild, estimFX, estimgX, estiminitX));
    return rcpp_result_gen;
END_RCPP
}
// polysoswrap
RcppExport SEXP polysoswrap(SEXP ARorders, SEXP MAorders, SEXP Iorders, SEXP ARIMAlags, SEXP nComp, SEXP AR, SEXP MA, SEXP constant, SEXP Cvalues, SEXP matvt, SEXP vecg, SEXP matF, SEXP fittertype, SEXP nexovars, SEXP matat, SEXP matFX, SEXP vecgX, SEXP estimAR, SEXP estimMA, SEXP requireConst, SEXP estimConst, SEXP estimxreg, SEXP gowild, SEXP estimFX, SEXP estimgX, SEXP estiminitX);
RcppExport SEXP smooth_polysoswrap(SEXP ARordersSEXP, SEXP MAordersSEXP, SEXP IordersSEXP, SEXP ARIMAlagsSEXP, SEXP nCompSEXP, SEXP ARSEXP, SEXP MASEXP, SEXP constantSEXP, SEXP CvaluesSEXP, SEXP matvtSEXP, SEXP vecgSEXP, SEXP matFSEXP, SEXP fittertypeSEXP, SEXP nexovarsSEXP, SEXP matatSEXP, SEXP matFXSEXP, SEXP vecgXSEXP, SEXP estimARSEXP, SEXP estimMASEXP, SEXP requireConstSEXP, SEXP estimConstSEXP, SEXP estimxregSEXP, SEXP gowildSEXP, SEXP estimFXSEXP, SEXP estimgXSEXP, SEXP estiminitXSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type ARorders(ARordersSEXP);
    Rcpp::traits::input_parameter< SEXP >::type MAorders(MAordersSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Iorders(IordersSEXP);
    Rcpp::traits::input_parameter< SEXP >::type ARIMAlags(ARIMAlagsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type nComp(nCompSEXP);
    Rcpp::traits::input_parameter< SEXP >::type AR(ARSEXP);
    Rcpp::traits::input_parameter< SEXP >::type MA(MASEXP);
    Rcpp::traits::input_parameter< SEXP >::type constant(constantSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Cvalues(CvaluesSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matvt(matvtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecg(vecgSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matF(matFSEXP);
    Rcpp::traits::input_parameter< SEXP >::type fittertype(fittertypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type nexovars(nexovarsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matat(matatSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matFX(matFXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecgX(vecgXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimAR(estimARSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimMA(estimMASEXP);
    Rcpp::traits::input_parameter< SEXP >::type requireConst(requireConstSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimConst(estimConstSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimxreg(estimxregSEXP);
    Rcpp::traits::input_parameter< SEXP >::type gowild(gowildSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimFX(estimFXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estimgX(estimgXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type estiminitX(estiminitXSEXP);
    rcpp_result_gen = Rcpp::wrap(polysoswrap(ARorders, MAorders, Iorders, ARIMAlags, nComp, AR, MA, constant, Cvalues, matvt, vecg, matF, fittertype, nexovars, matat, matFX, vecgX, estimAR, estimMA, requireConst, estimConst, estimxreg, gowild, estimFX, estimgX, estiminitX));
    return rcpp_result_gen;
END_RCPP
}
// fitterwrap
RcppExport SEXP fitterwrap(SEXP matvt, SEXP matF, SEXP matw, SEXP yt, SEXP vecg, SEXP modellags, SEXP Etype, SEXP Ttype, SEXP Stype, SEXP fittertype, SEXP matxt, SEXP matat, SEXP matFX, SEXP vecgX, SEXP ot);
RcppExport SEXP smooth_fitterwrap(SEXP matvtSEXP, SEXP matFSEXP, SEXP matwSEXP, SEXP ytSEXP, SEXP vecgSEXP, SEXP modellagsSEXP, SEXP EtypeSEXP, SEXP TtypeSEXP, SEXP StypeSEXP, SEXP fittertypeSEXP, SEXP matxtSEXP, SEXP matatSEXP, SEXP matFXSEXP, SEXP vecgXSEXP, SEXP otSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type matvt(matvtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matF(matFSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matw(matwSEXP);
    Rcpp::traits::input_parameter< SEXP >::type yt(ytSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecg(vecgSEXP);
    Rcpp::traits::input_parameter< SEXP >::type modellags(modellagsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Etype(EtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Ttype(TtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Stype(StypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type fittertype(fittertypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matxt(matxtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matat(matatSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matFX(matFXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecgX(vecgXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type ot(otSEXP);
    rcpp_result_gen = Rcpp::wrap(fitterwrap(matvt, matF, matw, yt, vecg, modellags, Etype, Ttype, Stype, fittertype, matxt, matat, matFX, vecgX, ot));
    return rcpp_result_gen;
END_RCPP
}
// forecasterwrap
RcppExport SEXP forecasterwrap(SEXP matvt, SEXP matF, SEXP matw, SEXP h, SEXP Ttype, SEXP Stype, SEXP modellags, SEXP matxt, SEXP matat, SEXP matFX);
RcppExport SEXP smooth_forecasterwrap(SEXP matvtSEXP, SEXP matFSEXP, SEXP matwSEXP, SEXP hSEXP, SEXP TtypeSEXP, SEXP StypeSEXP, SEXP modellagsSEXP, SEXP matxtSEXP, SEXP matatSEXP, SEXP matFXSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type matvt(matvtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matF(matFSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matw(matwSEXP);
    Rcpp::traits::input_parameter< SEXP >::type h(hSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Ttype(TtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Stype(StypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type modellags(modellagsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matxt(matxtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matat(matatSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matFX(matFXSEXP);
    rcpp_result_gen = Rcpp::wrap(forecasterwrap(matvt, matF, matw, h, Ttype, Stype, modellags, matxt, matat, matFX));
    return rcpp_result_gen;
END_RCPP
}
// errorerwrap
RcppExport SEXP errorerwrap(SEXP matvt, SEXP matF, SEXP matw, SEXP yt, SEXP h, SEXP Etype, SEXP Ttype, SEXP Stype, SEXP modellags, SEXP matxt, SEXP matat, SEXP matFX, SEXP ot);
RcppExport SEXP smooth_errorerwrap(SEXP matvtSEXP, SEXP matFSEXP, SEXP matwSEXP, SEXP ytSEXP, SEXP hSEXP, SEXP EtypeSEXP, SEXP TtypeSEXP, SEXP StypeSEXP, SEXP modellagsSEXP, SEXP matxtSEXP, SEXP matatSEXP, SEXP matFXSEXP, SEXP otSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type matvt(matvtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matF(matFSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matw(matwSEXP);
    Rcpp::traits::input_parameter< SEXP >::type yt(ytSEXP);
    Rcpp::traits::input_parameter< SEXP >::type h(hSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Etype(EtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Ttype(TtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Stype(StypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type modellags(modellagsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matxt(matxtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matat(matatSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matFX(matFXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type ot(otSEXP);
    rcpp_result_gen = Rcpp::wrap(errorerwrap(matvt, matF, matw, yt, h, Etype, Ttype, Stype, modellags, matxt, matat, matFX, ot));
    return rcpp_result_gen;
END_RCPP
}
// optimizerwrap
RcppExport SEXP optimizerwrap(SEXP matvt, SEXP matF, SEXP matw, SEXP yt, SEXP vecg, SEXP h, SEXP modellags, SEXP Etype, SEXP Ttype, SEXP Stype, SEXP multisteps, SEXP CFt, SEXP normalizer, SEXP fittertype, SEXP matxt, SEXP matat, SEXP matFX, SEXP vecgX, SEXP ot);
RcppExport SEXP smooth_optimizerwrap(SEXP matvtSEXP, SEXP matFSEXP, SEXP matwSEXP, SEXP ytSEXP, SEXP vecgSEXP, SEXP hSEXP, SEXP modellagsSEXP, SEXP EtypeSEXP, SEXP TtypeSEXP, SEXP StypeSEXP, SEXP multistepsSEXP, SEXP CFtSEXP, SEXP normalizerSEXP, SEXP fittertypeSEXP, SEXP matxtSEXP, SEXP matatSEXP, SEXP matFXSEXP, SEXP vecgXSEXP, SEXP otSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type matvt(matvtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matF(matFSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matw(matwSEXP);
    Rcpp::traits::input_parameter< SEXP >::type yt(ytSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecg(vecgSEXP);
    Rcpp::traits::input_parameter< SEXP >::type h(hSEXP);
    Rcpp::traits::input_parameter< SEXP >::type modellags(modellagsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Etype(EtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Ttype(TtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Stype(StypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type multisteps(multistepsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type CFt(CFtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type normalizer(normalizerSEXP);
    Rcpp::traits::input_parameter< SEXP >::type fittertype(fittertypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matxt(matxtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matat(matatSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matFX(matFXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecgX(vecgXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type ot(otSEXP);
    rcpp_result_gen = Rcpp::wrap(optimizerwrap(matvt, matF, matw, yt, vecg, h, modellags, Etype, Ttype, Stype, multisteps, CFt, normalizer, fittertype, matxt, matat, matFX, vecgX, ot));
    return rcpp_result_gen;
END_RCPP
}
// costfunc
RcppExport SEXP costfunc(SEXP matvt, SEXP matF, SEXP matw, SEXP yt, SEXP vecg, SEXP h, SEXP modellags, SEXP Etype, SEXP Ttype, SEXP Stype, SEXP multisteps, SEXP CFt, SEXP normalizer, SEXP fittertype, SEXP matxt, SEXP matat, SEXP matFX, SEXP vecgX, SEXP ot, SEXP bounds);
RcppExport SEXP smooth_costfunc(SEXP matvtSEXP, SEXP matFSEXP, SEXP matwSEXP, SEXP ytSEXP, SEXP vecgSEXP, SEXP hSEXP, SEXP modellagsSEXP, SEXP EtypeSEXP, SEXP TtypeSEXP, SEXP StypeSEXP, SEXP multistepsSEXP, SEXP CFtSEXP, SEXP normalizerSEXP, SEXP fittertypeSEXP, SEXP matxtSEXP, SEXP matatSEXP, SEXP matFXSEXP, SEXP vecgXSEXP, SEXP otSEXP, SEXP boundsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type matvt(matvtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matF(matFSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matw(matwSEXP);
    Rcpp::traits::input_parameter< SEXP >::type yt(ytSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecg(vecgSEXP);
    Rcpp::traits::input_parameter< SEXP >::type h(hSEXP);
    Rcpp::traits::input_parameter< SEXP >::type modellags(modellagsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Etype(EtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Ttype(TtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Stype(StypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type multisteps(multistepsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type CFt(CFtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type normalizer(normalizerSEXP);
    Rcpp::traits::input_parameter< SEXP >::type fittertype(fittertypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matxt(matxtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matat(matatSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matFX(matFXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type vecgX(vecgXSEXP);
    Rcpp::traits::input_parameter< SEXP >::type ot(otSEXP);
    Rcpp::traits::input_parameter< SEXP >::type bounds(boundsSEXP);
    rcpp_result_gen = Rcpp::wrap(costfunc(matvt, matF, matw, yt, vecg, h, modellags, Etype, Ttype, Stype, multisteps, CFt, normalizer, fittertype, matxt, matat, matFX, vecgX, ot, bounds));
    return rcpp_result_gen;
END_RCPP
}
// simulatorwrap
RcppExport SEXP simulatorwrap(SEXP arrvt, SEXP materrors, SEXP matot, SEXP matF, SEXP matw, SEXP matg, SEXP Etype, SEXP Ttype, SEXP Stype, SEXP modellags);
RcppExport SEXP smooth_simulatorwrap(SEXP arrvtSEXP, SEXP materrorsSEXP, SEXP matotSEXP, SEXP matFSEXP, SEXP matwSEXP, SEXP matgSEXP, SEXP EtypeSEXP, SEXP TtypeSEXP, SEXP StypeSEXP, SEXP modellagsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type arrvt(arrvtSEXP);
    Rcpp::traits::input_parameter< SEXP >::type materrors(materrorsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matot(matotSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matF(matFSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matw(matwSEXP);
    Rcpp::traits::input_parameter< SEXP >::type matg(matgSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Etype(EtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Ttype(TtypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Stype(StypeSEXP);
    Rcpp::traits::input_parameter< SEXP >::type modellags(modellagsSEXP);
    rcpp_result_gen = Rcpp::wrap(simulatorwrap(arrvt, materrors, matot, matF, matw, matg, Etype, Ttype, Stype, modellags));
    return rcpp_result_gen;
END_RCPP
}

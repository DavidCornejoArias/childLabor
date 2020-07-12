
tabulate firstBorn r403 [fweight = fac00], chi2

tabulate childrenInFamily r403 [fweight = fac00], chi2


drop if change == 0 | missing(change)
label variable r403 "First born working"
global ylist h412a
global y2list ingpe
global xlist aproba1 
global x2list r1119_2


eststo, title("First stage"): quietly regress $y2list $x2list $xlist[fweight = fac00]
predict y2hat, xb
eststo, title("Second stage"): quietly regress $ylist y2hat $xlist[fweight = fac00]
estout, cells("b(star label(Coef.)) se(label(Std. err.))")  ///
stats(r2 N, labels(R-squared "N. of cases"))            ///
label legend varlabels(_cons Constant)


quietly ivregress 2sls $ylist ($y2list = $x2list) $xlist[fweight = fac00], vce(robust)
estat firststage, forcenonrobust

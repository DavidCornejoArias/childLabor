* working on my own paper to see what the hell man...
cd "directions"
* import dataset
use "EHPM2018.dta", replace
* Setting only sons or daughters
drop if r103 != 3
* Run a sequence of ordered child
gsort +idboleta -r106
gen change = idboleta[_n] - idboleta[_n-1]
gen negr106 = -r106 
replace r403 = 0 if r403 ==2
egen childrenInFamily = count(r101), by (idboleta)
egen numberOfWorkingChildren=sum(r403), by(idboleta)

*relatinship between firstborn and child word
tabulate r403 [fweight = fac00] if r106<18
* Leaving just minors
drop if r106 >17
gen firstBorn = 1 if change>0
replace firstBorn = 0 if missing(firstBorn)
tabulate firstBorn r403 [fweight = fac00], chi2
*relatinship between familySize and child word
tabulate childrenInFamily r403 [fweight = fac00], chi2
*relatinship between income and child word
logit r403 ingfa [fweight = fac00]
* Just have one for family
drop if change == 0 | missing(change)
* addding the variables
* charging data
global ylist r403
global xlist childrenInFamily ingfa

describe $ylist $xlist
summarize $ylist $xlist
logit $ylist $xlist [fweight = fac00] if change > 0 & ! missing(change)
*marginal effect in the mean and average marginal effet
quietly logit $ylist $xlist [fweight = fac00]
margins, dydx(*) atmeans
margins, dydx(*)

* predicted probabilities
quietly logit $ylist $xlist [fweight = fac00]
predict plogit, pr
predict perrors, residuals
summarize $ylist plogit
*percent correctly predicted values
quietly logit $ylist $xlist [fweight = fac00]
estat classification
* Install
tabulate r403 childrenInFamily, chi2
*ssc install texdoc, replace

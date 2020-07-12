clear all
cd "direction"
use "EHPM2018.dta", replace
cd "direction\labourEconomicsPaper"
* ssc install textdoc
*net from http://www.stata-journal.com/production
*net install sjlatex
*sjlatex install
* ssc install listtex
* ssc install webdoc
drop if r103 != 3

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
*cleaning from accent marks
label variable r106 "Age in years"
label variable ingpe "Income per family menber"
label variable aproba1 "Years of studied aproved"
label variable r1119_2 "Victim of robbery or assault"
label variable r403 "Are you working?"
label variable ingfa "Family total income"
label variable firstBorn "First Born Children"
label variable childrenInFamily "How many sibilings do you have"
label variable r403 "did you work last week?"
label define r403 1 "Yes" 0 "No", replace
label define firstBorn 1 "Yes" 0 "No", replace
texdoc do "performingAnalysisAndText.do"

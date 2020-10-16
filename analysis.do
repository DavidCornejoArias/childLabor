/*** 
\documentclass[a4paper]{article}
\usepackage{stata}
\usepackage{hyperref}
\usepackage{graphicx}
\graphicspath{{C:/Users/david/Documents/cover letterand others/labourEconomicsPaper/}}
\begin{document}
\begin{center}
  {\bf{\Large Child labor and birth order in El Salvador}} \\
  \vspace*{.2in}

  \begin{tabular}{cc}
    Adaptation: David Rolando Cornejo Arias,
   \\[0.25ex]
 \texttt{davidcornejoarias@gmail.com} \\  
  \end{tabular}
\end{center}
\begin{center}
\section*{Abstract}
\end{center}
Child labor in low and middle income countries is shown to have adverse effects in school achievement, health and future income. Because of this, I study the determinants of child labor. One of the most significant relationships, found in the literature, is that children who are the first born are the ones most likely to work from the family. In the present study, I look at how this relationship is influenced by family income and family size using data from El Salvador and a simple linear regression through which I found significant results with family size increasing the likelyhood of the first born child engaging in work and family income reducing it. These results justify special education policies for first born children in El Salvador since the already mentioned consequences of child labor in developing countries.  \\

\section*{Introduction}

Child labor in low and middle-income countries is shown to have adverse effects in school achievement (Gunnarsson, 2006), health (Carter, 2007) and future income (Kathleen Beegle, 2009).  Therefore, it is important to study what are the determinants of child labor.\\

Underage workers have average lower scores on mathematics and language examinations in Latin America (Dammert, 2010). Additionally, there seems to be no substitution effect from boys to girls in child labor or viceversa(Gunnarsson, 2006). 

In the present article, I study the way that the family’s per capita wealth affects the relationship between the first-born and child labor in El Salvador. It is well established in the literature that the first born is more likely to engage in child labor than the other children in a family (Souza, 2008; Orraca, 2014; Gurmu, 2015; Verheyden, 2007). According to Tenikue and Verheyden (2007) and Seid and Gurmu (2015) family income and number of people in the family are two determinants of a family having at least one of their children working. I explore
how these control variables affect the decision specifically of the first born to work in El Salvador. \\

To study child labor in El Salvador, I used the country's household survey from 2018. This is a person level data representative of El Salvador's total population. Every individual in the dataset is organized within a household but for most of the analysis I used only firstborn children who are underaged. We calculated for each one of them, the number of sibilings and family income and using this information I ran the following descriptive analysis.\\



The International Labor Organization (ILO) defines a child as a person who is between 5 and 17 years old. In El Salvador, it has been found that 140,700 children are participating in the labor market in 2015, according to the General Directorate of Statistics and Censuses (DIGESTYC), thus confirming the existence of child labor in the country. Additionally, based on data use on this study, around 0.08 of the children in El Salvador work in Table 1. Besides, I found a relationship between birth order and child labor in Table 2 and Graphic 1, between underage work from firstborn and family size in Table 3 and Graphic 2, and between firstborn working and family income in Graphic 3, all with significant results. Additionally, as expected, we show the relationship between health insurance and child labor for people under 18 in Table 4.\\

***/

/*** 
\section*{Literature review and theoretical model}
The literature explains that the firstborn is more likely to engage in labor because he or she has higher earning potential (Souza, 2008). One of mathematical model explaining this relationship was developed in 2008 by Patrick Emerson and André Souza. This theory focuses on two aspects: the first is that as the level of household income is lower, the first-born son tends to have a high probability of working, and the second is that older children tend to receive more wages due to their greater experience compared to younger ones (Souza, 2008).\\

In this theoretical models, the family income level weakens the relationship between firstborn and child labor. This makes that at a higher income level, the birth order is not so relevant to make the decision to send the minor children to work. Other research showed the relationship that poverty affected child labor  (Schady, 2012). Family size strengthens this relationship (Souza, 2008), since the bigger the family, the more money will be needed.\\

\section*{Methodology}
To study this relationship I ran a least squared model. I used total income in family, number of children, area of the house (Urbal or Rural) and years of studies approved as independent variables. The dependent variable is numbers of hours the firstborn child works. In this case, the relation can be described as:\\
 
HoursFirstBornWork = $\beta_0$ + $\beta_1$YearsSchool + $\beta_2$Area + $\beta_3$ChildrenFamily + $\beta_4$Ingfa\\

The data was taken from El Salvador’s 2018 household survey dataset (EHPM). I keep from the data all the firstborn children of a family who were under 18 years and calculated the number of sibilings they have and the family income. At the end, we finished with 94,114 observations.\\
***/

* import dataset
* variable documentation EHPM
* file:///C:/Users/david/Dropbox/cover%20letterand%20others/DOCUMENTACION_VARIABLES_EHPM_2008.pdf


*treatreg $ylist $xlist, treat($y2list = $x2list $xlist)

* so far the less significant is poverty,weird, isn't it?
*r1119_4


*gen firstborn variable

* I believe I can start making analysis now
/*** 
\section*{Results}
All of the coefficients for the results are significant and, as expected by theory, the family income has a negative effect in the hours the firstborn children works, if they are from the rural area they work more, the more sibilings they have it's positive related to the numbers of hours worked and the more years they have studied the less hours they work. This empirical model does not pass the test of Breusch-Pagan for heteroskedasticity in Table 5 so we use robut estimators. \\ \\


Coefficients for least squares model:
***/
label variable r403 "Firstborn working"
global ylist h412a
global y2list ingfa
global xlist aproba1 area childrenInFamily ingfa
global x2list r1119_2
texdoc stlog, cmdstrip
	eststo, title("Hours worked"): quietly regress $ylist $xlist[fweight = fac00] if firstBorn != 0, robust
	estout, cells("b(star label(Coef.)) se(label(Std. err.))")  ///
    stats(r2 N, labels(R-squared "N. of cases"))            ///
    label legend varlabels(_cons Constant)
texdoc stlog close


/*** 

\section*{Conclusions}
The less income the family earns and the more children there are, the more hours the firstborn will spend working. This is particularly important for policy implications since in developing countries such as El Salvador, the more a child works the worst health, education achievement and future income they will have, compare to others of the same age. These young workers should be looked after, assuring that if necessary they work under formal conditions, with the posibility to achieve a minimal level of education and access to health.\\

\section*{Appendix}
\noindent
Table 1: Child labor in El Salvador
***/
label variable r403 "did you work last week?"
label variable h412a "Normal working hours in a week"
label define r403 1 "Yes" 0 "No", replace
label define firstBorn 1 "Firstborn works" 0 "Firstborn doesn't work", replace
eststo clear
estpost tabulate r403 [fweight = fac00]
texdoc stlog, cmdstrip
	esttab, cells("b(label(freq)) pct(fmt(2)) ")  varlabels(, blist(Total "{hline @width}{break}")) nonumber nomtitle noobs
texdoc stlog close
/*** 
Graph 1: Relationship between usual working hours and being the firstborn child
***/
texdoc stlog, nolog
	graph box  h412a [fweight = fac00] if h412a!=0, by(, title("Prove relationship between first born and usual work hours")) by(firstBorn)
texdoc stlog close
texdoc graph
/*** 
Table 2: Relationship between being a firstborn and child labor condition
***/
	eststo clear
	label variable r403 "did you work last week?"
	label define r403 1 "Yes" 0 "No", replace
	label variable firstBorn "Child Work?"
	label define r403 1 "Yes" 0 "No", replace
	estpost tabulate firstBorn r403 [fweight = fac00]
texdoc stlog, cmdstrip
	esttab, cell(pct(fmt(2))) eqlabels("Child work" "No child work" "Total", lhs("Is a firstborn"))  collabels(none) unstack noobs label varlabels(, blist(Total "{hline @width}{break}"))
texdoc stlog close
/*** 
Graph 2: Relationship between child labor for firstborn and the size of the family
***/
texdoc stlog, nolog
	graph box childrenInFamily [fweight = fac00] if firstBorn !=0, by(, title("Children in family and first born working")) by(r403)
texdoc stlog close
texdoc graph
/*** 
Table 3: Relationship between child labor for firstborn in a family and the size of the family
***/
	eststo clear
	estpost tabulate childrenInFamily r403 [fweight = fac00] if firstBorn != 0
texdoc stlog, cmdstrip
	esttab, cell(pct(fmt(2))) eqlabels("Child work" "No child work" "Total", lhs("Number of children"))  collabels(none) unstack noobs label varlabels(, blist(Total "{hline @width}{break}"))
texdoc stlog close
/*** 
Graph 3: Relationship between child labor and family income
***/
texdoc stlog, nolog
	graph box ingfa [fweight = fac00] if firstBorn !=0, by(, title("Firstborn childlabor and family income")) by(r403)
texdoc stlog close
texdoc graph

gen seguroMedico = 1 if r601 != 8
replace seguroMedico=0 if missing(seguroMedico)
label variable seguroMedico "Do you have health insurance"
label define seguroMedico 1 "Yes" 0 "No", replace
/*** 
Table 4: Relationship between child labor and health insurance
***/
eststo clear
estpost tabulate seguroMedico r403 [fweight = fac00]
texdoc stlog, cmdstrip
	esttab, cell(pct(fmt(2))) eqlabels("Child work" "No child work" "Total", lhs("Have insurance"))  collabels(none) unstack noobs label varlabels(, blist(Total "{hline @width}{break}"))
texdoc stlog close
/*** 
Table 5: Breusch-Pagan test for heteroskedasticity
***/
regress $ylist $xlist[fweight = fac00] if firstBorn != 0
texdoc stlog, cmdstrip
	estat hettest
texdoc stlog close
/***
\section*{References}
Carter, D. T. (2007). Socioeconomic causes of child labor in urban Nigeria. Journal of Children and Poverty, 73-89.\\

Dammert, A.C. Siblings, child labor, and schooling in Nicaragua and Guatemala. J Popul Econ 23, 199–224 (2010).\\

Gurmu, Y. S. (2015). The role of birth order in child labour and schooling. Applied Economics, 5262-5281.\\

Kathleen Beegle, R. D. (2009). Why Should We Care About Child Labor? The Journal of Human Resources, 871-889.\\

Orraca, P. (2014). Child Labor and its Causes in Mexico. Problemas del desarrollo, 113-137.\\

Schady, E. V. (2012). Poverty Alleviation and Child Labor. Economic Policy, 100-124.\\

Souza, P. M. (2008). Birth Order, Child Labor, and School Attendance in Brazil. Elsevier, 1647-1664.\\

Verheyden, M. T. (2007). Birth Order, Child Labor and Schooling:.\\

Victoria Gunnarsson, P. F. (2006). Child Labor and School Achievement in Latin America. The world bank economic review, 31-54.\\



***/

/***
\end{document}
***/

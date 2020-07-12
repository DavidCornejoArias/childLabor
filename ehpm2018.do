/*** 
\documentclass[a4paper]{article}
\usepackage{stata}
\usepackage{hyperref}
\begin{document}
\begin{center}
  {\bf{\Large Adaptation of final Project of Quantitative Research Methods}} \\
  \vspace*{.2in}
  
  \begin{tabular}{cc}
    Adaptation: David Rolando Cornejo Arias,
   \\[0.25ex]
   {\small Original authors:}\\
   {\small David Rolando Cornejo Arias,}\\
   {\small Erick Ramiro Barrios,}\\
   {\small Maria Alejandra Flores,}\\
   {\small Adrian Serrano}\\
 \texttt{davidcornejoarias@gmail.com} \\  
  \end{tabular}
\end{center}
\section*{Introduction}

Child labor in low and middle income country is shown to have adverse effects in school achievement (Victoria Gunnarsson, 2006), health (Carter, 2007) and future income (Kathleen Beegle, 2009).  Therefore it is important to study what are the determinants of child labor.\\\

In the present study, we research the way that the family member and family’s wealth affect the relationship between the first-born and child labor in El Salvador. The relationship between first born and child labor is well stablished in the literature (Souza, 2008) (Orraca, 2014) (Gurmu, 2015) (Verheyden, 2007). In this paper, we will study how the decision of the family to send their first born to work is influenced by family income and number of siblings of the first born. According to (Tenikue and Verheyden, 2007) and (Seid and| Gurmu, 2015) those are two relevant factors. \\\

The International Labor Organization (ILO) defines a child as a person who is between 5 and 17 years old. In El Salvador, it has been found that 140,700 children are participating in the labor market, according to the report presented by the entity in charge of producing relevant and reliable statistical figures on it; General Directorate of Statistics and Censuses (DIGESTYC) in 2015, thus confirming the existence of child labor in the country. Additionally, based on data taken from the 2018 Household Survey of Multiple Purpose (EHPM), 0.08 of the children in El Salvador work and a relationship is observed between birth order and child labor, as well with household size and family income with significant results.\\\

\noindent
Table 1: displays the relationship between wether if a child is the first born and if is working
***/
texdoc stlog, cmdstrip
tabulate firstBorn r403 [fweight = fac00], chi2
texdoc stlog close
/*** 
Table 2: displays the relationship between child work in a family and the size of the family
***/	
texdoc stlog, cmdstrip
tabulate childrenInFamily r403 [fweight = fac00], chi2
texdoc stlog close
/*** 
\section*{Literature review}
In the literature, the first born is more likely to engage in labor because he or she has higher earning potential (Souza, 2008). One mathematical model was developed in 2008 by Patrick Emerson and André Souza; This theory focuses on two aspects: the first is that as the level of household income is lower, the first-born son tends to have a high probability of working, and the second is that older children tend to receive more wages due to their greater experience compared to younger ones (Souza, 2008).\\\

The family income level weakens the relationship between first born and child labor, since the higher the income level, the birth order is not so relevant to make the decision to send your minor children to work. It is shown in different papers the relationship between poverty and child labor  (Schady, 2012). Family size strengthens the relationship(Souza, 2008), since the bigger the family, the more money will be needed. \\\

\section*{Methodology}
To study this relationship we run a two steps least squared model to control for any cofounding factors. We used income per capita by family, years of studies approved and as instrument victims of asaults or robbery.
 
IncomePerFamilyMenber = Bo + B1*VictimOfRobery + B2*AprobaYears\\\
 
HoursFirstBornWork = Bo + B1*IncomePerFamilyMenber + B2*AprobaYears\\\

We use El Salvador’s 2018 household survey dataset (EHPM). You can access the code and replicate it in \href{https://github.com/DavidCornejoArias/childLabor}{here}.
***/

* import dataset
* variable documentation EHPM
* file:///C:/Users/david/Dropbox/cover%20letterand%20others/DOCUMENTACION_VARIABLES_EHPM_2008.pdf


drop if change == 0 | missing(change)
label variable r403 "First born working"
global ylist h412a
global y2list ingpe
global xlist aproba1 
global x2list r1119_2

*Weak instruments
quietly ivregress 2sls $ylist ($y2list = $x2list) $xlist[fweight = fac00], vce(robust)
estat firststage, forcenonrobust

*treatreg $ylist $xlist, treat($y2list = $x2list $xlist)

* so far the less significant is poverty,weird, isn't it?
*r1119_4


*gen firstborn variable

* I believe I can start making analysis now
/*** 
\section*{Results}
\noindent
Table 3: displays coefficients for 2 steps least squared of first born working hours and family income
***/
texdoc stlog, cmdstrip
	eststo, title("First stage"): quietly regress $y2list $x2list $xlist[fweight = fac00]
	predict y2hat, xb
	eststo, title("Second stage"): quietly regress $ylist y2hat $xlist[fweight = fac00]
	estout, cells("b(star label(Coef.)) se(label(Std. err.))")  ///
    stats(r2 N, labels(R-squared "N. of cases"))            ///
    label legend varlabels(_cons Constant)
texdoc stlog close

/*** 
All of the coefficients for our results are significant and as expected the income per capita has a positive effect in hours that the first born work.\\\

The instrumental variables are strong, as shown by the following test for weak instrumental variables in table 4.\\\

***/
texdoc stlog, cmdstrip
	quietly ivregress 2sls $ylist ($y2list = $x2list) $xlist[fweight = fac00], vce(robust)
	estat firststage, forcenonrobust
texdoc stlog close
/***
\section*{Conclusions}
In this paper, we study the effects the decision of a household to send their first born to work, family’s wealth and number of children. This is important because children who engaged in child work, especially in where most people are employed in the informal sector as El Salvador, tend to leave school earlier. Both decisions were significant and as expected by the literature.\\\
\section*{References}
Carter, D. T. (2007). Socioeconomic causes of child labor in urban Nigeria. Journal of Children and Poverty, 73-89.\\\

Gurmu, Y. S. (2015). The role of birth order in child labour and schooling. Applied Economics, 5262-5281.\\\

Kathleen Beegle, R. D. (2009). Why Should We Care About Child Labor? The Journal of Human Resources, 871-889.\\\

Orraca, P. (2014). Child Labor and its Causes in Mexico. Problemas del desarrollo, 113-137.\\\

Souza, P. M. (2008). Birth Order, Child Labor, and School Attendance in Brazil. Elsevier, 1647-1664.\\\

Verheyden, M. T. (2007). Birth Order, Child Labor and Schooling:.\\\

Victoria Gunnarsson, P. F. (2006). Child Labor and School Achievement in Latin America. The world bank economic review, 31-54.


***/


/***
\end{document}
***/

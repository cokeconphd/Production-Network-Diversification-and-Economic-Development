
 ****************************************************************************************************************************** 
*Production Diversification and Economic Development(2023) _ JEBO

*cd "C:\Users\fle13k\Dropbox\0_PEGA______David\1 Working Papers\jorge_DENSITY AND GROWTH PAPER\ALL Todo todito\JEBO"

cd "C:\Users\uqjmira1\Dropbox\Development_Diversification\JEBO"

import excel "data_panel_95_11_JEBO.xlsx", sheet("Sheet0") firstrow clear


***generating log variables
g ldomin=log(domin)
g lgdppc=log(gdppc)
g ldens1=log(dens1)
g ldens2=log(dens2)
g ldens3=log(dens3)
g ldens4=log(dens4)
g lsfin =log(size_fin)
g ltrade=log(trade)
g lpop=log(population)
g lsize =log(size) 
g lnr   =log(nr)
g lservice =log(service)
g ldens1dom=log(dens1_dom)
g lgdppc2  =lgdppc^2
g gdppc2   =gdppc^2


destring voice_account, replace

sort cou_code year

xtset cou_code year


***Lagging variables
sort cou_code
sort cou_code year

g lagg_ldens1=ldens1[_n-1]
*g lagg_ldens1_sq = lagg_ldens1*lagg_ldens1
g lagg_ECI2 = ECI2[_n-1]
g lagg_ldomin= ldomin[_n-1]
g lagg_lsfin = lsfin[_n-1]
g lagg_lservice = lservice[_n-1]
g lagg_lnr = lnr[_n-1]
g lagg_ltrade = ltrade[_n-1]
g lagg_schooling = schooling[_n-1]
g lagg_controlofcorruption = controlofcorruption[_n-1]
g lagg_voice_account = voice_account[_n-1]
g lagg_rule_of_law = rule_of_law[_n-1]
g lagg_GovtEffectiveness = GovtEffectiveness[_n-1]
g lagg_PoliticalStability = PoliticalStability[_n-1]
g lagg_RegulatoryQuality = RegulatoryQuality[_n-1]
g lagg_lpop = lpop[_n-1]
g lagg_ldens1dom = ldens1dom[_n-1]
g lagg_ldens2 = ldens2[_n-1]
g lagg_ldens3 = ldens3[_n-1]
g lagg_ldens4 = ldens4[_n-1]

g lagg_den = dens1[_n-1]
*g lagg_d2  = dens1[_n-1]*dens1[_n-1]

gen lfor_io    = log(for_io)
gen lback_io   = log(back_io)
gen lcap_stock = log(cap_stock)

g lagg_capital = lcap_stock[_n-1]
g lagg_forward = lfor_io[_n-1]
g lagg_backw   = lback_io[_n-1]

g lneduc            = log(schooling)
g lagg_schooling2   = lneduc[_n-1]

gen pop2 = population[_n-1]
gen popgr = (population-pop2)/pop2*100

 
*********************OLS of Figure2
reg lgdppc dens1, robust

*checking non-linearity
gen dens1_sq = dens1*dens1
reg lgdppc dens1 dens1_sq, robust


*********************Panel FE estiamtes of Table 2 (Main results) 

eststo reglag1: reghdfe lgdppc lagg_ldens1    if year!=1995, a(cou_code) vce(cluster country)

eststo reglag2: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling2  lagg_rule_of_law  popgr lagg_capital lagg_backw lagg_forward if year!=1995, a(cou_code ) vce(cluster country)

eststo reglag3: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling2  lagg_rule_of_law  popgr lagg_capital lagg_backw lagg_forward if year!=1995, a(cou_code year) vce(cluster country)  

esttab reglag1 reglag2 reglag3  using table21_JEBO.tex, replace se scalars(r2)  starlevels(* 0.1 ** 0.05 *** 0.01) 
eststo clear


********************* Estimate interpretaion calculations given average GDPpc $20,743 ***************

**10 percent increase in density for column 3 (Table 2), considering mean GDPpc as shown in Table 3
dis 20743*1.037
*21510.491
dis 21510.491-20743
*767.491

**10 percent increase in domestic density for column 3 (Table 4)
dis 20743*1.0293
*21350.77
dis 21350.77-20743
*607.77

**10 percent increase in density (threshold 0.00001) for column 3 (Table 5)
dis 20743*1.0577
*21939.871
dis 21939.871-20743
*1196.871


********* OTHER FIGURES AND  Tables************************

******** Table 1 Summary Stats

bys country : egen SD_dens1_within = sd(dens1)
mvencode SD_dens1_within, mv(0)

bys year : egen SD_dens1_across = sd(dens1)
mvencode SD_dens1_across, mv(0)


sum dens1 gdppc 

su SD_dens1_across if cou_code==21
*** "if" option placed to capture across countries 

su SD_dens1_within if year==1996
*** "if" option placed to capture over time



************************* Figure 2
*** Log GDPpc  vs Density, Panel
twoway (scatter lgdppc dens1 , graphregion(color(white))   mlabsize(tiny )  note(`"Note: Network density vs GDP per capita for all 55 countries across 17 years "') ///
ytitle("Log GDP per capita") xtitle("Production network density") legend(label(1 "Network Density") pos(7))) ///
(lfit lgdppc dens1 , graphregion(color(white)) mlabsize(tiny )  note(`"Note: OLS coefficient is  4.65 with a robust standard error of 0.28. R-squared is 0.28. "') ///
ytitle("Log GDP per capita, 1995-2011") xtitle("Production network density, 1995-2011") legend(label(1 "Network Density") pos(7)))
graph export Figure_2.png, replace


reg lgdppc dens1, r


*Wihout Cambodia
preserve
keep if cou_code !=40
twoway (scatter lgdppc dens1 , graphregion(color(white))   mlabsize(tiny )  note(`"Note: Network density vs GDP per capita for all countries, except Cambodia, across 17 years "') ///
ytitle("Log GDP per capita") xtitle("Production network density") legend(label(1 "Network Density"))) ///
(qfit lgdppc dens1 , graphregion(color(white)) mlabsize(tiny )  note(`"Note: OLS coefficient is  3.9 with a robust standard error of 0.26. R-squared is 0.21. "') ///
ytitle("Log GDP per capita, 1995-2011") xtitle("Production network density, 1995-2011") legend(label(1 "Network Density")))
graph export Figure_2_nocambodia.png, replace
reg lgdppc dens1, r

restore


********* Empirical Appendix Tables************************


*** Table 3 Summary Stats

sum gdppc dens1 ECI2 domin size_fin trade service schooling popgr nr rule_of_law cap_stock back_io for_io
sum popgr  if year!=1995



***Table 4 (Domestic Denisty) with lags 

eststo reglag1: reghdfe lgdppc lagg_ldens1dom    if year!=1995, a(cou_code) vce(cluster country)
eststo reglag2: reghdfe lgdppc lagg_ldens1dom lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling2  lagg_rule_of_law  popgr lagg_capital lagg_backw lagg_forward if year!=1995, a(cou_code ) vce(cluster country)
eststo reglag3: reghdfe lgdppc lagg_ldens1dom lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling2  lagg_rule_of_law  popgr lagg_capital lagg_backw lagg_forward if year!=1995, a(cou_code year) vce(cluster country)  

esttab reglag1 reglag2 reglag3  using table41_JEBO.tex, replace se scalars(r2)  starlevels(* 0.1 ** 0.05 *** 0.01) 
eststo clear

***Table 5 (Density 4 Threshold 0.00001) with lags 

eststo reglag1: reghdfe lgdppc lagg_ldens4    if year!=1995, a(cou_code) vce(cluster country)
eststo reglag2: reghdfe lgdppc lagg_ldens4 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling2  lagg_rule_of_law  popgr lagg_capital lagg_backw lagg_forward if year!=1995, a(cou_code ) vce(cluster country)
eststo reglag3: reghdfe lgdppc lagg_ldens4 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling2  lagg_rule_of_law  popgr lagg_capital lagg_backw lagg_forward if year!=1995, a(cou_code year) vce(cluster country)  

esttab reglag1 reglag2 reglag3  using table51_JEBO.tex, replace se scalars(r2)  starlevels(* 0.1 ** 0.05 *** 0.01) 
eststo clear



*****Table 6 (without cambodia )
eststo reglag1: reghdfe lgdppc lagg_ldens1    if year!=1995 & cou_code!=35, a(cou_code) vce(cluster country)

eststo reglag2: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling2  lagg_rule_of_law  popgr lagg_capital lagg_backw lagg_forward if year!=1995 & cou_code!=35, a(cou_code ) vce(cluster country)

eststo reglag3: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling2  lagg_rule_of_law  popgr lagg_capital lagg_backw lagg_forward if year!=1995 & cou_code!=35, a(cou_code year) vce(cluster country)  

esttab reglag1 reglag2 reglag3  using table61_JEBO.tex, replace se scalars(r2)  starlevels(* 0.1 ** 0.05 *** 0.01) 
eststo clear




*** OLD Figure 2.

/*gen lgdppc_2011_0 = lgdppc if year==2011
gen dens1_95_0 = dens1 if year==1995
bysort country: egen dens1_95=max(dens1_95_0)

twoway (scatter lgdppc_2011 dens1_95 , graphregion(color(white))  mlabel(country) mlabsize(tiny ) ///
ytitle("Log GDP per capita, 2011") xtitle("Production network density, 1995") legend(label(1 "Network Density"))) ///
(qfit lgdppc_2011 dens1_95 , graphregion(color(white))  mlabel(country) mlabsize(tiny )  note(`"Note: OLS coefficient is 4.8 with a robust standard error of 0.84. R-squared is 0.43. n=55 "'))
graph export fig1_two.png, replace

*parameters and coefficients in Note:
reg lgdppc_2011 dens1_95 , r
*/






*******************CHECKING 2 SUBSAMPLES....
**sum by country
tabstat gdppc, by( country ) stats(min max mean range)

*REGS OF OBSERVATIONS BELOW THE MEAN GDPPC OF WHOLE PANEL  ***DENSITY SIGNIFICANT
eststo reglag1: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability                        lagg_lpop               if year!=1995 & gdppc<20743.48 , a(cou_code ) vce(cluster cou_code)

eststo reglag2: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop               if year!=1995 & gdppc<20743.48 , a(cou_code year) vce(cluster cou_code)

eststo reglag3: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop lagg_forward  if year!=1995 & gdppc<20743.48 , a(cou_code year) vce(cluster cou_code)

eststo reglag4: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop lagg_backw    if year!=1995 & gdppc<20743.48 , a(cou_code year) vce(cluster cou_code)

eststo reglag5: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop lagg_capital  if year!=1995 & gdppc<20743.48 , a(cou_code year) vce(cluster cou_code)

eststo reglag6: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop lagg_capital lagg_backw lagg_forward if year<=2011 & year!=1995 & gdppc<20743.48 , a(cou_code year) vce(cluster cou_code)

*eststo reglag7: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_capital lagg_backw lagg_forward if year!=1995 & gdppc<20743.48, a(cou_code year) vce(cluster cou_code)

esttab ,  replace p scalars(r2)  starlevels(* 0.1 ** 0.05 *** 0.01) keep( lagg_ldens1 lagg_ECI2 lagg_capital lagg_forward lagg_backw )

eststo clear







*outreg2 using "fe_dens1_draft4.tex", tex(fragment) drop(i.year) replace






*REGS OF OBSERVATIONS ABOVE THE MEAN GDPPC OF WHOLE PANEL ***DENSITY NO LONGER SIGNIFICANT...
eststo reg_1: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability                        lagg_lpop               if year!=1995 & gdppc>20743.48 , a(cou_code ) vce(cluster cou_code)

eststo reg_2: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop               if year!=1995 & gdppc>20743.48 , a(cou_code year) vce(cluster cou_code)

eststo reg_3: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop lagg_forward  if year!=1995 & gdppc>20743.48 , a(cou_code year) vce(cluster cou_code)

eststo reg_4: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop lagg_backw    if year!=1995 & gdppc>20743.48 , a(cou_code year) vce(cluster cou_code)

eststo reg_5: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop lagg_capital  if year!=1995 & gdppc>20743.48 , a(cou_code year) vce(cluster cou_code)

eststo reg_6: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop lagg_capital lagg_backw lagg_forward if year<=2011 & year!=1995 & gdppc>20743.48 , a(cou_code year) vce(cluster cou_code)

*eststo reg_7: reghdfe lgdppc lagg_ldens1 lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_capital lagg_backw lagg_forward if year!=1995 & gdppc>20743.48 , a(cou_code year) vce(cluster cou_code)

esttab ,  replace p scalars(r2)  starlevels(* 0.1 ** 0.05 *** 0.01) keep( lagg_ldens1 lagg_ECI2 lagg_capital lagg_forward lagg_backw )


eststo clear





/*
*** Figure 3? --Charts for all countries
*same year
graph twoway (scatter lgdppc dens1, graphregion(color(white)) mlabpos(0) mlabsize(tiny) mlabcolor(black)), by(country, cols(7) ) ///
ytitle(Log GDP per capita) xtitle(Production network density) ///            
graph export fig3_all.png, replace
 
*density lagged one year
sort cou_code
sort cou_code year
g lg_dens1=dens1[_n-1]

graph twoway (scatter lgdppc lg_dens1 if year!=1995, graphregion(color(white)) mlabpos(0) mlabsize(tiny) mlabcolor(black)), by(country, cols(7) ) ///
ytitle(Log GDP per capita) xtitle(Production network density lagged) ///            
graph export fig3_all_denslagged.png, replace


qui {
/*

***************************

** Table 2
xtreg lgdppc ldens1 , fe r
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) replace

xtreg lgdppc ldens1  ECI2 ldomin lsfin lservice lnr , fe r
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year)
xtreg lgdppc ldens1  ECI2 ldomin lsfin lservice lnr ltrade schooling controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop , fe r
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year)


***ADDING TIME FIXED EFFECTS 

xtreg lgdppc ldens1 i.year  , fe cluster(cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) replace

xtreg lgdppc ldens1 i.year ECI2 ldomin lsfin lservice lnr , fe vce(cluster cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 

xtreg lgdppc ldens1 i.year ECI2 ldomin lsfin lservice lnr ltrade schooling controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop , fe cluster(cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 


**REMOVING CAMBODIA
xtreg lgdppc ldens1 i.year if cou_code!=35 , fe cluster(cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) replace

xtreg lgdppc ldens1 i.year ECI2 ldomin lsfin lservice lnr if cou_code!=35 , fe vce(cluster cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 

xtreg lgdppc ldens1 i.year ECI2 ldomin lsfin lservice lnr ltrade schooling controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop if cou_code!=35 , fe cluster(cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 

*TEST without cambodia a time FE... DENSITY IS * (p-value 0.075)
xtreg lgdppc ldens1 ECI2 ldomin lsfin lservice lnr ltrade schooling controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop if cou_code!=35 , fe cluster(cou_code)

**adding cap for and back
xtreg lgdppc ldens1 lfor_io lback_io lcap_stock ECI2 ldomin lsfin lservice lnr ltrade schooling controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop if cou_code!=35 , fe cluster(cou_code)



**
xtreg lgdppc lagg_ldens1 i.year if year!=1995 & cou_code!=35  , fe cluster(cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) replace

xtreg lgdppc lagg_ldens1 i.year lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr if year!=1995 & cou_code!=35 , fe vce(cluster cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 

xtreg lgdppc lagg_ldens1 i.year lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop if year!=1995 & cou_code!=35 , fe r
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 

*with cambodia again...
xtreg lgdppc lagg_ldens1 i.year if year!=1995 & cou_code!=35  , fe cluster(cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) replace

xtreg lgdppc lagg_ldens1 i.year lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr if year!=1995 & cou_code!=35 , fe vce(cluster cou_code)
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 

xtreg lgdppc lagg_ldens1 i.year lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop if year!=1995 & cou_code!=35 , fe r
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 

**new - with cap for and backwards


************THE ONE TO USE...
xtreg lgdppc lagg_ldens1 i.year lagg_ECI2 lagg_ldomin lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop  lagg_capital  lagg_forward    lagg_backw      if year!=1995                 , fe r
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 


**new - with cap for and backwards --EXCLUDING 
xtreg lgdppc lagg_ldens1 i.year lagg_ECI2              lagg_lsfin lagg_lservice lagg_lnr lagg_ltrade lagg_schooling lagg_controlofcorruption lagg_voice_account lagg_rule_of_law lagg_GovtEffectiveness lagg_PoliticalStability lagg_RegulatoryQuality lagg_lpop  lagg_capital  lagg_forward    lagg_backw      if  year!=1995     , fe r
outreg2 using jeboRR1tables_CODE.doc, append label dec(3) drop(i.year) 


******************THIS CODE BELOW WAS NOT MODIFIED FROM THE ORIGINAL ONE
********************************************************************************************************************

*** Summary Stats

sum dens1  if year==1995, d
sum dens1  if year==2011 , d


*sutex2 dens1 gdppc SD_dens1_across SD_dens1_within , minmax percentiles(50)
 



*Build a cross-section dependent in 2011  and independent in 1995


gen lgdppc_1995_0 = lgdppc if year==1995
bysort country: egen lgdppc_1995=max(lgdppc_1995_0)

gen lgdppc_2011_0 = lgdppc if year==2011
bysort country: egen lgdppc_2011=max(lgdppc_2011_0)
*log GDPpc

gen gdppc_1995_0 = gdppc if year==1995
bysort country: egen gdppc_1995=max(gdppc_1995_0)

gen gdppc_2011_0 = gdppc if year==2011
bysort country: egen gdppc_2011=max(gdppc_2011_0)
*Just GDPpc

sort cou_code
by cou_code: gen growth = (gdppc_2011 - gdppc_1995) / gdppc_1995 






gen dens1_95_0 = dens1 if year==1995
bysort country: egen dens1_95=max(dens1_95_0)

gen dens1_11_0 = dens1 if year==2011
bysort country: egen dens1_11=max(dens1_11_0)

*Chile-NZ-AUS stats

preserve
keep if year==1996 | year==2011 | year==2015
keep if country=="New Zealand" | country=="Australia"|country=="Chile"
sort country year
br country  year inequality ECI2 dens1 gdppc rule_of_law schooling GovtEffectiveness PoliticalStability RegulatoryQuality trade size_fin service population
restore

*** Country Scatter Graph Total Denisty vs GPDpc - for 1995 v. 2011

twoway scatter lgdppc_2011 dens1_95  if year==1995 ,  mlabel(cou)  || qfit  lgdppc_2011 dens1_95 if year==1995 , mlabel(cou)  



*** Country Scatter Graph Total Denisty vs GPDpc - Panel

twoway scatter lgdppc dens1 ,  mlabel(cou)  || qfit  lgdppc dens1 if , mlabel(cou)  


 

*** Log GDPpc 2011 vs Density 95
twoway (scatter lgdppc_2011 dens1_95 , graphregion(color(white))  mlabel(country) mlabsize(tiny )  note(`"Note: Network density in 1995 vs log GDP per capita in 2011 for all 55 countries "') ///
ytitle("Log GDP per capita, 2011") xtitle("Production network density, 1995") legend(label(1 "Network Density"))) ///
(qfit lgdppc_2011 dens1_95 , graphregion(color(white))  mlabel(country) mlabsize(tiny )  note(`"Note: OLS coefficient is 4.8 with a robust standard error of 0.84. R-squared is 0.43. n=55 "') ///
ytitle("Log GDP per capita, 2011") xtitle("Production network density, 1995") legend(label(1 "Network Density")))
graph export fig1_two.png, replace





/*
preserve
keep if year==1995
sort cou_code
*copy-paste modelo implied logGDP
twoway (scatter var148 var149 , graphregion(color(white))  mlabel(country) mlabsize(tiny )  note(`"Note: Network density in 1995 vs log GDP per capita in 2011 for all 55 countries "') ///
ytitle("Log GDP per capita, 2011") xtitle("Production network density, 1995") legend(label(1 "Network Density"))) ///
(qfit var148 var149 , graphregion(color(white))  mlabel(country) mlabsize(tiny )  note(`"Note: OLS coefficient is 4.8 with a robust standard error of 0.84. R-squared is 0.43. n=55 "') ///
ytitle("Log GDP per capita, 2011") xtitle("Production network density, 1995") legend(label(1 "Network Density")))
graph export fig1_two.png, replace
restore
*/

reg lgdppc_2011 dens1_95 if year==1995, r



*** Log GDPpc  vs Density, Panel
twoway (scatter lgdppc dens1 , graphregion(color(white))  mlabel(country) mlabsize(tiny )  note(`"Note: Network density vs GDP per capita for all 55 countries across 17 years "') ///
ytitle("Log GDP per capita") xtitle("Production network density") legend(label(1 "Network Density"))) ///
(qfit lgdppc dens1 , graphregion(color(white))  mlabel(country) mlabsize(tiny )  note(`"Note: OLS coefficient is X with a robust standard error of X. R-squared is X. n=55, t=17 "') ///
ytitle("Log GDP per capita, 2011") xtitle("Production network density, 1995") legend(label(1 "Network Density")))
graph export fig1_three.png, replace


reg lgdppc dens1, r




*** gdppc avg growth Density 95
twoway (scatter growth dens1_95 , graphregion(color(white))  mlabel(country) mlabsize(tiny )  note(`"Note: Network density in 1995 vs log GDP per capita in 2011 for all 55 countries "') ///
ytitle("Average growth of GDP per capita over 1995-2011") xtitle("Production network density, 1995") legend(label(1 "Network Density"))) ///
(lfit growth dens1 , graphregion(color(white))  mlabel(country) mlabsize(tiny )  note(`"Note: Average growth of GDP per capita (1995-2011), n=55 "') ///
ytitle("Average  growth of GDP per capita over 1995-2011") xtitle("Production network density, 1995") legend(label(1 "Network Density")))
graph export avg_gdppc_growth_dens_95.png, replace






*Summary/Descriptive Stats Table for latex TABLE 1

label variable dens1 "Network density"
label variable gdppc "GDP per capita"
by country: sutex2 dens1 gdppc, label

est clear
eststo: tabstat dens1 gdppc, by(country) stat(mean sd min max) nototal long col(stat)
esttab using "table0.tex", replace 


*** Descriptive Stats for Denisty Thresholds
sutex2 dens1 dens2 dens3 dens4 if year<=2011, minmax 
corrtex dens1 dens2 dens3 dens4 if year<=2011, file(dens_corr) replace


sutex2 SD_dens1_within if year==1995, minmax 
sutex2 SD_dens1_across if cou_code==1 & year<=2011, minmax 


g population_mill=population/1000000

g trade2=trade/100
sutex2 gdppc dens1 ECI2 domin size_fin trade2 service schooling nr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality population_mill 



**** Structural Transformation inspired graphs

twoway (scatter lgdppc dens1 , graphregion(color(white))   note(`"Note: Network density vs log GDP per capita for all 55 countries period 1995-2011"') ///
ytitle("Log GDP per capita") xtitle("Production network density ") legend(label(1 "Network Density"))) ///
(qfit lgdppc dens1 , graphregion(color(white))  note(`"Note: OLS coefficient is 4.01 with a robust standard error of 0.26. R-squared is 0.21. n=935"') ///
ytitle("Log GDP per capita") xtitle("Production network density ") legend(label(1 "Network Density")))
graph export fig2.png, replace

reg lgdppc dens1 , r


*Descriptive statistics

sum lgdppc ldens1  ECI2 ldomin lsfin ltrade lservice schooling lnr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop 

reg lgdppc dens1  ECI2 domin size_fin trade service schooling nr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality population 
*outreg2 using "fe_dens1_draft4.tex", tex(fragment) drop(i.year) append
eststo: quietly estpost summarize ///
dens1  ECI2 domin size_fin trade service schooling nr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality population 
esttab, cells("mean sd min max") label nodepvar 
eststo clear


* Panel FE

xtreg lgdppc ldens1 , fe r
outreg2 using "fe_dens1_draft4.tex", tex(fragment) drop(i.year) replace
xtreg lgdppc ldens1  ECI2 ldomin lsfin ltrade lservice lnr schooling , fe r
outreg2 using "fe_dens1_draft4.tex", tex(fragment) drop(i.year) append
xtreg lgdppc ldens1  ECI2 ldomin lsfin ltrade lservice schooling lnr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop , fe r

*outreg2 using "fe_dens1_draft4.tex", tex(fragment) drop(i.year) append
eststo: quietly estpost summarize ///
    lgdppc ldens1  ECI2 ldomin lsfin ltrade lservice schooling lnr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop 
esttab, cells("mean sd") label nodepvar 


* Panel FE (dens2)

xtreg lgdppc ldens2  , fe r
outreg2 using "fe_dens2.tex", tex(fragment) drop(i.year) replace
xtreg lgdppc ldens2  ECI2 ldomin lsfin ltrade lservice lnr schooling, fe r
outreg2 using "fe_dens2.tex", tex(fragment) drop(i.year) append
xtreg lgdppc ldens2  ECI2 ldomin lsfin ltrade lservice schooling lnr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop, fe r
outreg2 using "fe_dens2.tex", tex(fragment) drop(i.year) append



* Panel FE (dens3)

xtreg lgdppc ldens3 , fe r
outreg2 using "fe_dens3.tex", tex(fragment) drop(i.year) replace
xtreg lgdppc ldens3  ECI2 ldomin lsfin ltrade lservice lnr schooling , fe r
outreg2 using "fe_dens3.tex", tex(fragment) drop(i.year) append
xtreg lgdppc ldens3  ECI2 ldomin lsfin ltrade lservice schooling lnr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop , fe r
outreg2 using "fe_dens3.tex", tex(fragment) drop(i.year) append



* Panel FE (dens4)

xtreg lgdppc ldens4 , fe r
outreg2 using "fe_dens4.tex", tex(fragment) drop(i.year) replace
xtreg lgdppc ldens4  ECI2 ldomin lsfin ltrade lservice lnr schooling  , fe r
outreg2 using "fe_dens4.tex", tex(fragment) drop(i.year) append
xtreg lgdppc ldens4  ECI2 ldomin lsfin ltrade lservice schooling lnr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop , fe r
outreg2 using "fe_dens4.tex", tex(fragment) drop(i.year) append


*Panel FE (domestic density)

xtreg lgdppc ldens1dom  , fe r
outreg2 using "fe_dens1_dom.tex", tex(fragment) drop(i.year) replace
xtreg lgdppc ldens1dom  ECI2 ldomin lsfin ltrade lservice lnr schooling  , fe r
outreg2 using "fe_dens1_dom.tex", tex(fragment) drop(i.year) append
xtreg lgdppc ldens1dom  ECI2 ldomin lsfin ltrade lservice schooling lnr controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop , fe r
outreg2 using "fe_dens1_dom.tex", tex(fragment) drop(i.year) append

******************************************************
******************************************************
** Table 2 without ECI
xtreg lgdppc ldens1  , fe r
outreg2 using "fe_dens1_draft3_eci.tex", tex(fragment) drop(i.year) replace
xtreg lgdppc ldens1  ECI2 ldomin lsfin lservice lnr , fe r
outreg2 using "fe_dens1_draft3_eci.tex", tex(fragment) drop(i.year) append
xtreg lgdppc ldens1  ECI2 ldomin lsfin lservice lnr ltrade schooling controlofcorruption voice_account rule_of_law GovtEffectiveness PoliticalStability RegulatoryQuality lpop , fe r
outreg2 using "fe_dens1_draft3_eci.tex", tex(fragment) drop(i.year) append


*****sum stats by country for Latex

latabstat dens1, by(country) statistics(mean sd min max) nototal long col(stat)

latabstat dens1 gdppc ECI2 , by(country) statistics(mean sd min max) nototal long col(stat)

tabstat dens1 gdppc ECI2, by(country) statistics(mean sd min max) 
estout using appendix.txt, replace
 

******Cross sectional results*********


gen ECI2_95_0 = ECI2 if year==1995
bysort country: egen ECI2_95=max(ECI2_95_0)

gen ECI2_11_0 = ECI2 if year==2011
bysort country: egen ECI2_11=max(ECI2_11_0)


gen schooling_95_0 = schooling if year==1995
bysort country: egen schooling_95=max(schooling_95_0)

gen rule_of_law_95_0 = rule_of_law if year==1995
bysort country: egen rule_of_law_95=max(rule_of_law_95_0)

gen GovtEffectiveness_96_0 = GovtEffectiveness if year==1996
bysort country: egen GovtEffectiveness_96=max(GovtEffectiveness_96_0)

gen PoliticalStability_96_0 = PoliticalStability if year==1996
bysort country: egen PoliticalStability_96=max(PoliticalStability_96_0)

gen RegulatoryQuality_96_0 = RegulatoryQuality if year==1996
bysort country: egen RegulatoryQuality_96=max(RegulatoryQuality_96_0)

gen lpop_95_0 = lpop if year==1995
bysort country: egen lpop_95=max(lpop_95_0)


preserve
keep  if year==1995

keep country lgdppc_1995 lgdppc_2011 dens1_95 dens1_11 ECI2_95 ECI2_11 schooling_95 rule_of_law_95 GovtEffectiveness_96 PoliticalStability_96 RegulatoryQuality_96 lpop_95 

g ldens=log(dens1_95)
eststo: quietly: reg lgdppc_2011  dens1_95,r  
eststo: quietly: reg lgdppc_2011 dens1_95 schooling_95 ,r  
eststo: quietly: reg lgdppc_2011 dens1_95 schooling_95 rule_of_law_95,r  
eststo: quietly: reg lgdppc_2011 dens1_95 schooling_95 rule_of_law PoliticalStability_96 RegulatoryQuality_96,r  
esttab, replace p scalars(r2)  starlevels(* 0.1 ** 0.05 *** 0.01)
eststo clear

eststo: quietly: reg lgdppc_2011 ldens,r  
eststo: quietly: reg lgdppc_2011 ldens schooling_95 ,r  
eststo: quietly: reg lgdppc_2011 ldens schooling_95 RegulatoryQuality_96,r  
eststo: quietly: reg lgdppc_2011 ldens schooling_95 rule_of_law_95,r  
eststo: quietly: reg lgdppc_2011 ldens schooling_95 rule_of_law PoliticalStability_96 RegulatoryQuality_96,r  
esttab, replace p scalars(r2)  starlevels(* 0.1 ** 0.05 *** 0.01)
eststo clear

eststo: quietly: reg dens1_11 lgdppc_1995,r  
eststo: quietly: reg dens1_11 lgdppc_1995 schooling_95 ,r  
eststo: quietly: reg dens1_11 lgdppc_1995 schooling_95 PoliticalStability_96 RegulatoryQuality_96,r  
eststo: quietly: reg dens1_11 lgdppc_1995 schooling_95 PoliticalStability_96 RegulatoryQuality_96 ECI2_95 , r 
esttab, replace p scalars(r2)  starlevels(* 0.1 ** 0.05 *** 0.01)
eststo clear

restore


*/
}

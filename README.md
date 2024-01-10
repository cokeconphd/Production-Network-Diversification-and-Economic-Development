# Production-Network-Diversification-and-Economic-Development
Replication files "Production Network Diversification and Economic Development"
Production Diversification and Economic Development
Replication materials
November 2023
Jorge Miranda-Pinto, David Fleming-Muñoz, José Gloria
(contact: j.mirandapinto@uq.edu.au)
Files included in the replication folder
•	Scripts used for configurations
o	dom_IOloading_JEBO.m
o	total_IOloading_JEBO.m
o	output_loading_JEBO.m
o	cons_loading_JEBO.m
o	density_allmeasures_JEBO.m
o	density_domesticmeasures_JEBO.m
o	Gloria et al_JEBO_May2023.do
o	development_density_model_calibration_nov23_JEBO.m
o	development_density_model_nov23_counterfactual_JEBO.m

•	Data files 
o	master1.xlsx (OECD Input-Output tables)
o	master_dom1.xlsx (OECD Input-Output tables, with only domestic networks)
o	data_panel_95_11_JEBO.xlsx (main data set, 55 countries from 1995 to 2011)

Configuration of the main variable Density and associated measures: 
●	Necessary Files: 
○	Matlab Scripts
■	dom_IOloading_JEBO.m
■	total_IOloading_JEBO.m
■	output_loading_JEBO.m
■	density_allmeasures_JEBO.m
■	density_domesticmeasures_JEBO.m
○	Excel files 
■	master1.xlsx
■	master_dom1.xlsx


●	Steps
1.	‘master1.xlsx’ and ‘master_dom1.xlsx’ contain OECD Input-Output (I-O) tables from 1995 to 2011 for all industries (including exports and imports) and for only domestic industries, respectively, across 55 countries. 
2.	Running the code in ‘dom_IOloading_JEBO.m’, ‘total_IOloading_JEBO.m’, and ‘output_loading_JEBO.m’ would prepare I-O matrices for calculating variables . They are styled as ‘ioYEAR’, ‘outputYEAR’ and ‘iodomYEAR’. Ensure that these matrices are stored in the same folder.
3.	Once all I-O matrices have been compiled you may run code in ‘density_allmeasures_JEBO.m’ to create the Density variable and associated measures. The file ‘density_domesticmeasures_JEBO.m’ will calculate the Density measure that only considers domestic networks . 
Configuration of Regression Tables and Figure 2: 
●	Necessary Files:
■	data_panel_95_11_JEBO.xlsx  
■	Gloria et al_JEBO_May2023.do

●	Steps
1.	‘data_panel_95_11_JEBO.xlsx’ houses our main data set with all variables (see “Data section” in manuscript). Data sources are the World Bank database, World Governance Indicators, and Penn World Tables. Variables were collected for each of the 55 OECD countries in our analysis, with as many data points as possible from 1995 to 2011. We find the data to be strongly balanced. 
2.	Once ‘data_panel_95_11_JEBO.xlsx’ has been imported into STATA, you may run the code in ‘Gloria et al_JEBO_May2023.do’. This will result in all tables and Figure 2 in manuscript. 

Configuration of Counterfactuals and their associated figures: 
●	Necessary Files:
■	development_density_model_calibration_nov23_JEBO.m
■	development_density_model_nov23_counterfactual_JEBO.m

●	Steps
1. ‘development_density_model_calibration_nov23_JEBO.m’ performs the calibration of varrho_M, the love of diversification parameter.   
2. ‘development_density_model_calibration_nov23_JEBO.m’ simulate long series of each of the four economies we use in the counteractuals. The parameters epsQ, varrhoM, sigma_z, and the selected countries must be changed according to the numbers stated in the paper.
 

Codebook
Variable	Definition 	Source
ECI+	Economic Complexity Index +	Hartmann et al complexity index +
dens1_dom	domestic network density threshold 1	OECD I-O DATA
dens1	total network density threshold 0.0005	OECD I-O DATA
dens2	domestic network density threshold 0.001	OECD I-O DATA
dens3	total network density threshold 0.005	OECD I-O DATA
service	service sector share	OECD I-O DATA
dens4 	total network density threshold 0.00001	OECD I-O DATA
for_io	Forward IO linkages 	OECD I-O DATA
back_io	Backward IO linkages	OECD I-O DATA
nr	natural resources 	OECD I-O DATA
trade	trade to GDP	world bank
gdppc	GDP per-capita	world bank
control of corruption	control of corruption	The Worldwide Governance Indicators
Regulatory Quality 	Regulatory Quality 	The Worldwide Governance Indicators
Political Stability 	Political Stability 	The Worldwide Governance Indicators
Gov't Effectiveness 	Government Effectiveness 	The Worldwide Governance Indicators
voice_account 	voice and accountability 	The Worldwide Governance Indicators
rule_of_law		The Worldwide Governance Indicators
size_fin	production financial sector / total production	OECD I-O DATA
schooling	Mean years of schooling (years)	World Bank
population	population	World bank
Mean years of schooling (years)	Avg Years of Schooling	World Bank
cap_stock	Capital Stock 	Penn World Tables
cou_code	country code	N/A



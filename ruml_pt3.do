*check directory*

*all drivers* 

clear

foreach yr in "1994" "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	import delimited using "C:/dissertation/data/raw/newdatafortab/newdata/Drivers_Involved_Fatal/Drivers_Involved_Fatal_`yr'.txt"
	drop in 1/2
	keep v1 v10
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	gen year = `yr'
	drop if State == "USA"
	replace State = "DC" if State == "District of Columbia"
	replace State = "NewHampshire" if State == "New Hampshire"
	replace State = "NewJersey" if State == "New Jersey"
	replace State = "NewMexico" if State == "New Mexico"
	replace State = "NewYork" if State == "New York"
	replace State = "NorthCarolina" if State == "North Carolina"
	replace State = "NorthDakota" if State == "North Dakota"
	replace State = "RhodeIsland" if State == "Rhode Island"
	replace State = "SouthCarolina" if State == "South Carolina"
	replace State = "SouthDakota" if State == "South Dakota"
	replace State = "WestVirginia" if State == "West Virginia"
	save file_difc_`yr', replace
	
	clear
}

foreach year in "1994" "1995" "1996" "1997" "1998" "1999" {
	import excel using "C:/dissertation/data/raw/pops19901999.xlsx"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	rename Geography State
	keep State July1`year'Estimate
	rename July1`year'Estimate state_pop
	drop if State == "USA"
	
	merge m:1 State using file_difc_`year'
	drop _merge
	save file_difc_`year', replace
	
	clear
}

foreach year in "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" {
	import delimited using "C:/dissertation/data/raw/pops20002009.csv"
	rename state fips
	rename name State
	drop if State == "UnitedStates"
	drop if sex != 0
	drop if age != 0
	keep fips State
	
	merge m:1 State using file_difc_`year'
	drop _merge
	save file_difc_`year', replace
	
	clear
	
	import excel using "C:/dissertation/data/raw/statepops0009.xls"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	rename state State
	replace State = "DC" if State == "DistrictofColumbia"
	keep State y`year'
	rename y`year' state_pop
	
	merge m:1 State using file_difc_`year'
	drop _merge
	save file_difc_`year', replace
	
	clear
}

foreach year in "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	import delimited using "C:/dissertation/data/raw/pops20102020.csv"
	keep state popestimate`year'
	rename (state popestimate`year') (State state_pop)
	
	merge m:1 State using file_difc_`year'
	drop _merge
	save file_difc_`year', replace
	
	clear
}

use file_difc_2000
save file_difcgroups, replace
set seed 12345
generate rannum = uniform()
egen group1 = cut(rannum), group(4)
replace group1 = 0 if State == "Colorado" | State == "Washington"
replace group1 = 1 if State == "Alaska" | State == "Oregon" | State == "DC"
replace group1 = 2 if State == "California" | State == "Maine" | State == "Massachusetts" | State == "Nevada"
replace group1 = 3 if State == "Michigan" | State == "Vermont"
egen group2 = cut(rannum), group(3)
replace group2 = 0 if State == "Colorado" | State == "Washington"
replace group2 = 1 if State == "Alaska" | State == "Oregon" | State == "DC"
replace group2 = 2 if State == "California" | State == "Maine" | State == "Massachusetts" | State == "Nevada"
keep State fips group1 group2
save file_difcgroups, replace

clear

foreach year in "1994" "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	use file_difc_`year'
	merge m:1 State using file_difcgroups
	drop _merge
	save file_difc_`year', replace
	
	clear
}

use file_difc_1994
save file_difc_all, replace
foreach year in "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	append using file_difc_`year', force
	save file_difc_all, replace
}

gen treatment = 1 if State == "Alaska" | State == "California" | State == "Colorado" | State == "DC" | State == "Maine" | State == "Massachusetts" | State == "Michigan" | State == "Nevada" | State == "Oregon" | State == "Vermont" | State == "Washington"
replace treatment = 0 if State == "Idaho" | State == "Indiana" | State == "Iowa" | State == "Kansas" | State == "Kentucky" | State == "SouthCarolina" | State == "Tennessee" | State == "Texas" | State == "Wyoming"

gen prepost1 = 1 if year >= 2012 & group1 == 0
replace prepost1 = 1 if year >= 2014 & group1 == 1
replace prepost1 = 1 if year >= 2016 & group1 == 2
replace prepost1 = 1 if year >= 2018 & group1 == 3
replace prepost1 = 0 if prepost1 != 1

gen period0_1 = 1 if year == 2012 & group1 == 0
replace period0_1 = 1 if year == 2014 & group1 == 1
replace period0_1 = 1 if year == 2016 & group1 == 2
replace period0_1 = 1 if year == 2018 & group1 == 3
replace period0_1 = 0 if period0_1 != 1

gen period1_1 = 1 if year == 2013 & group1 == 0
replace period1_1 = 1 if year == 2015 & group1 == 1
replace period1_1 = 1 if year == 2017 & group1 == 2
replace period1_1 = 1 if year == 2019 & group1 == 3
replace period1_1 = 0 if period1_1 != 1

gen prepost2 = 1 if year >= 2012 & group2 == 0
replace prepost2 = 1 if year >= 2014 & group2 == 1
replace prepost2 = 1 if year >= 2016 & group2 == 2
replace prepost2 = 0 if prepost2 != 1

foreach prd in "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	gen period_`prd'_1 = 1 if year == (2012 - `prd') & group1 == 0
	replace period_`prd'_1 = 1 if year == (2014 - `prd') & group1 == 1
	replace period_`prd'_1 = 1 if year == (2016 - `prd') & group1 == 2
	replace period_`prd'_1 = 1 if year == (2018 - `prd') & group1 == 3
	replace period_`prd'_1 = 0 if period_`prd'_1 != 1
}

gen period0_2 = 1 if year == 2012 & group1 == 0
replace period0_2 = 1 if year == 2014 & group1 == 1
replace period0_2 = 1 if year == 2016 & group1 == 2
replace period0_2 = 1 if year == 2018 & group1 == 3
replace period0_2 = 0 if period0_2 != 1

gen period1_2 = 1 if year == 2013 & group1 == 0
replace period1_2 = 1 if year == 2015 & group1 == 1
replace period1_2 = 1 if year == 2017 & group1 == 2
replace period1_2 = 1 if year == 2019 & group1 == 3
replace period1_2 = 0 if period1_2 != 1

gen period2 = 1 if year == 2014 & group2 == 0
replace period2 = 1 if year == 2016 & group2 == 1
replace period2 = 1 if year == 2018 & group2 == 2
replace period2 = 0 if period2 != 1

gen period3 = 1 if year == 2015 & group2 == 0
replace period3 = 1 if year == 2017 & group2 == 1
replace period3 = 1 if year == 2019 & group2 == 2
replace period3 = 0 if period3 != 1

foreach prd in "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	gen period_`prd'_2 = 1 if year == (2012 - `prd') & group2 == 0
	replace period_`prd'_2 = 1 if year == (2014 - `prd') & group2 == 1
	replace period_`prd'_2 = 1 if year == (2016 - `prd') & group2 == 2
	replace period_`prd'_2 = 0 if period_`prd'_2 != 1
}

gen difcpc = Number / state_pop
gen difc000 = difcpc * 1000
save file_difc_all, replace

tsset fips year

xtreg difc000 period_18_1 period_17_1 period_16_1 period_15_1 period_14_1 period_13_1 period_12_1 period_11_1 period_10_1 period_9_1 period_8_1 period_7_1 period_6_1 period_5_1 period_4_1 period_3_1 period_2_1 period_1_1 period0_1 period1_1 if treatment == 1, fe
regsave using ptrends_treat1_difc, replace

xtreg difc000 period_18_1 period_17_1 period_16_1 period_15_1 period_14_1 period_13_1 period_12_1 period_11_1 period_10_1 period_9_1 period_8_1 period_7_1 period_6_1 period_5_1 period_4_1 period_3_1 period_2_1 period_1_1 period0_1 period1_1 if treatment == 0, fe
regsave using ptrends_control1_difc, replace

clear
use ptrends_treat1_difc
gen cons = 0.15570587
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_treatment1_difc, replace

clear
use ptrends_control1_difc
gen cons = 0.23107453
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_treatment1_difc
drop _merge
save file_difcptrends1, replace

foreach prd in "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'_1"
}
replace period = "0" if period == "period0_1"
replace period = "1" if period == "period1_1"
destring, replace
save file_difcptrends1, replace

tsset period, year
scatter treatment control period, connect(l l)

clear

use file_difc_all
drop if State == "Michigan" | State == "Vermont"
tsset fips year

xtreg difc000 period_18_2 period_17_2 period_16_2 period_15_2 period_14_2 period_13_2 period_12_2 period_11_2 period_10_2 period_9_2 period_8_2 period_7_2 period_6_2 period_5_2 period_4_2 period_3_2 period_2_2 period_1_2 period0_2 period1_2 period2 period3 if treatment == 1, fe
regsave using ptrends_treat2_difc, replace

xtreg difc000 period_18_2 period_17_2 period_16_2 period_15_2 period_14_2 period_13_2 period_12_2 period_11_2 period_10_2 period_9_2 period_8_2 period_7_2 period_6_2 period_5_2 period_4_2 period_3_2 period_2_2 period_1_2 period0_2 period1_2 period2 period3 if treatment == 0, fe
regsave using ptrends_control2_difc, replace

clear
use ptrends_treat2_difc
gen cons = 0.15678149
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_treatment2_difc, replace

clear
use ptrends_control2_difc
gen cons = 0.2318617
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_treatment2_difc
drop _merge
save file_difcptrends2, replace

foreach prd in "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'_2"
}
foreach prd in "0" "1" {
	replace period = "`prd'" if period == "period`prd'_2"
}
foreach prd in "2" "3" {
	replace period = "`prd'" if period == "period`prd'"
}
destring, replace
save file_difcptrends2, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
scatter treatment control period, connect(l l)
*edits*
graph export "C:/dissertation/misc/difcgraph.pdf"

*******************

*high BAC*

clear

foreach yr in "1994" "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	import delimited using "C:/dissertation/data/raw/newdatafortab/newdata/Drivers_Involved_Fatal/Drivers_Involved_Fatal_`yr'.txt"
	drop in 1/2
	keep v1 v6
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	gen year = `yr'
	drop if State == "USA"
	replace State = "DC" if State == "District of Columbia"
	replace State = "NewHampshire" if State == "New Hampshire"
	replace State = "NewJersey" if State == "New Jersey"
	replace State = "NewMexico" if State == "New Mexico"
	replace State = "NewYork" if State == "New York"
	replace State = "NorthCarolina" if State == "North Carolina"
	replace State = "NorthDakota" if State == "North Dakota"
	replace State = "RhodeIsland" if State == "Rhode Island"
	replace State = "SouthCarolina" if State == "South Carolina"
	replace State = "SouthDakota" if State == "South Dakota"
	replace State = "WestVirginia" if State == "West Virginia"
	save file_dbac_`yr', replace
	
	clear
}

foreach year in "1994" "1995" "1996" "1997" "1998" "1999" {
	import excel using "C:/dissertation/data/raw/pops19901999.xlsx"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	rename Geography State
	keep State July1`year'Estimate
	rename July1`year'Estimate state_pop
	drop if State == "USA"
	
	merge m:1 State using file_dbac_`year'
	drop _merge
	save file_dbac_`year', replace
	
	clear
}

foreach year in "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" {
	import delimited using "C:/dissertation/data/raw/pops20002009.csv"
	rename state fips
	rename name State
	drop if State == "UnitedStates"
	drop if sex != 0
	drop if age != 0
	keep fips State
	
	merge m:1 State using file_dbac_`year'
	drop _merge
	save file_dbac_`year', replace
	
	clear
	
	import excel using "C:/dissertation/data/raw/statepops0009.xls"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	rename state State
	replace State = "DC" if State == "DistrictofColumbia"
	keep State y`year'
	rename y`year' state_pop
	
	merge m:1 State using file_dbac_`year'
	drop _merge
	save file_dbac_`year', replace
	
	clear
}

foreach year in "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	import delimited using "C:/dissertation/data/raw/pops20102020.csv"
	keep state popestimate`year'
	rename (state popestimate`year') (State state_pop)
	
	merge m:1 State using file_dbac_`year'
	drop _merge
	save file_dbac_`year', replace
	
	clear
}

use file_dbac_2000
save file_dbacgroups, replace
set seed 12345
generate rannum = uniform()
egen group1 = cut(rannum), group(4)
replace group1 = 0 if State == "Colorado" | State == "Washington"
replace group1 = 1 if State == "Alaska" | State == "Oregon" | State == "DC"
replace group1 = 2 if State == "California" | State == "Maine" | State == "Massachusetts" | State == "Nevada"
replace group1 = 3 if State == "Michigan" | State == "Vermont"
egen group2 = cut(rannum), group(3)
replace group2 = 0 if State == "Colorado" | State == "Washington"
replace group2 = 1 if State == "Alaska" | State == "Oregon" | State == "DC"
replace group2 = 2 if State == "California" | State == "Maine" | State == "Massachusetts" | State == "Nevada"
keep State fips group1 group2
save file_dbacgroups, replace

clear

foreach year in "1994" "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	use file_dbac_`year'
	merge m:1 State using file_dbacgroups
	drop _merge
	save file_dbac_`year', replace
	
	clear
}

use file_dbac_1994
save file_dbac_all, replace
foreach year in "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	append using file_dbac_`year', force
	save file_dbac_all, replace
}

gen treatment = 1 if State == "Alaska" | State == "California" | State == "Colorado" | State == "DC" | State == "Maine" | State == "Massachusetts" | State == "Michigan" | State == "Nevada" | State == "Oregon" | State == "Vermont" | State == "Washington"
replace treatment = 0 if State == "Idaho" | State == "Indiana" | State == "Iowa" | State == "Kansas" | State == "Kentucky" | State == "SouthCarolina" | State == "Tennessee" | State == "Texas" | State == "Wyoming"

gen prepost1 = 1 if year >= 2012 & group1 == 0
replace prepost1 = 1 if year >= 2014 & group1 == 1
replace prepost1 = 1 if year >= 2016 & group1 == 2
replace prepost1 = 1 if year >= 2018 & group1 == 3
replace prepost1 = 0 if prepost1 != 1

gen period0_1 = 1 if year == 2012 & group1 == 0
replace period0_1 = 1 if year == 2014 & group1 == 1
replace period0_1 = 1 if year == 2016 & group1 == 2
replace period0_1 = 1 if year == 2018 & group1 == 3
replace period0_1 = 0 if period0_1 != 1

gen period1_1 = 1 if year == 2013 & group1 == 0
replace period1_1 = 1 if year == 2015 & group1 == 1
replace period1_1 = 1 if year == 2017 & group1 == 2
replace period1_1 = 1 if year == 2019 & group1 == 3
replace period1_1 = 0 if period1_1 != 1

gen prepost2 = 1 if year >= 2012 & group2 == 0
replace prepost2 = 1 if year >= 2014 & group2 == 1
replace prepost2 = 1 if year >= 2016 & group2 == 2
replace prepost2 = 0 if prepost2 != 1

foreach prd in "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	gen period_`prd'_1 = 1 if year == (2012 - `prd') & group1 == 0
	replace period_`prd'_1 = 1 if year == (2014 - `prd') & group1 == 1
	replace period_`prd'_1 = 1 if year == (2016 - `prd') & group1 == 2
	replace period_`prd'_1 = 1 if year == (2018 - `prd') & group1 == 3
	replace period_`prd'_1 = 0 if period_`prd'_1 != 1
}

gen period0_2 = 1 if year == 2012 & group1 == 0
replace period0_2 = 1 if year == 2014 & group1 == 1
replace period0_2 = 1 if year == 2016 & group1 == 2
replace period0_2 = 1 if year == 2018 & group1 == 3
replace period0_2 = 0 if period0_2 != 1

gen period1_2 = 1 if year == 2013 & group1 == 0
replace period1_2 = 1 if year == 2015 & group1 == 1
replace period1_2 = 1 if year == 2017 & group1 == 2
replace period1_2 = 1 if year == 2019 & group1 == 3
replace period1_2 = 0 if period1_2 != 1

gen period2 = 1 if year == 2014 & group2 == 0
replace period2 = 1 if year == 2016 & group2 == 1
replace period2 = 1 if year == 2018 & group2 == 2
replace period2 = 0 if period2 != 1

gen period3 = 1 if year == 2015 & group2 == 0
replace period3 = 1 if year == 2017 & group2 == 1
replace period3 = 1 if year == 2019 & group2 == 2
replace period3 = 0 if period3 != 1

foreach prd in "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	gen period_`prd'_2 = 1 if year == (2012 - `prd') & group2 == 0
	replace period_`prd'_2 = 1 if year == (2014 - `prd') & group2 == 1
	replace period_`prd'_2 = 1 if year == (2016 - `prd') & group2 == 2
	replace period_`prd'_2 = 0 if period_`prd'_2 != 1
}

gen dbacpc = Number / state_pop
gen dbac000 = dbacpc * 1000
save file_dbac_all, replace

drop if State == "Michigan" | State == "Vermont"
tsset fips year

xtreg dbac000 period_18_2 period_17_2 period_16_2 period_15_2 period_14_2 period_13_2 period_12_2 period_11_2 period_10_2 period_9_2 period_8_2 period_7_2 period_6_2 period_5_2 period_4_2 period_3_2 period_2_2 period_1_2 period0_2 period1_2 period2 period3 if treatment == 1, fe
regsave using ptrends_treat2_dbac, replace

xtreg dbac000 period_18_2 period_17_2 period_16_2 period_15_2 period_14_2 period_13_2 period_12_2 period_11_2 period_10_2 period_9_2 period_8_2 period_7_2 period_6_2 period_5_2 period_4_2 period_3_2 period_2_2 period_1_2 period0_2 period1_2 period2 period3 if treatment == 0, fe
regsave using ptrends_control2_dbac, replace

clear
use ptrends_treat2_dbac
gen cons = 0.03538213
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_treatment2_dbac, replace

clear
use ptrends_control2_dbac
gen cons = 0.0476999
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_treatment2_dbac
drop _merge
save file_dbacptrends2, replace

foreach prd in "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'_2"
}
foreach prd in "0" "1" {
	replace period = "`prd'" if period == "period`prd'_2"
}
foreach prd in "2" "3" {
	replace period = "`prd'" if period == "period`prd'"
}
destring, replace
save file_dbacptrends2, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
scatter treatment control period, connect(l l)
*edits*
graph export "C:/dissertation/misc/dbacgraph.pdf"

********************

*all persons*

clear

foreach yr in "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	import delimited using "C:/dissertation/data/raw/newdatafortab/newdata/Persons_Killed/Persons_Killed_`yr'.txt"
	drop in 1/2
	keep v1 v6
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	gen year = `yr'
	drop if State == "USA"
	replace State = "DC" if State == "District of Columbia"
	replace State = "NewHampshire" if State == "New Hampshire"
	replace State = "NewJersey" if State == "New Jersey"
	replace State = "NewMexico" if State == "New Mexico"
	replace State = "NewYork" if State == "New York"
	replace State = "NorthCarolina" if State == "North Carolina"
	replace State = "NorthDakota" if State == "North Dakota"
	replace State = "RhodeIsland" if State == "Rhode Island"
	replace State = "SouthCarolina" if State == "South Carolina"
	replace State = "SouthDakota" if State == "South Dakota"
	replace State = "WestVirginia" if State == "West Virginia"
	save file_pbac_`yr', replace
	
	clear
}

import excel using "C:/dissertation/data/raw/pops19901999.xlsx"
foreach var of varlist * {
	rename `var' `=`var'[1]'
}
drop in 1
destring, replace
rename Geography State
keep State July11999Estimate
rename July11999Estimate state_pop
drop if State == "USA"

merge m:1 State using file_pbac_1999
drop _merge
save file_pbac_1999, replace

clear


foreach year in "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" {
	import delimited using "C:/dissertation/data/raw/pops20002009.csv"
	rename state fips
	rename name State
	drop if State == "UnitedStates"
	drop if sex != 0
	drop if age != 0
	keep fips State
	
	merge m:1 State using file_pbac_`year'
	drop _merge
	save file_pbac_`year', replace
	
	clear
	
	import excel using "C:/dissertation/data/raw/statepops0009.xls"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	rename state State
	replace State = "DC" if State == "DistrictofColumbia"
	keep State y`year'
	rename y`year' state_pop
	
	merge m:1 State using file_pbac_`year'
	drop _merge
	save file_pbac_`year', replace
	
	clear
}

foreach year in "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	import delimited using "C:/dissertation/data/raw/pops20102020.csv"
	keep state popestimate`year'
	rename (state popestimate`year') (State state_pop)
	
	merge m:1 State using file_pbac_`year'
	drop _merge
	save file_pbac_`year', replace
	
	clear
}

use file_pbac_2000
save file_pbacgroups, replace
set seed 12345
generate rannum = uniform()
egen group1 = cut(rannum), group(4)
replace group1 = 0 if State == "Colorado" | State == "Washington"
replace group1 = 1 if State == "Alaska" | State == "Oregon" | State == "DC"
replace group1 = 2 if State == "California" | State == "Maine" | State == "Massachusetts" | State == "Nevada"
replace group1 = 3 if State == "Michigan" | State == "Vermont"
egen group2 = cut(rannum), group(3)
replace group2 = 0 if State == "Colorado" | State == "Washington"
replace group2 = 1 if State == "Alaska" | State == "Oregon" | State == "DC"
replace group2 = 2 if State == "California" | State == "Maine" | State == "Massachusetts" | State == "Nevada"
keep State fips group1 group2
save file_pbacgroups, replace

clear

foreach year in "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	use file_pbac_`year'
	merge m:1 State using file_pbacgroups
	drop _merge
	save file_pbac_`year', replace
	
	clear
}

use file_pbac_1999
save file_pbac_all, replace
foreach year in "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	append using file_pbac_`year', force
	save file_pbac_all, replace
}

gen treatment = 1 if State == "Alaska" | State == "California" | State == "Colorado" | State == "DC" | State == "Maine" | State == "Massachusetts" | State == "Michigan" | State == "Nevada" | State == "Oregon" | State == "Vermont" | State == "Washington"
replace treatment = 0 if State == "Idaho" | State == "Indiana" | State == "Iowa" | State == "Kansas" | State == "Kentucky" | State == "SouthCarolina" | State == "Tennessee" | State == "Texas" | State == "Wyoming"

gen prepost1 = 1 if year >= 2012 & group1 == 0
replace prepost1 = 1 if year >= 2014 & group1 == 1
replace prepost1 = 1 if year >= 2016 & group1 == 2
replace prepost1 = 1 if year >= 2018 & group1 == 3
replace prepost1 = 0 if prepost1 != 1

gen period0_1 = 1 if year == 2012 & group1 == 0
replace period0_1 = 1 if year == 2014 & group1 == 1
replace period0_1 = 1 if year == 2016 & group1 == 2
replace period0_1 = 1 if year == 2018 & group1 == 3
replace period0_1 = 0 if period0_1 != 1

gen period1_1 = 1 if year == 2013 & group1 == 0
replace period1_1 = 1 if year == 2015 & group1 == 1
replace period1_1 = 1 if year == 2017 & group1 == 2
replace period1_1 = 1 if year == 2019 & group1 == 3
replace period1_1 = 0 if period1_1 != 1

gen prepost2 = 1 if year >= 2012 & group2 == 0
replace prepost2 = 1 if year >= 2014 & group2 == 1
replace prepost2 = 1 if year >= 2016 & group2 == 2
replace prepost2 = 0 if prepost2 != 1

foreach prd in "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	gen period_`prd'_1 = 1 if year == (2012 - `prd') & group1 == 0
	replace period_`prd'_1 = 1 if year == (2014 - `prd') & group1 == 1
	replace period_`prd'_1 = 1 if year == (2016 - `prd') & group1 == 2
	replace period_`prd'_1 = 1 if year == (2018 - `prd') & group1 == 3
	replace period_`prd'_1 = 0 if period_`prd'_1 != 1
}

gen period0_2 = 1 if year == 2012 & group1 == 0
replace period0_2 = 1 if year == 2014 & group1 == 1
replace period0_2 = 1 if year == 2016 & group1 == 2
replace period0_2 = 1 if year == 2018 & group1 == 3
replace period0_2 = 0 if period0_2 != 1

gen period1_2 = 1 if year == 2013 & group1 == 0
replace period1_2 = 1 if year == 2015 & group1 == 1
replace period1_2 = 1 if year == 2017 & group1 == 2
replace period1_2 = 1 if year == 2019 & group1 == 3
replace period1_2 = 0 if period1_2 != 1

gen period2 = 1 if year == 2014 & group2 == 0
replace period2 = 1 if year == 2016 & group2 == 1
replace period2 = 1 if year == 2018 & group2 == 2
replace period2 = 0 if period2 != 1

gen period3 = 1 if year == 2015 & group2 == 0
replace period3 = 1 if year == 2017 & group2 == 1
replace period3 = 1 if year == 2019 & group2 == 2
replace period3 = 0 if period3 != 1

foreach prd in "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	gen period_`prd'_2 = 1 if year == (2012 - `prd') & group2 == 0
	replace period_`prd'_2 = 1 if year == (2014 - `prd') & group2 == 1
	replace period_`prd'_2 = 1 if year == (2016 - `prd') & group2 == 2
	replace period_`prd'_2 = 0 if period_`prd'_2 != 1
}

gen pbacpc = Number / state_pop
gen pbac000 = pbacpc * 1000
save file_pbac_all, replace

drop if State == "Michigan" | State == "Vermont"
tsset fips year

xtreg pbac000 period_13_2 period_12_2 period_11_2 period_10_2 period_9_2 period_8_2 period_7_2 period_6_2 period_5_2 period_4_2 period_3_2 period_2_2 period_1_2 period0_2 period1_2 period2 period3 if treatment == 1, fe
regsave using ptrends_treat2_pbac, replace

xtreg pbac000 period_13_2 period_12_2 period_11_2 period_10_2 period_9_2 period_8_2 period_7_2 period_6_2 period_5_2 period_4_2 period_3_2 period_2_2 period_1_2 period0_2 period1_2 period2 period3 if treatment == 0, fe
regsave using ptrends_control2_pbac, replace

clear
use ptrends_treat2_pbac
gen cons = 0.03388757
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_treatment2_pbac, replace

clear
use ptrends_control2_pbac
gen cons = 0.04951814
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_treatment2_pbac
drop _merge
save file_pbacptrends2, replace

foreach prd in "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'_2"
}
foreach prd in "0" "1" {
	replace period = "`prd'" if period == "period`prd'_2"
}
foreach prd in "2" "3" {
	replace period = "`prd'" if period == "period`prd'"
}
destring, replace
save file_dbacptrends2, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
scatter treatment control period, connect(l l)
*edits*
graph export "C:/dissertation/misc/pbacgraph.pdf"

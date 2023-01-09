*double check directory*

clear

foreach state in "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "DC" "Delaware" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
	foreach year in "1994" "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
		import delimited using "C:/dissertation/data/raw/datafortab/`state'/`state'_`year'.txt"
		drop in 1/2
		drop v5-v11
		replace v3 = "AlcoholRelated" if v3 == "Alcohol--Related"
		replace v4 = "PercentAlcoholRelated" if v4 == "Percent Alcohol--Related"
		foreach var of varlist * {
			rename `var' `=`var'[1]'
		}
		drop in 1
		replace Number = "." if Number == "NA"
		replace AlcoholRelated = "." if AlcoholRelated == "NA"
		replace PercentAlcoholRelated = "." if PercentAlcoholRelated == "NA"
		destring, replace
		gen state = "`state'"
		gen year = `year'
		keep if FieldDesc == "Total"
		save file_`state'`year', replace
		
		clear
	}
}

foreach year in "1994" "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	use file_Alabama`year'
	save file_sva`year', replace
	foreach state in "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "DC" "Delaware" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
		append using file_`state'`year'
		save file_sva`year', replace
	}
	clear
}

foreach year in "1994" "1995" "1996" "1997" "1998" "1999" {
	import excel using "C:/dissertation/data/raw/pops19901999.xlsx"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	rename Geography state
	keep state July1`year'Estimate
	rename July1`year'Estimate state_pop
	drop if state == "USA"
	
	merge m:1 state using file_sva`year'
	drop _merge
	save file_sva`year', replace
	
	clear
}

foreach year in "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" {
	import delimited using "C:/dissertation/data/raw/pops20002009.csv"
	rename state fips
	rename name state
	drop if state == "UnitedStates"
	drop if sex != 0
	drop if age != 0
	keep fips state
	
	merge m:1 state using file_sva`year'
	drop _merge
	save file_sva`year', replace
	
	clear
	
	import excel using "C:/dissertation/data/raw/statepops0009.xls"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	destring, replace
	replace state = "DC" if state == "DistrictofColumbia"
	keep state y`year'
	rename y`year' state_pop
	
	merge m:1 state using file_sva`year'
	drop _merge
	save file_sva`year', replace
	
	clear
}

foreach year in "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	import delimited using "C:/dissertation/data/raw/pops20102020.csv"
	keep state popestimate`year'
	rename popestimate`year' state_pop
	
	merge m:1 state using file_sva`year'
	drop _merge
	save file_sva`year', replace
	
	clear
}

use file_sva2000
save file_svagroups, replace
set seed 12345
generate rannum = uniform()
egen group1 = cut(rannum), group(4)
replace group1 = 0 if state == "Colorado" | state == "Washington"
replace group1 = 1 if state == "Alaska" | state == "Oregon" | state == "DC"
replace group1 = 2 if state == "California" | state == "Maine" | state == "Massachusetts" | state == "Nevada"
replace group1 = 3 if state == "Michigan" | state == "Vermont"
egen group2 = cut(rannum), group(3)
replace group2 = 0 if state == "Colorado" | state == "Washington"
replace group2 = 1 if state == "Alaska" | state == "Oregon" | state == "DC"
replace group2 = 2 if state == "California" | state == "Maine" | state == "Massachusetts" | state == "Nevada"
keep state fips group1 group2
save file_svagroups, replace

clear

foreach year in "1994" "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	use file_sva`year'
	merge m:1 state using file_svagroups
	drop _merge
	save file_sva`year', replace
	
	clear
}

use file_sva1994
save file_svaall, replace
foreach year in "1995" "1996" "1997" "1998" "1999" "2000" "2001" "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018" "2019" {
	append using file_sva`year'
	save file_svaall, replace
}

gen treatment = 1 if state == "Alaska" | state == "California" | state == "Colorado" | state == "DC" | state == "Maine" | state == "Massachusetts" | state == "Michigan" | state == "Nevada" | state == "Oregon" | state == "Vermont" | state == "Washington"
replace treatment = 0 if state == "Idaho" | state == "Indiana" | state == "Iowa" | state == "Kansas" | state == "Kentucky" | state == "SouthCarolina" | state == "Tennessee" | state == "Texas" | state == "Wyoming"

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

gen svapc = AlcoholRelated / state_pop
gen sva000 = svapc * 1000
save file_svaall, replace

tsset fips year

xtreg sva000 period_18_1 period_17_1 period_16_1 period_15_1 period_14_1 period_13_1 period_12_1 period_11_1 period_10_1 period_9_1 period_8_1 period_7_1 period_6_1 period_5_1 period_4_1 period_3_1 period_2_1 period_1_1 period0_1 period1_1 if treatment == 1, fe
regsave using ptrends_treat1

xtreg sva000 period_18_1 period_17_1 period_16_1 period_15_1 period_14_1 period_13_1 period_12_1 period_11_1 period_10_1 period_9_1 period_8_1 period_7_1 period_6_1 period_5_1 period_4_1 period_3_1 period_2_1 period_1_1 period0_1 period1_1 if treatment == 0, fe
regsave using ptrends_control1, replace

clear
use ptrends_treat1
gen cons = 0.02259987
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_treatment1, replace

clear
use ptrends_control1
gen cons = 0.03148862
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_treatment1
drop _merge
save file_svaptrends1, replace

foreach prd in "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'_1"
}
replace period = "0" if period == "period0_1"
replace period = "1" if period == "period1_1"
destring, replace
save file_svaptrends1, replace

keep if period >= -2

scatter treatment control period, connect(l l)

clear

use file_svaall
drop if state == "Michigan" | state == "Vermont"
tsset fips year

xtreg sva000 period_18_2 period_17_2 period_16_2 period_15_2 period_14_2 period_13_2 period_12_2 period_11_2 period_10_2 period_9_2 period_8_2 period_7_2 period_6_2 period_5_2 period_4_2 period_3_2 period_2_2 period_1_2 period0_2 period1_2 period2 period3 if treatment == 1, fe
regsave using ptrends_treat2, replace

xtreg sva000 period_18_2 period_17_2 period_16_2 period_15_2 period_14_2 period_13_2 period_12_2 period_11_2 period_10_2 period_9_2 period_8_2 period_7_2 period_6_2 period_5_2 period_4_2 period_3_2 period_2_2 period_1_2 period0_2 period1_2 period2 period3 if treatment == 0, fe
regsave using ptrends_control2, replace

clear
use ptrends_treat2
gen cons = 0.02256278
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_treatment2, replace

clear
use ptrends_control2
gen cons = 0.03188136
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_treatment2
drop _merge
save file_svaptrends2, replace

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
save file_svaptrends2, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
scatter treatment control period, connect(l l)
*do some editing*
graph export "C:/dissertation/misc/fsvcgraph.pdf"
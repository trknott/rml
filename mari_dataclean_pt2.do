* check directory *

* drug-impaired traffic fatalities *

clear

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" {
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen cannabinoid = 1 if inrange(drugres1, 600, 695) | inrange(drugres2, 600, 695) | inrange(drugres3, 600, 695)
	gen otherdrugs = 1 if (inrange(drugres1, 100, 996) & cannabinoid != 1) | (inrange(drugres2, 100, 996) & cannabinoid != 1) | (inrange(drugres3, 100, 996) & cannabinoid != 1)
	collapse (sum) cannabinoid otherdrugs, by(state)
	rename state fips
	save file_drugs_`yr', replace
	merge m:1 fips using file_mari_`yr'
	drop _merge
	save file_mari2_`yr', replace
	
	clear
}

foreach yr in "18" "19" {
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Drugs.csv"
	gen cannabinoid = 1 if inrange(drugres, 600, 695)
	gen otherdrugs = 1 if inrange(drugres, 100, 996) & cannabinoid != 1
	collapse (sum) cannabinoid otherdrugs, by(state)
	rename state fips
	save file_drugs_`yr', replace
	merge m:1 fips using file_mari_`yr'
	drop _merge
	save file_mari2_`yr', replace
	
	clear
}

*****************

* updating some controls *

clear

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" {
	foreach state in "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "DC" "Delaware" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
		clear
		
		import excel using "C:/dissertation/data/raw/stateincome/rpcinc_all.xlsx"
		foreach var of varlist * {
			rename `var' `=`var'[1]'
		}
		drop in 1 
		destring, replace
		keep year `state'
		keep if year == 20`yr'
		rename `state' rpc_income
		gen State = "`state'"
		save file_`state'income_`yr', replace
	}
	
	clear
	
	use file_Alabamaincome_`yr'
	save file_income_`yr', replace
	foreach state in "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "DC" "Delaware" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
		append using file_`state'income_`yr'
		save file_income_`yr', replace
	}
	
	clear
	
	use file_income_`yr'
	merge m:1 State using file_mari2_`yr'
	drop _merge
	save file_mari2_`yr', replace
	
	clear
}

import excel using "C:/dissertation/data/raw/statemiles/table_05-03.xlsx"
drop in 1/2
keep A B 
drop in 53/62
foreach var of varlist * {
	rename `var' `=`var'[1]'
}
drop in 1 
destring, replace
rename TotalVMT1millions vehmiles
merge m:1 State using file_mari2_06
drop _merge
save file_mari2_06, replace

clear

*****************

* putting it all together *

clear

use file_mari2_00
save file_marijuana2_0019, replace
foreach yr in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	append using file_mari2_`yr'
	save file_marijuana2_0019, replace
}
gen vehmiles_pc = vehmiles / state_pop
foreach thing in "01" "08" "10" {
	gen fbac`thing'_pc = fbac`thing' / state_pop
	gen fbac`thing'_hunthou = fbac`thing'_pc * 100000
}
gen rml_treat = 1 if State == "Alaska" | State == "California" | State == "Colorado" | State == "DC" | State == "Maine" | State == "Massachusetts" | State == "Michigan" | State == "Nevada" | State == "Oregon" | State == "Vermont" | State == "Washington"
replace rml_treat = 0 if rml_treat == .
gen rml_prepost = 1 if rml_group == 0 & year >= 2012
replace rml_prepost = 1 if rml_group == 1 & year >= 2014
replace rml_prepost = 1 if rml_group == 2 & year >= 2016
replace rml_prepost = 1 if rml_group == 3 & year >= 2018
replace rml_prepost = 0 if rml_prepost == . & rml_treat != .
gen mml_treat = 1 if (State == "California" & year >= 1996) | (State == "Alaska" & year >= 1998) | (State == "Oregon" & year >= 1998) | (State == "Washington" & year >= 1998) | (State == "Maine" & year >= 1999) | (State == "Hawaii" & year >= 2000) | (State == "Colorado" & year >= 2000) | (State == "Nevada" & year >= 2000) | (State == "Montana" & year >= 2004) | (State == "Vermont" & year >= 2004) | (State == "RhodeIsland" & year >= 2006) | (State == "NewMexico" & year >= 2007) | (State == "Michigan" & year >= 2008) | (State == "NewJersey" & year >= 2010) | (State == "DC" & year >= 2010) | (State == "Arizona" & year >= 2010) | (State == "Delaware" & year >= 2011) | (State == "Connecticut" & year >= 2012) | (State == "Massachusetts" & year >= 2012) | (State == "NewHampshire" & year >= 2013) | (State == "Illinois" & year >= 2013) | (State == "Maryland" & year >= 2014) | (State == "Minnesota" & year >= 2014) | (State == "NewYork" & year >= 2014) | (State == "Pennsylvania" & year >= 2016) | (State == "Ohio" & year >= 2016) | (State == "Arkansas" & year >= 2016) | (State == "Florida" & year >= 2016) | (State == "NorthDakota" & year >= 2016) | (State == "WestVirginia" & year >= 2017) | (State == "Oklahoma" & year >= 2018)
replace mml_treat = 0 if mml_treat == .
gen decrim = 1 if State == "Oregon" & year >= 1973
replace decrim = 1 if (State == "Alaska" & year >= 1975) | (State == "Maine" & year >= 1975) | (State == "Colorado" & year >= 1975) | (State == "California" & year >= 1975) | (State == "Ohio" & year >= 1975)
replace decrim = 1 if State == "Minnesota" & year >= 1976
replace decrim = 1 if (State == "Mississippi" & year >= 1977) | (State == "NewYork" & year >= 1977) | (State == "NorthCarolina" & year >= 1977)
replace decrim = 1 if State == "Nebraska" & year >= 1978
replace decrim = 1 if State == "Nevada" & year >= 2001
replace decrim = 1 if State == "Connecticut" & year >= 2011
replace decrim = 1 if State == "RhodeIsland" & year >= 2012
replace decrim = 1 if State == "Vermont" & year >= 2013
replace decrim = 1 if (State == "Maryland" & year >= 2014) | (State == "Missouri" & year >= 2014)
replace decrim = 1 if State == "Delaware" & year >= 2015
replace decrim = 1 if State == "Illinois" & year >= 2016
replace decrim = 1 if State == "NewHampshire" & year >= 2017
replace decrim = 1 if (State == "NewMexico" & year >= 2019) | (State == "NorthDakota" & year >= 2019) | (State == "Hawaii" & year >= 2019)
replace decrim = 0 if decrim == .
gen bac08_law = 1 if (State == "Alabama" & year >= 1995) | (State == "Arizona" & year >= 2001) | (State == "Arkansas" & year >= 2001) | (State == "California" & year >= 1990) | (State == "Colorado" & year >= 2004) | (State == "Connecticut" & year >= 2002) | (State == "Delaware" & year >= 2004) | (State == "Florida" & year >= 1994) | (State == "Georgia" & year >= 2001) | (State == "Idaho" & year >= 1997) | (State == "Illinois" & year >= 1997) | (State == "Indiana" & year >= 2001) | (State == "Iowa" & year >= 2003) | (State == "Kansas" & year >= 1988) | (State == "Kentucky" & year >= 2000) | (State == "Louisiana" & year >= 2003) | (State == "Maine" & year >= 1988) | (State == "Maryland" & year >= 2001) | (State == "Massachusetts" & year >= 2003) | (State == "Michigan" & year >= 2003) | (State == "Minnesota" & year >= 2005) | (State == "Mississippi" & year >= 2002) | (State == "Missouri" & year >= 2001) | (State == "Montana" & year >= 2003) | (State == "Nebraska" & year >= 2001) | (State == "Nevada" & year >= 2003) | (State == "NewHampshire" & year >= 1994) | (State == "NewJersey" & year >= 2004) | (State == "NewMexico" & year >= 1994) | (State == "NewYork" & year >= 2003) | (State == "NorthCarolina" & year >= 1993) | (State == "NorthDakota" & year >= 2003) | (State == "Ohio" & year >= 2003) | (State == "Oklahoma" & year >= 2001) | (State == "Oregon" & year >= 1983) | (State == "Pennsylvania" & year >= 2003) | (State == "RhodeIsland" & year >= 2003) | (State == "SouthCarolina" & year >= 2003) | (State == "SouthDakota" & year >= 2002) | (State == "Tennessee" & year >= 2003) | (State == "Texas" & year >= 1999) | (State == "Utah" & year >= 1983) | (State == "Vermont" & year >= 1991) | (State == "Virginia" & year >= 1994) | (State == "Washington" & year >= 1999) | (State == "WestVirginia" & year >= 2004) | (State == "Wisconsin" & year >= 2003) | (State == "Wyoming" & year >= 2002) | (State == "DC" & year >= 1999)
replace bac08_law = 0 if bac08_law == .
gen fatal_pc = fatal / state_pop
gen fatal_hunthou = fatal_pc * 100000
gen fatalalc_pc = fatal_alc / state_pop
gen fatalalc_hunthou = fatalalc_pc * 100000
gen vehmiles_hunthou = vehmiles_pc * 100000
gen age_2039 = age_2024 + age_2529 + age_3034 + age_3539
gen inv_age2039 = inv_age2024 + inv_age2529 + inv_age3034 + inv_age3539
gen age_40up = age_4044 + age_4549 + age_5054 + age_5559 + age_6064 + age_6569 + age_7074 + age_7579 + age_8084 + age_85up
gen inv_age40up = inv_age4044 + inv_age4549 + inv_age5054 + inv_age5559 + inv_age6064 + inv_age6569 + inv_age7074 + inv_age7579 + inv_age8084 + inv_age85up
foreach group in "1519" "2039" "40up" {
	gen inv_age`group'_pc = inv_age`group' / age_`group'
	gen inv_age`group'_hunthou = inv_age`group'_pc * 100000
}
foreach thing in "fatal" "fatalalc" {
	gen `thing'_age2039 = `thing'_age2024 + `thing'_age2529 + `thing'_age3034 + `thing'_age3539
	gen `thing'_age40up = `thing'_age4044 + `thing'_age4549 + `thing'_age5054 + `thing'_age5559 + `thing'_age6064 + `thing'_age6569 + `thing'_age7074 + `thing'_age7579 + `thing'_age8084 + `thing'_age85up
	foreach group in "1519" "2039" "40up" {
		gen `thing'_age`group'_pc = `thing'_age`group' / age_`group'
		gen `thing'_age`group'_hunthou = `thing'_age`group'_pc * 100000
	}
}
gen fatal_noalc_pc = fatal_noalc / state_pop
gen fatal_noalc_hunthou = fatal_noalc_pc * 100000
gen fsva_pc = fsva / state_pop
gen fsva_hunthou = fsva_pc * 100000
gen fsvaalc_pc = fsva_alc / state_pop
gen fsvaalc_hunthou = fsvaalc_pc * 100000
gen canna_pc = cannabinoid / state_pop
gen canna_hunthou = canna_pc * 100000
gen otherdrugs_pc = otherdrugs / state_pop
gen otherdrugs_hunthou = otherdrugs_pc * 100000
save file_marijuana2_0019, replace

********************

* some regressions *

reghdfe canna_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe canna_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe otherdrugs_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe otherdrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
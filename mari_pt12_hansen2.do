foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	destring atst_typ, replace
	gen alctested = 1 if atst_typ != 0 & atst_typ != 9 & atst_typ != 95 & atst_typ != 98 & atst_typ != 99
	gen people = 1
	collapse (sum) people alctested, by(state)
	rename state fips
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen drugtested = 1 if (drugtst1 !=0 & drugtst1 != 6 & drugtst1 != 9) | (drugtst2 !=0 & drugtst2 != 6 & drugtst2 != 9) | (drugtst3 !=0 & drugtst3 != 6 & drugtst3 != 9)
	gen people = 1
	collapse (sum) people drugtested, by(state)
	rename state fips
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}
foreach yr in "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Drugs.csv"
	gen drugtested = 1 if drugspec != 0
	gen people = 1
	collapse (sum) people drugtested, by(state)
	rename state fips
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

foreach yr in "00" "01" "02" "03" "04" "05" "07" "08" {
	clear
	
	import excel using "C:/dissertation/data/raw/statemiles/20`yr'.xls"
	drop in 1/6
	drop in 2
	keep A O
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1 
	destring, replace
	rename (STATE TOTAL) (State urbanmiles)
	gen year = 20`yr'
	drop if urbanmiles == .
	drop if State == "U.S. Total" | State == "Puerto Rico" | State == "Grand Total"
	merge m:1 State using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}
foreach yr in "09" "10" "13" {
	clear
	
	import excel using "C:/dissertation/data/raw/statemiles/20`yr'.xls"
	drop in 1/6
	drop in 2
	keep A Q
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1 
	destring, replace
	rename (STATE TOTAL) (State urbanmiles)
	gen year = 20`yr'
	drop if urbanmiles == .
	drop if State == "U.S. Total" | State == "Puerto Rico" | State == "Grand Total" | State == "Puerot Rico  (2)"
	merge m:1 State using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}
foreach yr in "11" "12" "14" "15" "16" "17" "18" "19" {
	clear
	
	import excel using "C:/dissertation/data/raw/statemiles/misc_years_urban.xlsx", sheet(20`yr')
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1 
	destring, replace
	gen year = 20`yr'
	merge m:1 State using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

clear
use file_mari3_00
save file_marijuana3_0019, replace
foreach yr in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	append using file_mari3_`yr'
	save file_marijuana3_0019, replace
}
drop bac01_result bac08_result bac10_result fbac01 fbac08 fbac10 inv_age85up fatal_age85up fatalalc_age85up inv_age8084 fatal_age8084 fatalalc_age8084 inv_age7579 fatal_age7579 fatalalc_age7579 inv_age7074 fatal_age7074 fatalalc_age7074 inv_age6569 fatal_age6569 fatalalc_age6569 inv_age6064 fatal_age6064 fatalalc_age6064 inv_age5559 fatal_age5559 fatalalc_age5559 inv_age5054 fatal_age5054 fatalalc_age5054 inv_age4549 fatal_age4549 fatalalc_age4549 inv_age4044 fatal_age4044 fatalalc_age4044 inv_age3539 fatal_age3539 fatalalc_age3539 inv_age3034 fatal_age3034 fatalalc_age3034 inv_age2529 fatal_age2529 fatalalc_age2529 inv_age2024 fatal_age2024 fatalalc_age2024 inv_age1519 fatal_age1519 fatalalc_age1519 fatal fatal fatal_alc fatal_noalc FieldDesc Number AlcoholRelated PercentAlcoholRelated group1 group2 noalc
rename fatals fatalsdd
save file_marijuana3_0019, replace

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
save file_marijuana3_0019, replace

gen fatalsdd_pc = fatalsdd / state_pop
gen fatalsdd_hunthou = fatalsdd_pc * 100000
gen fatalsodrugs_pc = fatalsodrugs / state_pop
gen fatalsodrugs_hunthou = fatalsodrugs_pc * 100000
gen fatalscann_pc = fatalscann / state_pop
gen fatalscann_hunthou = fatalscann_pc * 100000
gen fatalsnodd_pc = fatalsnondd / state_pop
gen fatalsnodd_hunthou = fatalsnodd_pc * 100000
gen fatalsbac0107_pc = dd_bac0107 / state_pop
gen fatalsbac0107_hunthou = fatalsbac0107_pc * 100000
gen fatalsbac08_pc = dd_bac08 / state_pop
gen fatalsbac08_hunthou = fatalsbac08_pc * 100000
gen fatalsbac10_pc = dd_bac10 / state_pop
gen fatalsbac10_hunthou = fatalsbac10_pc * 100000
gen ddage_2039 = ddage_2024 + ddage_2529 + ddage_3034 + ddage_3539
gen pop_age2039 = age_2024 + age_2529 + age_3034 + age_3539
gen pop_age40up = age_4044 + age_4549 + age_5054 + age_5559 + age_6064 + age_6569 + age_7074 + age_7579 + age_8084 + age_85up
gen fatals1519_pc = ddage_1519 / age_1519
gen fatals1519_hunthou = fatals1519_pc * 100000
gen fatals2024_pc = ddage_2024 / age_2024
gen fatals2024_hunthou = fatals2024_pc * 100000
gen fatals2529_pc = ddage_2529 / age_2529
gen fatals2529_hunthou = fatals2529_pc * 100000
gen fatals3034_pc = ddage_3034 / age_3034
gen fatals3034_hunthou = fatals3034_pc * 100000
gen fatals3539_pc = ddage_3539 / age_3539
gen fatals3539_hunthou = fatals3539_pc * 100000
gen fatals2039_pc = ddage_2039 / pop_age2039
gen fatals2039_hunthou = fatals2039_pc * 100000
gen fatals40up_pc = ddage_40up / pop_age40up
gen fatals40up_hunthou = fatals40up_pc * 100000
gen vehmiles_pc = vehmiles / state_pop
gen vehmiles_hunthou = vehmiles_pc * 100000
replace fatalscann_hunthou = 0 if fatalscann_hunthou == .
replace fatalsodrugs_hunthou = 0 if fatalsodrugs_hunthou == .
gen fatalsnodrugs_pc = fatalsnodrugs / state_pop
gen fatalsnodrugs_hunthou = fatalsnodrugs_pc * 100000
gen fatalsall_pc = fatalsall / state_pop
gen fatalsall_hunthou = fatalsall_pc * 100000
gen fatalsnoimpair_pc = fatalsnoimpair / state_pop
gen fatalsnoimpair_hunthou = fatalsnoimpair_pc * 100000
gen totsva_pc = fsva / state_pop
gen totsva_hunthou = totsva_pc * 100000
gen alcsva_pc = fsva_alc / state_pop
gen alcsva_hunthou = alcsva_pc * 100000
gen noalcsva_pc = (fsva - fsva_alc) / state_pop
gen noalcsva_hunthou = noalcsva_pc * 100000
gen fatalsddweed_hunthou = (fatalsddweed / state_pop) * 100000
replace fatalsddweed_hunthou = 0 if fatalsddweed_hunthou == .
gen pop_age50up = age_5054 + age_5559 + age_6064 + age_6569 + age_7074 + age_7579 + age_8084 + age_85up
gen fatals4044_hunthou = (ddage_4044 / age_4044) * 100000
gen fatals4549_hunthou = (ddage_4549 / age_4549) * 100000
gen fatals50up_hunthou = (ddage_50up / pop_age50up) * 100000
gen pcturbanvmt = urbanmiles / vehmiles
	sort fips year
	by fips: ipolate pcturbanvmt year, generate(pcturbanvmt1)
gen alctestrate = alctested / people
gen drugtestrate = drugtested / people
save file_marijuana3_0019, replace
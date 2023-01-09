* fixing general alcohol-related fatalities * 
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
	collapse (sum) dd, by(st_case)
	save file_dd_`yr', replace

	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_dd_`yr'
	drop _merge
	drop if dd == 0
	collapse (sum) fatals, by(state)
	save file_fatalsdd_`yr', replace
}

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_fatalsdd_`yr'
	rename state fips
	merge m:1 fips using file_mari_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

* fixing non-alcohol-related fatalities *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_dd_`yr'
	drop _merge
	drop if dd > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalsnondd)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

* fixing alcohol-related fatalities by age *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen ddage_1519 = 1 if inrange(age, 15, 19) & death_yr == 20`yr'
	gen ddage_2024 = 1 if inrange(age, 20, 24) & death_yr == 20`yr'
	gen ddage_2529 = 1 if inrange(age, 25, 29) & death_yr == 20`yr'
	gen ddage_3034 = 1 if inrange(age, 30, 34) & death_yr == 20`yr'
	gen ddage_3539 = 1 if inrange(age, 35, 39) & death_yr == 20`yr'
	gen ddage_40up = 1 if (inrange(age, 40, 97) & inrange(death_yr, 2000, 2008)) | (inrange(age, 40, 120) & death_yr > 2008)
	gen ddage_4044 = 1 if inrange(age, 40, 44) & death_yr == 20`yr'
	gen ddage_4549 = 1 if inrange(age, 45, 49) & death_yr == 20`yr'
	gen ddage_50up = 1 if (inrange(age, 50, 97) & inrange(death_yr, 2000, 2008)) | (inrange(age, 50, 120) & death_yr > 2008)
	collapse (sum) ddage_1519 ddage_2024 ddage_2529 ddage_3034 ddage_3539 ddage_40up ddage_4044 ddage_4549 ddage_50up, by(st_case)
	save file_agedd2_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_dd_`yr'
	drop _merge
	merge m:1 st_case using file_agedd2_`yr'
	drop _merge
	drop if dd == 0
	collapse (sum) ddage_1519 ddage_2024 ddage_2529 ddage_3034 ddage_3539 ddage_40up ddage_4044 ddage_4549 ddage_50up, by(state)
	rename state fips
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

* fixing alcohol-related fatalities by driver BAC *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen dd_bac0107 = 1 if per_no == 1 & inrange(alc_res, 0.001, 7.999)
	gen dd_bac08 = 1 if per_no == 1 & inrange(alc_res, 8, 94)
	gen dd_bac10 = 1 if per_no == 1 & inrange(alc_res, 10, 94)
	collapse (sum) dd_bac0107 dd_bac08 dd_bac10, by(st_case)
	save file_ddbac_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_ddbac_`yr'
	drop _merge
	collapse (sum) dd_bac0107 dd_bac08 dd_bac10, by(state)
	rename state fips
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

foreach yr in "15" "16" "17" "18" "19" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen dd_bac0107 = 1 if per_no == 1 & inrange(alc_res, 0.001, 79.999)
	gen dd_bac08 = 1 if per_no == 1 & inrange(alc_res, 80, 940)
	gen dd_bac10 = 1 if per_no == 1 & inrange(alc_res, 100, 940)
	collapse (sum) dd_bac0107 dd_bac08 dd_bac10, by(st_case)
	save file_ddbac_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_ddbac_`yr'
	drop _merge
	collapse (sum) dd_bac0107 dd_bac08 dd_bac10, by(state)
	rename state fips
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

* fixing drug-related fatalities *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen cannabinoid = 1 if (per_no == 1 & inrange(drugres1, 600, 695)) | (per_no == 1 & inrange(drugres2, 600, 695)) | (per_no == 1 & inrange(drugres3, 600, 695))
	gen otherdrugs = 1 if (per_no == 1 & (inrange(drugres1, 100, 595) | inrange(drugres1, 700, 996))) | (per_no == 1 & (inrange(drugres2, 100, 595) | inrange(drugres2, 700, 996))) | (per_no == 1 & (inrange(drugres3, 100, 595) | inrange(drugres3, 700, 996)))
	collapse (sum) cannabinoid otherdrugs, by(st_case)
	save file_drugsagain_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_drugsagain_`yr'
	drop if cannabinoid == 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalscann)
	save file_fatalscann_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_drugsagain_`yr'
	drop if otherdrugs == 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalsodrugs)
	merge m:1 fips using file_fatalscann_`yr'
	drop _merge
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

foreach yr in "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Drugs.csv"
	gen cannabinoid = 1 if per_no == 1 & inrange(drugres, 600, 695)
	gen otherdrugs = 1 if per_no == 1 & (inrange(drugres, 100, 595) | inrange(drugres, 700, 996))
	collapse (sum) cannabinoid otherdrugs, by(st_case)
	save file_drugsagain_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_drugsagain_`yr'
	drop if cannabinoid == 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalscann)
	save file_fatalscann_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_drugsagain_`yr'
	drop if otherdrugs == 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalsodrugs)
	merge m:1 fips using file_fatalscann_`yr'
	drop _merge
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}	

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_drugsagain_`yr'
	keep if cannabinoid == 0 & otherdrugs == 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalsnodrugs)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

* fixing non-impaired fatalities *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_dd_`yr'
	drop _merge
	merge m:1 st_case using file_drugsagain_`yr'
	drop _merge
	keep if dd == 0 & cannabinoid == 0 & otherdrugs == 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalsnoimpair)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

* fixing alcohol&marijuana fatalities *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
	gen cannabinoid = 1 if (per_no == 1 & inrange(drugres1, 600, 695)) | (per_no == 1 & inrange(drugres2, 600, 695)) | (per_no == 1 & inrange(drugres3, 600, 695))
	gen ddweed = 1 if dd == 1 & cannabinoid == 1
	collapse (sum) ddweed, by(st_case)
	save file_ddweed_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	merge m:1 st_case using file_ddweed_`yr'
	drop _merge
	keep if ddweed > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalsddweed)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

foreach yr in "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Drugs.csv"
	gen cannabinoid = 1 if per_no == 1 & inrange(drugres, 600, 695)
	drop if cannabinoid != 1
	collapse (sum) cannabinoid, by(st_case veh_no per_no)
	replace cannabinoid = 1 if cannabinoid > 0
	save file_farsdrugs_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Person.csv"
	merge m:1 st_case veh_no per_no using file_farsdrugs_`yr'
	drop _merge
	gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
	gen ddweed = 1 if dd == 1 & cannabinoid == 1
	collapse (sum) ddweed, by(st_case)
	save file_ddweed_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Accident.csv"
	keep state st_case fatals
	merge m:1 st_case using file_ddweed_`yr'
	drop _merge
	keep if ddweed > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalsddweed)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}

* fixing all fatalities *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	keep state st_case fatals
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatalsall)
	merge m:1 fips using file_mari3_`yr'
	drop _merge 
	save file_mari3_`yr', replace
}

* adding additional years of controls *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" {
	clear
	
	use file_income_`yr'
	merge m:1 State using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
	
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
merge m:1 State using file_mari3_06
drop _merge
save file_mari3_06, replace

* adding in single-vehicle accidents *
*foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	*clear
	
	*use file_svaall
	*keep fips year Number AlcoholRelated
	*keep if year == 20`yr'
	*rename (Number AlcoholRelated) (totsva alcsva)
	*merge m:1 fips using file_mari3_`yr'
	*drop _merge 
	*save file_mari3_`yr', replace
*}

* putting it all together *
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
save file_marijuana3_0019, replace

summarize fatalsall_hunthou fatalscann_hunthou fatalsodrugs_hunthou fatalsnodrugs_hunthou fatalsnodd_hunthou fatalsnoimpair_hunthou fatalsbac0107_hunthou fatalsbac08_hunthou fatalsbac10_hunthou fatals1519_hunthou fatals2024_hunthou fatals2529_hunthou fatals3034_hunthou fatals3539_hunthou fatals40up_hunthou mml_treat decrim vehmiles_hunthou med_age urate rpc_income 
summarize totsva_hunthou alcsva_hunthou noalcsva_hunthou
summarize fatalsdd_hunthou

reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml2.doc
reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml2.doc, append
reghdfe fatalsall_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsall_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsnodd_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml2.doc, append
reghdfe fatalsnodd_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml2.doc, append
reghdfe fatalsnodrugs_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsnodrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsnoimpair_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsnoimpair_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)

reghdfe fatalscann_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml3.doc
reghdfe fatalscann_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml3.doc, append
reghdfe fatalsodrugs_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml3.doc, append
reghdfe fatalsodrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml3.doc, append
reghdfe fatalsnodrugs_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsnodrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)

reghdfe fatalsbac0107_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsbac0107_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsbac08_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsbac08_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsbac10_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsbac10_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)

reghdfe fatals1519_hunthou1 rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml4.doc
reghdfe fatals1519_hunthou1 rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml4.doc, append
reghdfe fatals2024_hunthou1 rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatals2024_hunthou1 rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatals2529_hunthou1 rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatals2529_hunthou1 rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatals3034_hunthou1 rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatals3034_hunthou1 rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatals3539_hunthou1 rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatals3539_hunthou1 rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatals40up_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml4.doc, append
reghdfe fatals40up_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
	*outreg2 using rml4.doc, append
reghdfe fatals4044_hunthou1 rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatals4044_hunthou1 rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatals4549_hunthou1 rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatals4549_hunthou1 rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatals50up_hunthou1 rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatals50up_hunthou1 rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
	
reghdfe totsva_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe totsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe alcsva_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe alcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe noalcsva_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe noalcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)

reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsddweed_hunthou rml_treat##rml_prepost mml_treat decrim, absorb(fips year) noconstant cluster(fips)
reghdfe fatalsddweed_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant cluster(fips)

**********

clear
use file_marijuana3_0019
gen dfortwoway = rml_treat * rml_prepost
save file_marijuana3_0019, replace

twowayfeweights fatalscann_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalscann_twowayfeweights.dta)
twowayfeweights fatalsodrugs_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalsodrugs_twowayfeweights.dta)

twowayfeweights fatalsall_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalsall_twowayfeweights.dta)
twowayfeweights fatalsnodd_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalsnodd_twowayfeweights.dta)
twowayfeweights fatalsnodrugs_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalsnodrugs_twowayfeweights.dta)
twowayfeweights fatalsnoimpair_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalsnoimpair_twowayfeweights.dta)

twowayfeweights fatalsdd_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalsdd_twowayfeweights.dta)
twowayfeweights fatalsbac0107_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalsbac0107_twowayfeweights.dta)
twowayfeweights fatalsbac08_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalsbac08_twowayfeweights.dta)
twowayfeweights fatalsbac10_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatalsbac10_twowayfeweights.dta)

twowayfeweights fatals1519_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatals1519_twowayfeweights.dta)
twowayfeweights fatals2024_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatals2024_twowayfeweights.dta)
twowayfeweights fatals2529_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatals2529_twowayfeweights.dta)
twowayfeweights fatals3034_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatals3034_twowayfeweights.dta)
twowayfeweights fatals3539_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatals3539_twowayfeweights.dta)
twowayfeweights fatals40up_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(fatals40up_twowayfeweights.dta)

twowayfeweights totsva_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(totsva_twowayfeweights.dta)
twowayfeweights alcsva_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(alcsva_twowayfeweights.dta)
twowayfeweights noalcsva_hunthou fips year dfortwoway, type(feTR) controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) path(noalcsva_twowayfeweights.dta)


	did_multiplegt fatalscann_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalscann_multiplegt7.dta)
	graph export "C:/dissertation/misc/cann7.png"
	did_multiplegt fatalsodrugs_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsodrugs_multiplegt7.dta)
	graph export "C:/dissertation/misc/odrugs7.png"
	
	did_multiplegt fatalsall_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(7) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsall_multiplegt7.dta)
	graph export "C:/dissertation/misc/total7.png"
	did_multiplegt fatalsnodrugs_hunthou fips year dfortwoway, robust_dynamic dynamic(4) placebo(4) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsnodrugs_multiplegt.dta)
	did_multiplegt fatalsnodd_hunthou fips year dfortwoway, robust_dynamic dynamic() placebo(4) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsnodd_multiplegt.dta)
	did_multiplegt fatalsnoimpair_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsnoimpair_multiplegt7.dta)
	graph export "C:/dissertation/misc/noimpair7.png"
	did_multiplegt fatalsddweed_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsddweed_multiplegt7.dta)
	graph export "C:/dissertation/misc/ddweed7.png"

	
	did_multiplegt fatalsdd_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsdd_multiplegt7.dta)
	graph export "C:/dissertation/misc/alc7.png"
	did_multiplegt fatalsbac0107_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsbac0107_multiplegt7.dta)
	graph export "C:/dissertation/misc/bac0107_7.png"
	did_multiplegt fatalsbac08_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsbac08_multiplegt7.dta)
	graph export "C:/dissertation/misc/bac08_7.png"
	did_multiplegt fatalsbac10_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsbac10_multiplegt7.dta)
	graph export "C:/dissertation/misc/bac10_7.png"
	
	did_multiplegt fatals1519_hunthou1 fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals1519_multiplegt7.dta)
	graph export "C:/dissertation/misc/age1519_7.png"
	did_multiplegt fatals2024_hunthou1 fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals2024_multiplegt7.dta)
	graph export "C:/dissertation/misc/age2024_7.png"
	did_multiplegt fatals2529_hunthou1 fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals2529_multiplegt7.dta)
	graph export "C:/dissertation/misc/age2529_7.png"
	did_multiplegt fatals3034_hunthou1 fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals3034_multiplegt7.dta)
	graph export "C:/dissertation/misc/age3034_7.png"
	did_multiplegt fatals3539_hunthou1 fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals3539_multiplegt7.dta)
	graph export "C:/dissertation/misc/age3539_7.png"
	did_multiplegt fatals40up_hunthou fips year dfortwoway, robust_dynamic dynamic(4) placebo(4) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals40up_multiplegt.dta)
	
	did_multiplegt totsva_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(totsva_multiplegt7.dta)
	graph export "C:/dissertation/misc/totsva7.png"

	did_multiplegt alcsva_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(alcsva_multiplegt7.dta)
		graph export "C:/dissertation/misc/alcsva7.png"

	did_multiplegt noalcsva_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(noalcsva_multiplegt7.dta)
	graph export "C:/dissertation/misc/noalcsva7.png"


did_multiplegt fatalsddweed_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatalsddweed_multiplegt.dta)
did_multiplegt fatals4044_hunthou1 fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals4044_multiplegt7.dta)
	graph export "C:/dissertation/misc/age4044_7.png"
did_multiplegt fatals4549_hunthou1 fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals4549_multiplegt7.dta)
	graph export "C:/dissertation/misc/age4549_7.png"
did_multiplegt fatals50up_hunthou1 fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals50up_multiplegt7.dta)
	graph export "C:/dissertation/misc/age50up7.png"

gen newid = fips 
tsset newid year
bootstrap, reps(500) seed(12345) cluster(fips) idcluster(newid): reghdfe fatalsddweed_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant 
bootstrap, reps(500) seed(12345) cluster(fips) idcluster(newid): reghdfe fatals4044_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant 
bootstrap, reps(500) seed(12345) cluster(fips) idcluster(newid): reghdfe fatals4549_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant 
bootstrap, reps(500) seed(12345) cluster(fips) idcluster(newid): reghdfe fatals50up_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, absorb(fips year) noconstant 

***************************

gen pctodrugs = fatalsodrugs / fatalsall
replace pctodrugs = 0 if pctodrugs == .
gen pctddweed = fatalsddweed / fatalsall
replace pctddweed = 0 if pctddweed == .

reghdfe pctcann rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe pctcann rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe pctodrugs rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe pctodrugs rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe pctdd rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe pctdd rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe pctddweed rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe pctddweed rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe pctsober rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe pctsober rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)

summarize pctcann pctodrugs pctdd pctddweed pctsober

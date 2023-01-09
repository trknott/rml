* fatal incidents incidents instead of fatalities *

* general drunk driving *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
	gen nodd = 1 if (per_no == 1 & drinking == 0) | (per_no == 1 & alc_res == 0)
	collapse (sum) dd nodd, by(st_case state)
	gen dd_case = 1 if dd > 0
	gen nodd_case = 1 if nodd > 0
	collapse (sum) dd_case nodd_case, by(state)
	rename state fips
	merge m:1 fips using file_mari_`yr'
	drop _merge
	save file_mari4_`yr', replace
}

* BAC *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen dd_bac0107 = 1 if per_no == 1 & inrange(alc_res, 0.001, 7.999)
	gen dd_bac08 = 1 if per_no == 1 & inrange(alc_res, 8, 94)
	gen dd_bac10 = 1 if per_no == 1 & inrange(alc_res, 10, 94)
	collapse (sum) dd_bac0107 dd_bac08 dd_bac10, by(st_case state)
	gen bac0107_case = 1 if dd_bac0107 > 0
	gen bac08_case = 1 if dd_bac08 > 0
	gen bac10_case = 1 if dd_bac10 > 0
	collapse (sum) bac0107_case bac08_case bac10_case, by(state)
	rename state fips
	merge m:1 fips using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
}

* alcohol, age *
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
	collapse (sum) ddage_1519 ddage_2024 ddage_2529 ddage_3034 ddage_3539 ddage_40up ddage_4044 ddage_4549 ddage_50up, by(st_case state)
	gen dd1519_case = 1 if ddage_1519 > 0
	gen dd2024_case = 1 if ddage_2024 > 0
	gen dd2529_case = 1 if ddage_2529 > 0
	gen dd3034_case = 1 if ddage_3034 > 0
	gen dd3539_case = 1 if ddage_3539 > 0
	gen dd40up_case = 1 if ddage_40up > 0
	gen dd4044_case = 1 if ddage_4044 > 0
	gen dd4549_case = 1 if ddage_4549 > 0
	gen dd50up_case = 1 if ddage_50up > 0
	collapse (sum) dd1519_case dd2024_case dd2529_case dd3034_case dd3539_case dd40up_case dd4044_case dd4549_case dd50up_case, by(state)
	rename state fips
	merge m:1 fips using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
}

* drugs etc. *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen cannabinoid = 1 if (per_no == 1 & inrange(drugres1, 600, 695)) | (per_no == 1 & inrange(drugres2, 600, 695)) | (per_no == 1 & inrange(drugres3, 600, 695))
	gen otherdrugs = 1 if (per_no == 1 & (inrange(drugres1, 100, 595) | inrange(drugres1, 700, 996))) | (per_no == 1 & (inrange(drugres2, 100, 595) | inrange(drugres2, 700, 996))) | (per_no == 1 & (inrange(drugres3, 100, 595) | inrange(drugres3, 700, 996)))
	collapse (sum) cannabinoid otherdrugs, by(st_case state)
	gen cann_case = 1 if cannabinoid > 0
	gen odrugs_case = 1 if otherdrugs > 0
	collapse (sum) cann_case odrugs_case, by(state)
	rename state fips
	merge m:1 fips using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
}
foreach yr in "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Drugs.csv"
	gen cannabinoid = 1 if per_no == 1 & inrange(drugres, 600, 695)
	gen otherdrugs = 1 if per_no == 1 & (inrange(drugres, 100, 595) | inrange(drugres, 700, 996))
	collapse (sum) cannabinoid otherdrugs, by(st_case state)
	gen cann_case = 1 if cannabinoid > 0
	gen odrugs_case = 1 if otherdrugs > 0
	collapse (sum) cann_case odrugs_case, by(state)
	rename state fips
	merge m:1 fips using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
}

* alcohol & marijuana *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
	gen cannabinoid = 1 if (per_no == 1 & inrange(drugres1, 600, 695)) | (per_no == 1 & inrange(drugres2, 600, 695)) | (per_no == 1 & inrange(drugres3, 600, 695))
	gen ddweed = 1 if dd == 1 & cannabinoid == 1
	collapse (sum) ddweed, by(st_case state)
	gen ddweed_case = 1 if ddweed > 0
	collapse (sum) ddweed_case, by(state)
	rename state fips
	merge m:1 fips using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
}
foreach yr in "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Person.csv"
	merge m:1 st_case veh_no per_no using file_farsdrugs_`yr'
	drop _merge
	gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
	gen ddweed = 1 if dd == 1 & cannabinoid == 1
	collapse (sum) ddweed, by(st_case state)
	gen ddweed_case = 1 if ddweed > 0
	collapse (sum) ddweed_case, by(state)
	rename state fips
	merge m:1 fips using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
}

* not impaired *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
	gen cannabinoid = 1 if (per_no == 1 & inrange(drugres1, 600, 695)) | (per_no == 1 & inrange(drugres2, 600, 695)) | (per_no == 1 & inrange(drugres3, 600, 695))
	gen otherdrugs = 1 if (per_no == 1 & (inrange(drugres1, 100, 595) | inrange(drugres1, 700, 996))) | (per_no == 1 & (inrange(drugres2, 100, 595) | inrange(drugres2, 700, 996))) | (per_no == 1 & (inrange(drugres3, 100, 595) | inrange(drugres3, 700, 996)))
	gen noimpair = 1 if per_no == 1 & dd != 1 & cannabinoid != 1 & otherdrugs != 1
	collapse (sum) noimpair, by(st_case state)
	gen noimpair_case = 1 if noimpair > 0
	collapse (sum) noimpair_case, by(state)
	rename state fips
	merge m:1 fips using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
}
foreach yr in "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Drugs.csv"
	gen cannabinoid = 1 if per_no == 1 & inrange(drugres, 600, 695)
	gen otherdrugs = 1 if (per_no == 1 & (inrange(drugres, 100, 595) | inrange(drugres, 700, 996))) 
	keep if cannabinoid == 1 | otherdrugs == 1
	collapse (sum) cannabinoid otherdrugs, by(st_case veh_no per_no)
	replace cannabinoid = 1 if cannabinoid > 0
	replace otherdrugs = 1 if otherdrugs > 0
	save file_farsdrugs2_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Person.csv"
	merge m:1 st_case veh_no per_no using file_farsdrugs2_`yr'
	drop _merge
	gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
	gen noimpair = 1 if per_no == 1 & dd != 1 & cannabinoid != 1 & otherdrugs != 1
	collapse (sum) noimpair, by(st_case state)
	gen noimpair_case = 1 if noimpair > 0
	collapse (sum) noimpair_case, by(state)
	rename state fips
	merge m:1 fips using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
}

* all fatal incidents *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Accident.csv"
	gen fatal_case = 1
	collapse (sum) fatal_case, by(state)
	rename state fips
	merge m:1 fips using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
}

* adding additional years of controls *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" {
	clear
	
	use file_income_`yr'
	merge m:1 State using file_mari4_`yr'
	drop _merge
	save file_mari4_`yr', replace
	
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
merge m:1 State using file_mari4_06
drop _merge
save file_mari4_06, replace

* putting it all together... *
clear

use file_mari4_00
save file_marijuana4_0019, replace
foreach yr in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	append using file_mari4_`yr'
	save file_marijuana4_0019, replace
}
drop bac01_result bac08_result bac10_result fbac01 fbac08 fbac10 inv_age85up fatal_age85up fatalalc_age85up inv_age8084 fatal_age8084 fatalalc_age8084 inv_age7579 fatal_age7579 fatalalc_age7579 inv_age7074 fatal_age7074 fatalalc_age7074 inv_age6569 fatal_age6569 fatalalc_age6569 inv_age6064 fatal_age6064 fatalalc_age6064 inv_age5559 fatal_age5559 fatalalc_age5559 inv_age5054 fatal_age5054 fatalalc_age5054 inv_age4549 fatal_age4549 fatalalc_age4549 inv_age4044 fatal_age4044 fatalalc_age4044 inv_age3539 fatal_age3539 fatalalc_age3539 inv_age3034 fatal_age3034 fatalalc_age3034 inv_age2529 fatal_age2529 fatalalc_age2529 inv_age2024 fatal_age2024 fatalalc_age2024 inv_age1519 fatal_age1519 fatalalc_age1519 fatal fatal fatal_alc fatal_noalc FieldDesc Number AlcoholRelated PercentAlcoholRelated group1 group2 noalc

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
replace decrim = 1 if (rml_treat == 1 & rml_prepost == 1)
save file_marijuana4_0019, replace

gen pop_age40up = age_4044 + age_4549 + age_5054 + age_5559 + age_6064 + age_6569 + age_7074 + age_7579 + age_8084 + age_85up
gen pop_age50up = age_5054 + age_5559 + age_6064 + age_6569 + age_7074 + age_7579 + age_8084 + age_85up
gen vehmiles_pc = vehmiles / state_pop
gen vehmiles_hunthou = vehmiles_pc * 100000
gen totsva_pc = fsva / state_pop
gen totsva_hunthou = totsva_pc * 100000
gen alcsva_pc = fsva_alc / state_pop
gen alcsva_hunthou = alcsva_pc * 100000
gen noalcsva_pc = (fsva - fsva_alc) / state_pop
gen noalcsva_hunthou = noalcsva_pc * 100000
gen ddweedcase_hunthou = (ddweed_case / state_pop) * 100000
gen ddweedpercase = ddweed_case / fatal_case
gen ddweedcvmt = ddweed_case / (vehmiles / 1000)
gen canncase_hunthou = (cann_case / state_pop) * 100000
gen cannpercase = cann_case / fatal_case
gen canncvmt = cann_case / (vehmiles / 1000)
gen odrugscase_hunthou = (odrugs_case / state_pop) * 100000
gen odrugspercase = odrugs_case / fatal_case
gen odrugscvmt = odrugs_case / (vehmiles / 1000)
gen ddcase_hunthou = (dd_case / state_pop) * 100000
gen ddpercase = dd_case / fatal_case
gen ddcvmt = dd_case / (vehmiles / 1000)
gen noimpaircase_hunthou = (noimpair_case / state_pop) * 100000
gen noimpairpercase = noimpair_case / fatal_case
gen noimpaircvmt = noimpair_case / (vehmiles / 1000)
gen bac0107case_hunthou = (bac0107_case / state_pop) * 100000
gen bac0107percase = bac0107_case / fatal_case
gen bac0107cvmt = bac0107_case / (vehmiles / 1000)
gen bac08case_hunthou = (bac08_case / state_pop) * 100000
gen bac08percase = bac08_case / fatal_case
gen bac08cvmt = bac08_case / (vehmiles / 1000)
gen bac10case_hunthou = (bac10_case / state_pop) * 100000
gen bac10percase = bac10_case / fatal_case
gen bac10cvmt = bac10_case / (vehmiles / 1000)
gen case1519_hunthou = (dd1519_case / state_pop) * 100000
gen percase1519 = dd1519_case / fatal_case
gen c1519vmt = dd1519_case / (vehmiles / 1000)
gen case2024_hunthou = (dd2024_case / state_pop) * 100000
gen percase2024 = dd2024_case / fatal_case
gen c2024vmt = dd2024_case / (vehmiles / 1000)
gen case2529_hunthou = (dd2529_case / state_pop) * 100000
gen percase2529 = dd2529_case / fatal_case
gen c2529vmt = dd2529_case / (vehmiles / 1000)
gen case3034_hunthou = (dd3034_case / state_pop) * 100000
gen percase3034 = dd3034_case / fatal_case
gen c3034vmt = dd3034_case / (vehmiles / 1000)
gen case3539_hunthou = (dd3539_case / state_pop) * 100000
gen percase3539 = dd3539_case / fatal_case
gen c3539vmt = dd3539_case / (vehmiles / 1000)
gen case4044_hunthou = (dd4044_case / state_pop) * 100000
gen percase4044 = dd4044_case / fatal_case
gen c4044vmt = dd4044_case / (vehmiles / 1000)
gen case4549_hunthou = (dd4549_case / state_pop) * 100000
gen percase4549 = dd4549_case / fatal_case
gen c4549vmt = dd4549_case / (vehmiles / 1000)
gen case50up_hunthou = (dd50up_case / state_pop) * 100000
gen percase50up = dd50up_case / fatal_case
gen c50upvmt = dd50up_case / (vehmiles / 1000)
save file_marijuana4_0019, replace

**********
reghdfe ddweedcase_hunthou rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe ddweedcase_hunthou rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips year)
*gen newid = fips
bootstrap, reps(1000) seed(12345) cluster(fips) idcluster(newid): reghdfe ddweedcase_hunthou rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year)

reghdfe ddweedcase_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe ddweedcase_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips year)
bootstrap, reps(1000) seed(12345) cluster(fips) idcluster(newid): reghdfe ddweedcase_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)

reghdfe ddweedpercase rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe ddweedpercase rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips year)
bootstrap, reps(1000) seed(12345) cluster(fips) idcluster(newid): reghdfe ddweedpercase rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year)

reghdfe ddweedpercase rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe ddweedpercase rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips year)
bootstrap, reps(1000) seed(12345) cluster(fips) idcluster(newid): reghdfe ddweedpercase rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)


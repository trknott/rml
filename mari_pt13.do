* taking drug involvement out of alcohol involvement and vice versa *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" {
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen ddonly = 1 if (per_no == 1 & drinking == 1 & drugs == 0) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & drugs == 0)
	gen drugsonly = 1 if (per_no == 1 & drinking == 0 & drugs == 1) | (per_no == 1 & alc_res == 0 & drugs == 1)
	gen cannonly = 1 if (per_no == 1 & inrange(drugres1, 600, 695) & drinking == 0) | (per_no == 1 & inrange(drugres2, 600, 695) & drinking == 0) | (per_no == 1 & inrange(drugres3, 600, 695) & drinking == 0)
	gen odrugsonly = 1 if drugsonly == 1 & cannonly != 1
	gen ddodrugs = 1 if (per_no == 1 & drinking == 1 & (inrange(drugres1, 100, 595) | inrange(drugres1, 700, 996))) | (per_no == 1 & drinking == 1 & (inrange(drugres2, 100, 595) | inrange(drugres2, 700, 996))) | (per_no == 1 & drinking == 1 & (inrange(drugres3, 100, 595) | inrange(drugres3, 700, 996))) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & (inrange(drugres1, 100, 595) | inrange(drugres1, 700, 996))) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & (inrange(drugres2, 100, 595) | inrange(drugres2, 700, 996))) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & (inrange(drugres3, 100, 595) | inrange(drugres3, 700, 996)))
	collapse (sum) ddonly drugsonly cannonly odrugsonly ddodrugs, by(st_case)
	save file_impairiso_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals ddonly
	keep if ddonly > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_ddonly)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals drugsonly
	keep if drugsonly > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_drugsonly)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals cannonly
	keep if cannonly > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_cannonly)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals odrugsonly
	keep if odrugsonly > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_odrugsonly)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals ddodrugs
	keep if ddodrugs > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_ddodrugs)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}
foreach yr in "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Drugs.csv"
	drop if drugres == 0 | drugres == 1 | drugres == 95 | drugres == 997 | drugres == 998 | drugres == 999
	gen cannabinoid = 1 if per_no == 1 & inrange(drugres, 600, 695)
	gen otherdrugs = 1 if per_no == 1 & (inrange(drugres, 100, 595) | inrange(drugres, 700, 996))
	collapse (sum) cannabinoid otherdrugs, by(st_case veh_no per_no)
	save file_moredrugs_`yr', replace
	
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Person.csv"
	merge m:1 st_case veh_no per_no using file_moredrugs_`yr'
	drop _merge
	replace cannabinoid = 1 if cannabinoid > 0
	replace otherdrugs = 1 if otherdrugs > 0
	gen ddonly = 1 if (per_no == 1 & drinking == 1 & drugs == 0) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & drugs == 0)
	gen drugsonly = 1 if (per_no == 1 & drinking == 0 & drugs == 1) | (per_no == 1 & alc_res == 0 & drugs == 1)
	gen cannonly = 1 if (per_no == 1 & cannabinoid == 1 & otherdrugs != 1 & drinking == 0) | (per_no == 1 & cannabinoid == 1 & otherdrugs != 1 & drinking == 0) | (per_no == 1 & cannabinoid == 1 & otherdrugs != 1 & drinking == 0)
	gen odrugsonly = 1 if drugsonly == 1 & cannonly != 1
	gen ddodrugs = 1 if (per_no == 1 & drinking == 1 & otherdrugs == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & otherdrugs == 1)
	collapse (sum) ddonly drugsonly cannonly odrugsonly ddodrugs, by(st_case)
	replace drugsonly = 1 if (cannonly > 0 | odrugsonly > 0) & ddonly == 0
	save file_impairiso_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals ddonly
	keep if ddonly > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_ddonly)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals drugsonly
	keep if drugsonly > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_drugsonly)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals cannonly
	keep if cannonly > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_cannonly)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals odrugsonly
	keep if odrugsonly > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_odrugsonly)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
	
	clear

	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	merge m:1 st_case using file_impairiso_`yr'
	keep state st_case fatals ddodrugs
	keep if ddodrugs > 0
	collapse (sum) fatals, by(state)
	rename (state fatals) (fips fatals_ddodrugs)
	merge m:1 fips using file_mari3_`yr'
	drop _merge
	save file_mari3_`yr', replace
}
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

drop if fips == .
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
foreach thing in "1519" "2024" "2529" "3034" "3539" "4044" "4549" "50up" {
	gen fatals`thing'_hunthou1 = (ddage_`thing' / state_pop) * 100000
}
save file_marijuana3_0019, replace

***********************

* adding 1999 for lags *
clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/PERSON.csv"
gen ddonly = 1 if (per_no == 1 & drinking == 1 & drugs == 0) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & drugs == 0)
gen drugsonly = 1 if (per_no == 1 & drinking == 0 & drugs == 1) | (per_no == 1 & alc_res == 0 & drugs == 1)
gen cannonly = 1 if (per_no == 1 & inrange(drugres1, 600, 695) & drinking == 0) | (per_no == 1 & inrange(drugres2, 600, 695) & drinking == 0) | (per_no == 1 & inrange(drugres3, 600, 695) & drinking == 0)
gen odrugsonly = 1 if drugsonly == 1 & cannonly != 1
gen ddodrugs = 1 if (per_no == 1 & drinking == 1 & (inrange(drugres1, 100, 595) | inrange(drugres1, 700, 996))) | (per_no == 1 & drinking == 1 & (inrange(drugres2, 100, 595) | inrange(drugres2, 700, 996))) | (per_no == 1 & drinking == 1 & (inrange(drugres3, 100, 595) | inrange(drugres3, 700, 996))) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & (inrange(drugres1, 100, 595) | inrange(drugres1, 700, 996))) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & (inrange(drugres2, 100, 595) | inrange(drugres2, 700, 996))) | (per_no == 1 & inrange(alc_res, 0.001, 94.999) & (inrange(drugres3, 100, 595) | inrange(drugres3, 700, 996)))
collapse (sum) ddonly drugsonly cannonly odrugsonly ddodrugs, by(st_case)
save file_impairiso_99, replace

clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
merge m:1 st_case using file_impairiso_99
keep state st_case fatals ddonly
keep if ddonly > 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatals_ddonly)
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace
	
clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
merge m:1 st_case using file_impairiso_99
keep state st_case fatals drugsonly
keep if drugsonly > 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatals_drugsonly)
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace
	
clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
merge m:1 st_case using file_impairiso_99
keep state st_case fatals cannonly
keep if cannonly > 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatals_cannonly)
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace
	
clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
merge m:1 st_case using file_impairiso_99
keep state st_case fatals odrugsonly
keep if odrugsonly > 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatals_odrugsonly)
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace

clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
merge m:1 st_case using file_impairiso_99
keep state st_case fatals ddodrugs
keep if ddodrugs > 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatals_ddodrugs)
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace

clear

use file_marijuana3_0019
append using file_depvar1999
save file_marijuana3_9919, replace

*************

gen fatals_ddonly_hunthou = (fatals_ddonly / state_pop) * 100000
gen fatals_drugsonly_hunthou = (fatals_drugsonly / state_pop) * 100000
gen fatals_cannonly_hunthou = (fatals_cannonly / state_pop) * 100000
gen fatals_odrugsonly_hunthou = (fatals_odrugsonly / state_pop) * 100000
gen fatals_ddodrugs_hunthou = (fatals_ddodrugs / state_pop) * 100000
foreach thing in "ddonly" "drugsonly" "cannonly" "odrugsonly" "ddodrugs" {
	replace fatals_`thing'_hunthou = 0 if fatals_`thing'_hunthou == .
}
save file_marijuana3_9919, replace

****************

reghdfe fatals_drugsonly_hunthou rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe fatals_drugsonly_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)

reghdfe fatals_cannonly_hunthou rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe fatals_cannonly_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)

reghdfe fatals_odrugsonly_hunthou rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe fatals_odrugsonly_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)

reghdfe fatals_ddonly_hunthou rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe fatals_ddonly_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)

reghdfe fatals_ddodrugs_hunthou rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe fatals_ddodrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)

*****************

gen dfortwoway = rml_treat * rml_prepost
did_multiplegt fatals_drugsonly_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals_drugsonly_multiplegt.dta)
	graph export "C:/dissertation/misc/drugsonly_7.png"
did_multiplegt fatals_cannonly_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals_cannonly_multiplegt.dta)
	graph export "C:/dissertation/misc/cannonly_7.png"
did_multiplegt fatals_odrugsonly_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals_odrugsonly_multiplegt.dta)
	graph export "C:/dissertation/misc/odrugsonly_7.png"
did_multiplegt fatals_ddonly_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals_ddonly_multiplegt.dta)
	graph export "C:/dissertation/misc/ddonly_7.png"
did_multiplegt fatals_ddodrugs_hunthou fips year dfortwoway, robust_dynamic dynamic(7) placebo(6) longdiff_placebo controls(mml_treat decrim vehmiles_hunthou med_age urate rpc_income) breps(500) cluster(fips) seed(12345) save_results(fatals_ddodrugs_multiplegt.dta)
	graph export "C:/dissertation/misc/ddodrugs_7.png"
	
************************

clear

use file_marijuana3_9919
xtset fips year

reghdfe fatalsall_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsall_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
*reghdfe fatals_drugsonly_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals_drugsonly_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals_cannonly_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals_cannonly_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals_odrugsonly_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals_odrugsonly_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals_ddonly_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals_ddonly_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsddweed_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsddweed_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsnoimpair_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsnoimpair_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsdd_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsbac0107_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsbac0107_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsbac08_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsbac08_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsbac10_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsbac10_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals1519_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals1519_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals2024_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals2024_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals2529_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals2529_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals3034_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals3034_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals3539_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals3539_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals4044_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals4044_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals4549_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals4549_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatals50up_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatals50up_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe totsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.totsva_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe alcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.alcsva_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe noalcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.noalcsva_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)

*****************************

clear

use file_marijuana3_0019
foreach thing in "_cannonly" "_odrugsonly" "noimpair" "_ddonly" "ddweed" "dd" {
	gen frac`thing' = fatals`thing' / fatalsall
	replace frac`thing' = 0 if frac`thing' == .
}
save file_marijuana3_0019, replace

reghdfe frac_cannonly rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe frac_cannonly rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe frac_odrugsonly rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe frac_odrugsonly rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fracnoimpair rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe fracnoimpair rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe frac_ddonly rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe frac_ddonly rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fracddweed rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe fracddweed rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fracdd rml_treat##rml_prepost mml_treat decrim, noconstant absorb(fips year) cluster(fips)
reghdfe fracdd rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)

summarize frac_cannonly frac_odrugsonly fracnoimpair frac_ddonly fracddweed fracdd
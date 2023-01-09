clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/PERSON.csv"
gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
collapse (sum) dd, by(st_case)
save file_dd_99, replace

clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
merge m:1 st_case using file_dd_99
drop _merge
drop if dd == 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatalsdd)
save file_depvar1999, replace

clear
	
import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
merge m:1 st_case using file_dd_99
drop _merge
drop if dd > 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatalsnondd)
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace

clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/PERSON.csv"
gen ddage_1519 = 1 if inrange(age, 15, 19) & death_yr == 1999
gen ddage_2024 = 1 if inrange(age, 20, 24) & death_yr == 1999
gen ddage_2529 = 1 if inrange(age, 25, 29) & death_yr == 1999
gen ddage_3034 = 1 if inrange(age, 30, 34) & death_yr == 1999
gen ddage_3539 = 1 if inrange(age, 35, 39) & death_yr == 1999
gen ddage_40up = 1 if (inrange(age, 40, 97) & death_yr == 1999) | (inrange(age, 40, 120) & death_yr == 1999)
gen ddage_4044 = 1 if inrange(age, 40, 44) & death_yr == 1999
gen ddage_4549 = 1 if inrange(age, 45, 49) & death_yr == 1999
gen ddage_50up = 1 if (inrange(age, 50, 97) & death_yr == 1999) | (inrange(age, 50, 120) & death_yr == 1999)
collapse (sum) ddage_1519 ddage_2024 ddage_2529 ddage_3034 ddage_3539 ddage_40up ddage_4044 ddage_4549 ddage_50up, by(st_case)
save file_agedd2_99, replace
	
clear
	
import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
merge m:1 st_case using file_dd_99
drop _merge
merge m:1 st_case using file_agedd2_99
drop _merge
drop if dd == 0
collapse (sum) ddage_1519 ddage_2024 ddage_2529 ddage_3034 ddage_3539 ddage_40up ddage_4044 ddage_4549 ddage_50up, by(state)
rename state fips
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace

clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/PERSON.csv"
gen dd_bac0107 = 1 if per_no == 1 & inrange(alc_res, 0.001, 7.999)
gen dd_bac08 = 1 if per_no == 1 & inrange(alc_res, 8, 94)
gen dd_bac10 = 1 if per_no == 1 & inrange(alc_res, 10, 94)
collapse (sum) dd_bac0107 dd_bac08 dd_bac10, by(st_case)
save file_ddbac_99, replace
	
clear
	
import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
merge m:1 st_case using file_ddbac_99
drop _merge
collapse (sum) dd_bac0107 dd_bac08 dd_bac10, by(state)
rename state fips
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace

clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/PERSON.csv"
gen cannabinoid = 1 if (per_no == 1 & inrange(drugres1, 600, 695)) | (per_no == 1 & inrange(drugres2, 600, 695)) | (per_no == 1 & inrange(drugres3, 600, 695))
gen otherdrugs = 1 if (per_no == 1 & (inrange(drugres1, 100, 595) | inrange(drugres1, 700, 996))) | (per_no == 1 & (inrange(drugres2, 100, 595) | inrange(drugres2, 700, 996))) | (per_no == 1 & (inrange(drugres3, 100, 595) | inrange(drugres3, 700, 996)))
collapse (sum) cannabinoid otherdrugs, by(st_case)
save file_drugsagain_99, replace
	
clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
merge m:1 st_case using file_drugsagain_99
drop if cannabinoid == 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatalscann)
save file_fatalscann_99, replace
	
clear
	
import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
merge m:1 st_case using file_drugsagain_99
drop if otherdrugs == 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatalsodrugs)
merge m:1 fips using file_fatalscann_99
drop _merge
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace

clear
	
import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
merge m:1 st_case using file_drugsagain_99
keep if cannabinoid == 0 & otherdrugs == 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatalsnodrugs)
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace

clear
	
import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
merge m:1 st_case using file_dd_99
drop _merge
merge m:1 st_case using file_drugsagain_99
drop _merge
keep if dd == 0 & cannabinoid == 0 & otherdrugs == 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatalsnoimpair)
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace

clear
	
import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/PERSON.csv"
gen dd = 1 if (per_no == 1 & drinking == 1) | (per_no == 1 & inrange(alc_res, 0.001, 94.999))
gen cannabinoid = 1 if (per_no == 1 & inrange(drugres1, 600, 695)) | (per_no == 1 & inrange(drugres2, 600, 695)) | (per_no == 1 & inrange(drugres3, 600, 695))
gen ddweed = 1 if dd == 1 & cannabinoid == 1
collapse (sum) ddweed, by(st_case)
save file_ddweed_99, replace
	
clear
	
import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
merge m:1 st_case using file_ddweed_99
drop _merge
keep if ddweed > 0
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatalsddweed)
merge m:1 fips using file_depvar1999
drop _merge
save file_depvar1999, replace

clear

import delimited using "C:/dissertation/data/raw/fars/FARS1999NationalCSV/ACCIDENT.csv"
keep state st_case fatals
collapse (sum) fatals, by(state)
rename (state fatals) (fips fatalsall)
merge m:1 fips using file_depvar1999
drop _merge 
save file_depvar1999, replace

clear
	
use file_svaall
keep fips year Number AlcoholRelated
keep if year == 1999
rename (Number AlcoholRelated) (totsva alcsva)
merge m:1 fips using file_depvar1999
drop _merge 
save file_depvar1999, replace

clear

import excel using "C:/dissertation/data/raw/statepops/ST91-99est.xls"
drop in 1/3
keep A N
drop in 1
drop in 2/4
foreach var of varlist * {
	rename `var' `=`var'[1]'	
}
drop in 1
drop in 52/53
destring, replace
rename (FIPS Estimate) (fips state_pop)
merge m:1 fips using file_depvar1999
drop _merge 
save file_depvar1999, replace

gen fatalsdd_hunthou = (fatalsdd / state_pop) * 100000
gen fatalsodrugs_hunthou = (fatalsodrugs / state_pop) * 100000
gen fatalscann_hunthou = (fatalscann / state_pop) * 100000
replace fatalscann_hunthou = 0 if fatalscann_hunthou == .
replace fatalsodrugs_hunthou = 0 if fatalsodrugs_hunthou == .
gen fatalsnodd_hunthou = (fatalsnondd / state_pop) * 100000
gen fatalsbac0107_hunthou = (dd_bac0107 / state_pop) * 100000
gen fatalsbac08_hunthou = (dd_bac08 / state_pop) * 100000
gen fatalsbac10_hunthou = (dd_bac10 / state_pop) * 100000
gen fatalsnodrugs_hunthou = (fatalsnodrugs / state_pop) * 100000
gen fatalsall_hunthou = (fatalsall / state_pop) * 100000
gen fatalsnoimpair_hunthou = (fatalsnoimpair / state_pop) * 100000
gen totsva_hunthou = (totsva / state_pop) * 100000
gen alcsva_hunthou = (alcsva / state_pop) * 100000
gen noalcsva_hunthou = ((totsva - alcsva) / state_pop) * 100000
gen fatalsddweed_hunthou = (fatalsddweed / state_pop) * 100000
replace fatalsddweed_hunthou = 0 if fatalsddweed_hunthou == .
gen fatals4044_hunthou = (ddage_4044 / state_pop) * 100000
gen fatals4549_hunthou = (ddage_4549 / state_pop) * 100000
gen fatals50up_hunthou = (ddage_50up / state_pop) * 100000
gen fatals1519_hunthou = (ddage_1519 / state_pop) * 100000
gen fatals2024_hunthou = (ddage_2024 / state_pop) * 100000
gen fatals2529_hunthou = (ddage_2529 / state_pop) * 100000
gen fatals3034_hunthou = (ddage_3034 / state_pop) * 100000
gen fatals3539_hunthou = (ddage_3539 / state_pop) * 100000
save file_depvar1999, replace

clear
use file_marijuana3_0019
append using file_depvar1999
save file_marijuana3_9919, replace
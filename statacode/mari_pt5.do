* check directory *

* some MML stuff *

foreach yr in "90" "91" "92" "93" {
	clear

	import excel using "C:/dissertation/data/raw/statepops/detailedpops_9093.xlsx", sheet(stch-icen19`yr')
	foreach var of varlist * {
	rename `var' `=`var'[1]'
	}
	drop in 1 
	destring, replace

	gen fips = 1 if fips_stcnty < 2000
	foreach state in "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "43" "44" "45" "46" "47" "48" "49" "50" "51" "52" "53" "54" "55" "56" {
		replace fips = `state' if inrange(fips_stcnty, `state'000, `state'999)
}
	save file_detpop_`yr', replace

	collapse (sum) pop, by(age_grp fips)
	gen age_1519 = 1 if age_grp == 4
	gen age_2024 = 1 if age_grp == 5
	gen age_2529 = 1 if age_grp == 6
	gen age_3034 = 1 if age_grp == 7
	gen age_3539 = 1 if age_grp == 8
	gen age_4044 = 1 if age_grp == 9
	gen age_4549 = 1 if age_grp == 10
	gen age_5054 = 1 if age_grp == 11
	gen age_5559 = 1 if age_grp == 12
	gen age_6064 = 1 if age_grp == 13
	gen age_6569 = 1 if age_grp == 14
	gen age_7074 = 1 if age_grp == 15
	gen age_7579 = 1 if age_grp == 16
	gen age_8084 = 1 if age_grp == 17
	gen age_85up = 1 if age_grp == 18
	save file_detpop2_`yr', replace

	foreach group in "1519" "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		clear
	
		use file_detpop2_`yr', replace
		collapse (sum) pop, by(age_`group' fips)
		drop if age_`group' == .
		drop age_`group'
		rename pop age_`group'
		gen year = 19`yr'
		save file_popage`group'_`yr', replace
	}

	clear

	use file_popage1519_`yr'
	save file_popages_`yr', replace

	foreach group in "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		merge m:1 fips using file_popage`group'_`yr'
		drop _merge
		save file_popages_`yr', replace
	}
}

foreach yr in "94" "95" "96" "97" "98" "99" {
	clear

	import excel using "C:/dissertation/data/raw/statepops/detailedpops_9499.xlsx", sheet(stch-icen19`yr')
	foreach var of varlist * {
	rename `var' `=`var'[1]'
	}
	drop in 1 
	destring, replace

	gen fips = 1 if fips_stcnty < 2000
	foreach state in "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "43" "44" "45" "46" "47" "48" "49" "50" "51" "52" "53" "54" "55" "56" {
		replace fips = `state' if inrange(fips_stcnty, `state'000, `state'999)
}
	save file_detpop_`yr', replace

	collapse (sum) pop, by(age_grp fips)
	gen age_1519 = 1 if age_grp == 4
	gen age_2024 = 1 if age_grp == 5
	gen age_2529 = 1 if age_grp == 6
	gen age_3034 = 1 if age_grp == 7
	gen age_3539 = 1 if age_grp == 8
	gen age_4044 = 1 if age_grp == 9
	gen age_4549 = 1 if age_grp == 10
	gen age_5054 = 1 if age_grp == 11
	gen age_5559 = 1 if age_grp == 12
	gen age_6064 = 1 if age_grp == 13
	gen age_6569 = 1 if age_grp == 14
	gen age_7074 = 1 if age_grp == 15
	gen age_7579 = 1 if age_grp == 16
	gen age_8084 = 1 if age_grp == 17
	gen age_85up = 1 if age_grp == 18
	save file_detpop2_`yr', replace

	foreach group in "1519" "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		clear
	
		use file_detpop2_`yr', replace
		collapse (sum) pop, by(age_`group' fips)
		drop if age_`group' == .
		drop age_`group'
		rename pop age_`group'
		gen year = 19`yr'
		save file_popage`group'_`yr', replace
	}

	clear

	use file_popage1519_`yr'
	save file_popages_`yr', replace

	foreach group in "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		merge m:1 fips using file_popage`group'_`yr'
		drop _merge
		save file_popages_`yr', replace
	}
}

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" {
	clear

	import delimited using "C:/dissertation/data/raw/statepops/st-est00int-alldata.csv"
	drop region division
	drop if state == 0
	rename (state name) (fips state)
	keep if sex == 0 & origin == 0 & race == 0
	gen age_1519 = 1 if agegrp == 4
	gen age_2024 = 1 if agegrp == 5
	gen age_2529 = 1 if agegrp == 6
	gen age_3034 = 1 if agegrp == 7
	gen age_3539 = 1 if agegrp == 8
	gen age_4044 = 1 if agegrp == 9
	gen age_4549 = 1 if agegrp == 10
	gen age_5054 = 1 if agegrp == 11
	gen age_5559 = 1 if agegrp == 12
	gen age_6064 = 1 if agegrp == 13
	gen age_6569 = 1 if agegrp == 14
	gen age_7074 = 1 if agegrp == 15
	gen age_7579 = 1 if agegrp == 16
	gen age_8084 = 1 if agegrp == 17
	gen age_85up = 1 if agegrp == 18
	save file_detpops_0010, replace
	
	foreach group in "1519" "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		clear
	
		use file_detpops_0010
		collapse (sum) popestimate20`yr', by(age_`group' fips)
		drop if age_`group' == .
		drop age_`group'
		rename popestimate20`yr' age_`group'
		gen year = 20`yr'
		save file_popage`group'_`yr', replace
	}
	
	clear

	use file_popage1519_`yr'
	save file_popages_`yr', replace

	foreach group in "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		merge m:1 fips using file_popage`group'_`yr'
		drop _merge
		save file_popages_`yr', replace
	}
}

foreach yr in "11" "12" "13" "14" "15" "16" {
	clear

	import delimited using "C:/dissertation/data/raw/statepops/20`yr'/ACSST1Y20`yr'.S0101.csv"
	foreach var of varlist * {
		rename `var' `=`var'[1]'	
	}
	drop in 1
	gen fips = 1 if strpos(GEO_ID, "US01")
	foreach state in "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "43" "44" "45" "46" "47" "48" "49" "50" "51" "52" "53" "54" "55" "56" {
		replace fips = `state' if strpos(GEO_ID, "US`state'")
	}
	drop if fips == .
	destring, replace
	
	rename (S0101_C01_001E S0101_C01_005E S0101_C01_006E S0101_C01_007E S0101_C01_008E S0101_C01_009E S0101_C01_010E S0101_C01_011E S0101_C01_012E S0101_C01_013E S0101_C01_014E S0101_C01_015E S0101_C01_016E S0101_C01_017E S0101_C01_018E S0101_C01_019E) (state_pop pctage_1519 pctage_2024 pctage_2529 pctage_3034 pctage_3539 pctage_4044 pctage_4549 pctage_5054 pctage_5559 pctage_6064 pctage_6569 pctage_7074 pctage_7579 pctage_8084 pctage_85up)
	keep state_pop pctage_1519 pctage_2024 pctage_2529 pctage_3034 pctage_3539 pctage_4044 pctage_4549 pctage_5054 pctage_5559 pctage_6064 pctage_6569 pctage_7074 pctage_7579 pctage_8084 pctage_85up fips 
	gen year = 20`yr'
	foreach group in "1519" "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		gen age_`group' = state_pop * pctage_`group'
		drop pctage_`group'
		replace age_`group' = ceil(age_`group')
	}
	drop state_pop
	save file_popages_`yr', replace
}

foreach yr in "17" "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/statepops/20`yr'/ACSST1Y20`yr'.S0101.csv"
	foreach var of varlist * {
		rename `var' `=`var'[1]'	
	}
	drop in 1
		gen fips = 1 if strpos(GEO_ID, "US01")
	foreach state in "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39" "40" "41" "42" "43" "44" "45" "46" "47" "48" "49" "50" "51" "52" "53" "54" "55" "56" {
		replace fips = `state' if strpos(GEO_ID, "US`state'")
	}
	drop if fips == .
	destring, replace
	rename (S0101_C01_005E S0101_C01_006E S0101_C01_007E S0101_C01_008E S0101_C01_009E S0101_C01_010E S0101_C01_011E S0101_C01_012E S0101_C01_013E S0101_C01_014E S0101_C01_015E S0101_C01_016E S0101_C01_017E S0101_C01_018E S0101_C01_019E) (age_1519 age_2024 age_2529 age_3034 age_3539 age_4044 age_4549 age_5054 age_5559 age_6064 age_6569 age_7074 age_7579 age_8084 age_85up)
	keep age_1519 age_2024 age_2529 age_3034 age_3539 age_4044 age_4549 age_5054 age_5559 age_6064 age_6569 age_7074 age_7579 age_8084 age_85up fips
	gen year = 20`yr'
	save file_popages_`yr', replace
}

foreach yr in "90" "91" "92" "93" {
	clear
	
	use file_detpop_`yr'
	collapse (sum) pop, by(fips)
	rename pop state_pop
	merge m:1 fips using file_popages_`yr'
	drop _merge
	save file_mari_`yr', replace
}

foreach yr in "94" "95" "96" "97" "98" "99" {
	clear
	
	use file_difc_19`yr'
	drop Number group1 group2
	merge m:1 fips using file_popages_`yr'
	drop _merge
	save file_mari_`yr', replace
}

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_difc_20`yr'
	drop Number group1 group2
	merge m:1 fips using file_popages_`yr'
	drop _merge
	save file_mari_`yr', replace
}

foreach yr in "90" "91" "92" "93" "94" "95" "96" "97" "98" "99" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS19`yr'NationalCSV/PERSON.csv"
	replace drinking = . if drinking == 8 | drinking == 9
	gen fatal = 1 if inrange(death_mo, 1, 12)
	gen fatal_alc = fatal * drinking
	gen age_1519 = 1 if inrange(age, 15, 19)
	foreach decade in "2" "3" "4" "5" "6" "7" {
		gen age_`decade'0`decade'4 = 1 if inrange(age, `decade'0, `decade'4)
		gen age_`decade'5`decade'9 = 1 if inrange(age, `decade'5, `decade'9)
	}
	gen age_8084 = 1 if inrange(age, 80, 84)
	gen age_85up = 1 if age >= 85 
	foreach group in "1519" "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		gen fatal_age`group' = fatal * age_`group'
		gen fatalalc_age`group' = fatal_alc * age_`group'
	}
	save file_farsperson_`yr', replace
	
	clear
	
	use file_farsperson_`yr'
	collapse (sum) fatal fatal_alc, by(state)
	rename state fips
	merge m:1 fips using file_mari_`yr'
	drop _merge
	save file_mari_`yr', replace
	
	foreach group in "1519" "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		clear
		
		use file_farsperson_`yr'
		collapse (sum) age_`group' fatal_age`group' fatalalc_age`group', by(state)
		rename (state age_`group') (fips inv_age`group')
		merge m:1 fips using file_mari_`yr'
		drop _merge
		save file_mari_`yr', replace
	}
}

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	replace drinking = . if drinking == 8 | drinking == 9
	gen fatal = 1 if inrange(death_mo, 1, 12)
	gen fatal_alc = fatal * drinking
	gen age_1519 = 1 if inrange(age, 15, 19)
	foreach decade in "2" "3" "4" "5" "6" "7" {
		gen age_`decade'0`decade'4 = 1 if inrange(age, `decade'0, `decade'4)
		gen age_`decade'5`decade'9 = 1 if inrange(age, `decade'5, `decade'9)
	}
	gen age_8084 = 1 if inrange(age, 80, 84)
	gen age_85up = 1 if age >= 85 
	foreach group in "1519" "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		gen fatal_age`group' = fatal * age_`group'
		gen fatalalc_age`group' = fatal_alc * age_`group'
	}
	save file_farsperson_`yr', replace
	
	clear
	
	use file_farsperson_`yr'
	collapse (sum) fatal fatal_alc, by(state)
	rename state fips
	merge m:1 fips using file_mari_`yr'
	drop _merge
	save file_mari_`yr', replace
	
	foreach group in "1519" "2024" "2529" "3034" "3539" "4044" "4549" "5054" "5559" "6064" "6569" "7074" "7579" "8084" "85up" {
		clear
		
		use file_farsperson_`yr'
		collapse (sum) age_`group' fatal_age`group' fatalalc_age`group', by(state)
		rename (state age_`group') (fips inv_age`group')
		merge m:1 fips using file_mari_`yr'
		drop _merge
		save file_mari_`yr', replace
	}
}

clear

use file_mari_00
save file_marigroups, replace
set seed 12345
generate rannum = uniform()
egen rml_group = cut(rannum), group(3)
replace rml_group = 0 if State == "Colorado" | State == "Washington"
replace rml_group = 1 if State == "Alaska" | State == "Oregon" | State == "DC"
replace rml_group = 2 if State == "California" | State == "Maine" | State == "Massachusetts" | State == "Nevada"
egen mml_group = cut(rannum), group(14)
replace mml_group = 0 if State == "California"
replace mml_group = 1 if State == "Alaska" | State == "Oregon" | State == "Washington"
replace mml_group = 2 if State == "Maine"
replace mml_group = 3 if State == "Hawaii" | State == "Colorado" | State == "Nevada"
replace mml_group = 4 if State == "Montana" | State == "Vermont"
replace mml_group = 5 if State == "RhodeIsland"
replace mml_group = 6 if State == "NewMexico"
replace mml_group = 7 if State == "Michigan"
replace mml_group = 8 if State == "NewJersey" | State == "DC" | State == "Arizona"
replace mml_group = 9 if State == "Delaware"
replace mml_group = 10 if State == "Connecticut" | State == "Massachusetts"
replace mml_group = 11 if State == "NewHampshire" | State == "Illinois"
replace mml_group = 12 if State == "Maryland" | State == "Minnesota" | State == "NewYork"
replace mml_group = 13 if State == "Pennsylvania" | State == "Ohio" | State == "Arkansas" | State == "Florida" | State == "NorthDakota"
keep fips rml_group mml_group
save file_marigroups, replace

foreach yr in "90" "91" "92" "93" "94" "95" "96" "97" "98" "99" "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_mari_`yr'
	merge m:1 fips using file_marigroups
	drop _merge
	save file_mari_`yr', replace
}

clear

use file_mari_90
save file_marijuana, replace
foreach yr in "91" "92" "93" "94" "95" "96" "97" "98" "99" "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	append using file_mari_`yr'
	save file_marijuana, replace
}
drop pop
save file_marijuana, replace

gen rml_treat = 1 if State == "Alaska" | State == "California" | State == "Colorado" | State == "DC" | State == "Maine" | State == "Massachusetts" | State == "Michigan" | State == "Nevada" | State == "Oregon" | State == "Vermont" | State == "Washington"
* maybe drop MI and VT for analysis or graphs *
* replace rml_treat = . if State == "Michigan" | State == "Vermont"
replace rml_treat = 0 if rml_treat == .
gen mml_treat = 1 if State == "California" | State == "Alaska" | State == "Oregon" | State == "Washington" | State == "Maine" | State == "Hawaii" | State == "Colorado" | State == "Nevada" | State == "Montana" | State == "Vermont" | State == "RhodeIsland" | State == "NewMexico" | State == "Michigan" | State == "NewJersey" | State == "DC" | State == "Arizona" | State == "Delaware" | State == "Connecticut" | State == "Massachusetts" | State == "NewHampshire" | State == "Illinois" | State == "Maryland" | State == "Minnesota" | State == "NewYork" | State == "Pennsylvania" | State == "Ohio" | State == "Arkansas" | State == "Florida" | State == "NorthDakota" | State == "WestVirginia" | State == "Oklahoma"
* maybe drop WV and OK for analysis or graphs *
* replace mml_treat = . if State == "WestVirginia" | State == "Oklahoma"
replace mml_treat = 0 if mml_treat == .
save file_marijuana, replace

foreach prd in "22" "21" "20" "19" "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	gen period_`prd'_rml = 1 if year == (2012 - `prd') & rml_group == 0
	replace period_`prd'_rml = 1 if year == (2014 - `prd') & rml_group == 1
	replace period_`prd'_rml = 1 if year == (2016 - `prd') & rml_group == 2
	replace period_`prd'_rml = 0 if period_`prd'_rml != 1
}
foreach prd in "0" "1" "2" "3" {
	gen period`prd'_rml = 1 if year == (2012 + `prd') & rml_group == 0
	replace period`prd'_rml = 1 if year == (2014 + `prd') & rml_group == 1
	replace period`prd'_rml = 1 if year == (2016 + `prd') & rml_group == 2
	replace period`prd'_rml = 0 if period`prd'_rml != 1
}
foreach prd in "6" "5" "4" "3" "2" "1" {
	gen period_`prd'_mml = 1 if year == (1996 - `prd') & mml_group == 0
	replace period_`prd'_mml = 1 if year == (1998 - `prd') & mml_group == 1
	replace period_`prd'_mml = 1 if year == (1999 - `prd') & mml_group == 2
	replace period_`prd'_mml = 1 if year == (2000 - `prd') & mml_group == 3
	replace period_`prd'_mml = 1 if year == (2004 - `prd') & mml_group == 4
	replace period_`prd'_mml = 1 if year == (2006 - `prd') & mml_group == 5
	replace period_`prd'_mml = 1 if year == (2007 - `prd') & mml_group == 6
	replace period_`prd'_mml = 1 if year == (2008 - `prd') & mml_group == 7
	replace period_`prd'_mml = 1 if year == (2010 - `prd') & mml_group == 8
	replace period_`prd'_mml = 1 if year == (2011 - `prd') & mml_group == 9
	replace period_`prd'_mml = 1 if year == (2012 - `prd') & mml_group == 10
	replace period_`prd'_mml = 1 if year == (2013 - `prd') & mml_group == 11
	replace period_`prd'_mml = 1 if year == (2014 - `prd') & mml_group == 12
	replace period_`prd'_mml = 1 if year == (2016 - `prd') & mml_group == 13
	replace period_`prd'_mml = 0 if period_`prd'_mml != 1
}
foreach prd in "0" "1" "2" "3" {
	gen period`prd'_mml = 1 if year == (1996 + `prd') & mml_group == 0
	replace period`prd'_mml = 1 if year == (1998 + `prd') & mml_group == 1
	replace period`prd'_mml = 1 if year == (1999 + `prd') & mml_group == 2
	replace period`prd'_mml = 1 if year == (2000 + `prd') & mml_group == 3
	replace period`prd'_mml = 1 if year == (2004 + `prd') & mml_group == 4
	replace period`prd'_mml = 1 if year == (2006 + `prd') & mml_group == 5
	replace period`prd'_mml = 1 if year == (2007 + `prd') & mml_group == 6
	replace period`prd'_mml = 1 if year == (2008 + `prd') & mml_group == 7
	replace period`prd'_mml = 1 if year == (2010 + `prd') & mml_group == 8
	replace period`prd'_mml = 1 if year == (2011 + `prd') & mml_group == 9
	replace period`prd'_mml = 1 if year == (2012 + `prd') & mml_group == 10
	replace period`prd'_mml = 1 if year == (2013 + `prd') & mml_group == 11
	replace period`prd'_mml = 1 if year == (2014 + `prd') & mml_group == 12
	replace period`prd'_mml = 1 if year == (2016 + `prd') & mml_group == 13
	replace period`prd'_mml = 0 if period`prd'_mml != 1
}
save file_marijuana, replace

gen age_2039 = age_2024 + age_2529 + age_3034 + age_3539
gen inv_age2039 = inv_age2024 + inv_age2529 + inv_age3034 + inv_age3539
gen age_40up = age_4044 + age_4549 + age_5054 + age_5559 + age_6064 + age_6569 + age_7074 + age_7579 + age_8084 + age_85up
gen inv_age40up = inv_age4044 + inv_age4549 + inv_age5054 + inv_age5559 + inv_age6064 + inv_age6569 + inv_age7074 + inv_age7579 + inv_age8084 + inv_age85up
foreach group in "1519" "2039" "40up" {
	gen inv_age`group'_pc = inv_age`group' / age_`group'
	gen inv_age`group'_000 = inv_age`group'_pc * 1000
}
foreach thing in "fatal" "fatalalc" {
	gen `thing'_age2039 = `thing'_age2024 + `thing'_age2529 + `thing'_age3034 + `thing'_age3539
	gen `thing'_age40up = `thing'_age4044 + `thing'_age4549 + `thing'_age5054 + `thing'_age5559 + `thing'_age6064 + `thing'_age6569 + `thing'_age7074 + `thing'_age7579 + `thing'_age8084 + `thing'_age85up
	foreach group in "1519" "2039" "40up" {
		gen `thing'_age`group'_pc = `thing'_age`group' / age_`group'
		gen `thing'_age`group'_000 = `thing'_age`group'_pc * 1000
	}
}
gen fatal_pc = fatal / state_pop
gen fatal_000 = fatal_pc * 1000
gen fatalalc_pc = fatal_alc / state_pop
gen fatalalc_000 = fatalalc_pc * 1000
save file_marijuana, replace

clear

use file_marijuana
replace rml_treat = . if State == "Michigan" | State == "Vermont"
keep if rml_treat == 1
xtset fips year
xtreg fatalalc_000 period_22_rml period_21_rml period_20_rml period_19_rml period_18_rml period_17_rml period_16_rml period_15_rml period_14_rml period_13_rml period_12_rml period_11_rml period_10_rml period_9_rml period_8_rml period_7_rml period_6_rml period_5_rml period_4_rml period_3_rml period_2_rml period_1_rml period0_rml period1_rml period2_rml period3_rml, fe
regsave using ptrends_rmltreat, replace

clear

use file_marijuana
replace rml_treat = . if State == "Michigan" | State == "Vermont"
keep if rml_treat == 0
xtset fips year
xtreg fatalalc_000 period_22_rml period_21_rml period_20_rml period_19_rml period_18_rml period_17_rml period_16_rml period_15_rml period_14_rml period_13_rml period_12_rml period_11_rml period_10_rml period_9_rml period_8_rml period_7_rml period_6_rml period_5_rml period_4_rml period_3_rml period_2_rml period_1_rml period0_rml period1_rml period2_rml period3_rml, fe
regsave using ptrends_rmlcont, replace

clear

use file_marijuana
replace mml_treat = . if State == "WestVirginia" | State == "Oklahoma"
keep if mml_treat == 1
xtset fips year
xtreg fatalalc_000 period_6_mml period_5_mml period_4_mml period_3_mml period_2_mml period_1_mml period0_mml period1_mml period2_mml period3_mml, fe
regsave using ptrends_mmltreat, replace

clear

use file_marijuana
replace mml_treat = . if State == "WestVirginia" | State == "Oklahoma"
keep if mml_treat == 0
xtset fips year
xtreg fatalalc_000 period_6_mml period_5_mml period_4_mml period_3_mml period_2_mml period_1_mml period0_mml period1_mml period2_mml period3_mml, fe
regsave using ptrends_mmlcont, replace

clear
use ptrends_rmltreat
gen cons = 0.01304416
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_rmltreat1, replace

clear
use ptrends_rmlcont
gen cons = 0.02588966
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_rmltreat1
drop _merge
save file_rmlptrends_fatal, replace

foreach prd in "22" "21" "20" "19" "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'_rml"
}
foreach prd in "0" "1" "2" "3" {
	replace period = "`prd'" if period == "period`prd'_rml"
}
destring, replace
save file_rmlptrends_fatal, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
scatter treatment control period, connect(l l)
graph export "C:/dissertation/misc/graph_rmlfatalalc_tot.pdf"

clear
use ptrends_mmltreat
gen cons = 0.02311133
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_mmltreat1, replace

clear
use ptrends_mmlcont
gen cons = 0.03454691
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_mmltreat1
drop _merge
save file_mmlptrends_fatal, replace

foreach prd in "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'_mml"
}
foreach prd in "0" "1" "2" "3" {
	replace period = "`prd'" if period == "period`prd'_mml"
}
destring, replace
save file_mmlptrends_fatal, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
scatter treatment control period, connect(l l)
graph export "C:/dissertation/misc/graph_mmlfatalalc_tot.pdf"

*********

clear

use file_marijuana
replace rml_treat = . if State == "Michigan" | State == "Vermont"
keep if rml_treat == 1
xtset fips year
xtreg fatalalc_age1519_000 period_22_rml period_21_rml period_20_rml period_19_rml period_18_rml period_17_rml period_16_rml period_15_rml period_14_rml period_13_rml period_12_rml period_11_rml period_10_rml period_9_rml period_8_rml period_7_rml period_6_rml period_5_rml period_4_rml period_3_rml period_2_rml period_1_rml period0_rml period1_rml period2_rml period3_rml, fe
regsave using ptrends_rmltreat_1519, replace

clear

use file_marijuana
replace rml_treat = . if State == "Michigan" | State == "Vermont"
keep if rml_treat == 0
xtset fips year
xtreg fatalalc_age1519_000 period_22_rml period_21_rml period_20_rml period_19_rml period_18_rml period_17_rml period_16_rml period_15_rml period_14_rml period_13_rml period_12_rml period_11_rml period_10_rml period_9_rml period_8_rml period_7_rml period_6_rml period_5_rml period_4_rml period_3_rml period_2_rml period_1_rml period0_rml period1_rml period2_rml period3_rml, fe
regsave using ptrends_rmlcont_1519, replace

clear

use file_marijuana
replace mml_treat = . if State == "WestVirginia" | State == "Oklahoma"
keep if mml_treat == 1
xtset fips year
xtreg fatalalc_age1519_000 period_6_mml period_5_mml period_4_mml period_3_mml period_2_mml period_1_mml period0_mml period1_mml period2_mml period3_mml, fe
regsave using ptrends_mmltreat_1519, replace

clear

use file_marijuana
replace mml_treat = . if State == "WestVirginia" | State == "Oklahoma"
keep if mml_treat == 0
xtset fips year
xtreg fatalalc_age1519_000 period_6_mml period_5_mml period_4_mml period_3_mml period_2_mml period_1_mml period0_mml period1_mml period2_mml period3_mml, fe
regsave using ptrends_mmlcont_1519, replace

clear
use ptrends_rmltreat_1519
gen cons = 0.00766348
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_rmltreat1_1519, replace

clear
use ptrends_rmlcont_1519
gen cons = 0.00897096
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_rmltreat1_1519
drop _merge
save file_rmlptrends_fatalalc_1519, replace

foreach prd in "22" "21" "20" "19" "18" "17" "16" "15" "14" "13" "12" "11" "10" "9" "8" "7" "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'_rml"
}
foreach prd in "0" "1" "2" "3" {
	replace period = "`prd'" if period == "period`prd'_rml"
}
destring, replace
save file_rmlptrends_fatalalc_1519, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
drop if period < -5
scatter treatment control period, connect(l l)
graph export "C:/dissertation/misc/graph_rmlfatalalc_1519.pdf"

clear
use ptrends_mmltreat_1519
gen cons = 0.02136932
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save ptrends_mmltreat1_1519, replace

clear
use ptrends_mmlcont_1519
gen cons = 0.02709259
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control

merge m:1 period using ptrends_mmltreat1_1519
drop _merge
save file_mmlptrends_fatalalc_1519, replace

foreach prd in "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'_mml"
}
foreach prd in "0" "1" "2" "3" {
	replace period = "`prd'" if period == "period`prd'_mml"
}
destring, replace
save file_mmlptrends_fatalalc_1519, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
scatter treatment control period, connect(l l)
graph export "C:/dissertation/misc/graph_mmlfatalalc_tot.pdf"


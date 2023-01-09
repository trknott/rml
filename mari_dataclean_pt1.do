* check directory *

clear
use file_marijuana

* decriminalized marijuana *
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
save file_marijuana, replace

* minimum DUI BAC of 0.08 *
gen bac08_law = 1 if (State == "Alabama" & year >= 1995) | (State == "Arizona" & year >= 2001) | (State == "Arkansas" & year >= 2001) | (State == "California" & year >= 1990) | (State == "Colorado" & year >= 2004) | (State == "Connecticut" & year >= 2002) | (State == "Delaware" & year >= 2004) | (State == "Florida" & year >= 1994) | (State == "Georgia" & year >= 2001) | (State == "Idaho" & year >= 1997) | (State == "Illinois" & year >= 1997) | (State == "Indiana" & year >= 2001) | (State == "Iowa" & year >= 2003) | (State == "Kansas" & year >= 1988) | (State == "Kentucky" & year >= 2000) | (State == "Louisiana" & year >= 2003) | (State == "Maine" & year >= 1988) | (State == "Maryland" & year >= 2001) | (State == "Massachusetts" & year >= 2003) | (State == "Michigan" & year >= 2003) | (State == "Minnesota" & year >= 2005) | (State == "Mississippi" & year >= 2002) | (State == "Missouri" & year >= 2001) | (State == "Montana" & year >= 2003) | (State == "Nebraska" & year >= 2001) | (State == "Nevada" & year >= 2003) | (State == "NewHampshire" & year >= 1994) | (State == "NewJersey" & year >= 2004) | (State == "NewMexico" & year >= 1994) | (State == "NewYork" & year >= 2003) | (State == "NorthCarolina" & year >= 1993) | (State == "NorthDakota" & year >= 2003) | (State == "Ohio" & year >= 2003) | (State == "Oklahoma" & year >= 2001) | (State == "Oregon" & year >= 1983) | (State == "Pennsylvania" & year >= 2003) | (State == "RhodeIsland" & year >= 2003) | (State == "SouthCarolina" & year >= 2003) | (State == "SouthDakota" & year >= 2002) | (State == "Tennessee" & year >= 2003) | (State == "Texas" & year >= 1999) | (State == "Utah" & year >= 1983) | (State == "Vermont" & year >= 1991) | (State == "Virginia" & year >= 1994) | (State == "Washington" & year >= 1999) | (State == "WestVirginia" & year >= 2004) | (State == "Wisconsin" & year >= 2003) | (State == "Wyoming" & year >= 2002) | (State == "DC" & year >= 1999)
replace bac08_law = 0 if bac08_law == .
save file_marijuana, replace

* median age *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" {
	foreach state in "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "DC" "Delaware" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
		clear
		
		import excel using "C:/dissertation/data/raw/statepops/`state'_0009.xls"
		drop in 1/3
		drop B M N
		drop in 1
		rename (A C D E F G H I J K L) (cat y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009) 
		keep if cat == ".Median age (years)"
		drop in 2/3
		keep y20`yr'
		rename y20`yr' med_age
		gen State = "`state'"
		gen year = 20`yr'
		save file_medage_`state'`yr', replace
	}
	
	clear
	
	use file_medage_Alabama`yr'
	save file_medage_`yr', replace
	foreach state in "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "DC" "Delaware" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
		append using file_medage_`state'`yr'
		save file_medage_`yr', replace
	}
}

foreach yr in "10" "11" "12" "13" "14" "15" "16" {
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
	rename S0101_C01_030E med_age
	keep fips med_age
	gen year = 20`yr'
	save file_medage_`yr', replace
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
	rename S0101_C01_032E med_age
	keep fips med_age
	gen year = 20`yr'
	save file_medage_`yr', replace
}

* income *
foreach yr in "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear

	import excel using "C:/dissertation/data/raw/stateunemp/stateincome0819.xls"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1 
	destring, replace
	keep State y20`yr'
	rename y20`yr' rpc_income
	gen year = 20`yr'
	drop if State == ""
	save file_income_`yr', replace
}

* unemployment *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	foreach state in "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "DC" "Delaware" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
		clear
		
		import excel using "C:/dissertation/data/raw/stateunemp/`state'.xlsx"
		drop in 1/11
		foreach var of varlist * {
			rename `var' `=`var'[1]'
		}
		drop in 1 
		destring, replace
		egen urate = rmean(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
		gen State = "`state'"
		keep State Year urate
		keep if Year == 20`yr'
		save file_urate_`state'`yr', replace
	}
	
	clear
	
	use file_urate_Alabama`yr'
	save file_urate_`yr', replace
	foreach state in "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "DC" "Delaware" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
		append using file_urate_`state'`yr'
		save file_urate_`yr', replace
	}
}

* vehicle miles traveled *
foreach yr in "00" "01" "02" "03" "04" "05" "07" "08" {
	clear
	
	import excel using "C:/dissertation/data/raw/statemiles/20`yr'.xls"
	drop in 1/6
	drop in 2
	keep A P
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1 
	destring, replace
	rename (STATE TOTAL) (State vehmiles)
	gen year = 20`yr'
	drop in 53/57
	save file_vehmiles_`yr', replace
}

foreach yr in "09" "10" "13" {
	clear
	
	import excel using "C:/dissertation/data/raw/statemiles/20`yr'.xls"
	drop in 1/6
	drop in 2
	keep A R
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1 
	destring, replace
	rename (STATE TOTAL) (State vehmiles)
	gen year = 20`yr'
	drop in 52/56
	save file_vehmiles_`yr', replace
}

foreach yr in "11" "12" "14" "15" "16" "17" "18" "19" {
	clear
	
	import excel using "C:/dissertation/data/raw/statemiles/misc_years.xlsx", sheet(20`yr')
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1 
	destring, replace
	gen year = 20`yr'
	save file_vehmiles_`yr', replace
}

foreach yr in "00" "01" "02" "03" "04" "05" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_vehmiles_`yr'
	drop if State == "" | State == "U.S. Total"
	replace State = "DC" if State == "Dist. of Columbia"
	replace State = "NewHampshire" if State == "New Hampshire" | State == "New Hampshire  2/"
	replace State = "NewJersey" if State == "New Jersey"
	replace State = "NewMexico" if State == "New Mexico"
	replace State = "NewYork" if State == "New York" | State == "New York  3/"
	replace State = "NorthCarolina" if State == "North Carolina" | State == "North Carolina  3/"
	replace State = "NorthDakota" if State == "North Dakota"
	replace State = "RhodeIsland" if State == "Rhode Island"
	replace State = "SouthCarolina" if State == "South Carolina"
	replace State = "SouthDakota" if State == "South Dakota"
	replace State = "WestVirginia" if State == "West Virginia"
	replace State = "California" if State == "California  2/"
	replace State = "Missouri" if State == "Missouri  3/"
	replace State = "Oklahoma" if State == "Oklahoma "
	replace State = "Indiana" if State == "Indiana  2/" | State == "Indiana  2/  3/"
	replace State = "Nevada" if State == "Nevada  2/"
	replace State = "Minnesota" if State == "Minnesota  3/" 
	replace State = "Texas" if State == "Texas  3/"
	drop if State == "Monitoring System."
	replace State = "Arizona" if State == "Arizona  2/"
	save file_vehmiles_`yr', replace
}

* speed limit 70+ *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/ACCIDENT.csv"
	gen speed70 = 1 if sp_limit >= 70
	collapse speed70, by(state)
	replace speed70 = 1 if speed70 > 0
	rename state fips
	gen year = 20`yr'
	save file_speed_`yr', replace
}

foreach yr in "10" "11" "12" "13" "14" "15" "16" "17" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/VEHICLE.csv"
	gen speed70 = 1 if inrange(vspd_lim, 70, 97)
	collapse speed70, by(state)
	replace speed70 = 1 if speed70 > 0
	rename state fips
	gen year = 20`yr'
	save file_speed_`yr', replace
}

foreach yr in "18" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/Vehicle.csv"
	gen speed70 = 1 if vspd_lim == "70" | vspd_lim == "75" | vspd_lim == "80" | vspd_lim == "85" | vspd_lim == "90" | vspd_lim == "95"
	collapse speed70, by(state)
	replace speed70 = 1 if speed70 > 0
	rename state fips
	gen year = 20`yr'
	save file_speed_`yr', replace
}

* BAC results *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen bac01_result = 1 if inrange(alc_res, 0.001, 94)
	gen bac08_result = 1 if inrange(alc_res, 8, 94)
	gen bac10_result = 1 if inrange(alc_res, 10, 94)
	gen fatal = 1 if inrange(death_mo, 1, 12)
	gen fbac01 = fatal * bac01_result
	gen fbac08 = fatal * bac08_result
	gen fbac10 = fatal * bac10_result
	collapse (sum) bac01_result bac08_result bac10_result fbac01 fbac08 fbac10, by(state)
	gen year = 20`yr'
	save file_bacres_`yr', replace
}

foreach yr in "15" "16" "17" "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen bac01_result = 1 if inrange(alc_res, 0.001, 940)
	gen bac08_result = 1 if inrange(alc_res, 80, 940)
	gen bac10_result = 1 if inrange(alc_res, 100, 940)
	gen fatal = 1 if inrange(death_mo, 1, 12)
	gen fbac01 = fatal * bac01_result
	gen fbac08 = fatal * bac08_result
	gen fbac10 = fatal * bac10_result
	collapse (sum) bac01_result bac08_result bac10_result fbac01 fbac08 fbac10, by(state)
	gen year = 20`yr'
	save file_bacres_`yr', replace
}

* merging datafiles *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" {
	clear
	
	use file_mari_`yr'
	merge m:1 State using file_medage_`yr'
	drop _merge
	*merge m:1 State using file_income_`yr'
	*drop _merge
	merge m:1 State using file_urate_`yr'
	drop _merge
	*merge m:1 State using file_vehmiles_`yr'
	*drop _merge
	merge m:1 fips using file_speed_`yr'
	drop _merge
	save file_mari_`yr', replace
}

foreach yr in "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_mari_`yr'
	merge m:1 fips using file_medage_`yr'
	drop _merge
	*merge m:1 State using file_income_`yr'
	*drop _merge
	merge m:1 State using file_urate_`yr'
	drop _merge
	*merge m:1 State using file_vehmiles_`yr'
	*drop _merge
	merge m:1 fips using file_speed_`yr'
	drop _merge
	save file_mari_`yr', replace
}

foreach yr in "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_mari_`yr'
	merge m:1 State using file_income_`yr'
	drop _merge
	save file_mari_`yr', replace
}

foreach yr in "00" "01" "02" "03" "04" "05" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_mari_`yr'
	drop vehmiles
	drop if fips == .
	merge m:1 State using file_vehmiles_`yr'
	drop _merge
	save file_mari_`yr', replace
}

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_bacres_`yr'
	rename state fips
	drop if fips == .
	merge m:1 fips using file_mari_`yr'
	drop _merge
	drop if fips == .
	save file_mari_`yr', replace
}

* re-do treatment groups *
clear

use file_mari_00
drop rml_group mml_group
save file_marigroups2, replace
set seed 12345
generate rannum = uniform()
egen rml_group = cut(rannum), group(4)
replace rml_group = 0 if State == "Colorado" | State == "Washington"
replace rml_group = 1 if State == "Alaska" | State == "Oregon" | State == "DC"
replace rml_group = 2 if State == "California" | State == "Maine" | State == "Massachusetts" | State == "Nevada"
replace rml_group = 3 if State == "Michigan" | State == "Vermont"
keep State rml_group
save file_marigroups2, replace

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_mari_`yr'
	drop rml_group mml_group
	merge m:1 State using file_marigroups2
	drop _merge
	save file_mari_`yr', replace
}
	
* more alc *
foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	import delimited using "C:/dissertation/data/raw/fars/FARS20`yr'NationalCSV/PERSON.csv"
	gen noalc = 1 if alc_res == 0
	replace noalc = 1 if alc_res > 94 & drinking == 0
	gen fatal = 1 if inrange(death_mo, 1, 12)
	gen fatal_noalc = fatal * noalc
	collapse noalc fatal_noalc, by(state)
	rename state fips
	save file_noalc_`yr', replace
}

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_mari_`yr'
	merge m:1 fips using file_noalc_`yr'
	drop _merge
	save file_mari_`yr', replace
}

foreach yr in "00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	clear
	
	use file_sva20`yr'
	rename (state Number AlcoholRelated) (State fsva fsva_alc)
	keep State fips fsva fsva_alc year
	save file_sva20`yr', replace
	
	clear
	
	use file_mari_`yr'
	rename state State
	merge m:1 State using file_sva20`yr'
	drop _merge
	save file_mari_`yr', replace
}

*******

foreach yr in "17" "18" "19" {
	clear
	
	use file_mari_`yr'
	drop med_age
	merge m:1 fips using file_medage_`yr'
	drop _merge
	save file_mari_`yr', replace
}
clear

foreach yr in "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	import excel using "C:/dissertation/data/raw/cofars`yr'.xlsx"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	replace AlcoholRelated = "." if AlcoholRelated == "NA"
	replace PercentAlcoholRelated = "." if PercentAlcoholRelated == "NA"
	destring, replace
	gen state = "CO"
	gen year = 20`yr'
	save file_cofars`yr', replace
	
	clear
	import excel using "C:/dissertation/data/raw/iofars`yr'.xlsx"
	foreach var of varlist * {
		rename `var' `=`var'[1]'
	}
	drop in 1
	replace AlcoholRelated = "." if AlcoholRelated == "NA"
	replace PercentAlcoholRelated = "." if PercentAlcoholRelated == "NA"
	destring, replace
	gen state = "IO"
	gen year = 20`yr'
	save file_iofars`yr', replace
	
	clear
}

use file_cofars05
save file_coiofars, replace
foreach yr in "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	append using file_cofars`yr'
	save file_coiofars, replace
}
foreach yr in "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" {
	append using file_iofars`yr'
	save file_coiofars, replace
}
keep if FieldDesc == "Total"

export excel using "C:/dissertation/data/raw/coiofars.xlsx", firstrow(var)

clear

import excel using "C:/dissertation/data/raw/coiofars2.xlsx"
foreach var of varlist * {
	rename `var' `=`var'[1]'
}
drop in 1
destring, replace

scatter co_pct io_pct year, connect(l l)
graph export "C:/dissertation/data/code/coiofars.pdf"
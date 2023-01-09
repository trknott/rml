* check directory *

* fatal single-vehicle accidents DID *

clear

use file_svaall
gen prepost = 1 if group2 == 0 & year >= 2012
replace prepost = 1 if group2 == 1 & year >= 2014
replace prepost = 1 if group2 == 2 & year >= 2016
replace prepost = 0 if prepost == . & treatment != .
replace prepost = . if prepost == 1 & treatment == .
save file_svaall, replace

drop if state == "Michigan" | state == "Vermont"
tsset fips year

reghdfe sva000 treatment##prepost, noabsorb
reghdfe sva000 treatment##prepost, absorb(fips year) noconstant

* drivers involved in fatal crashes (total) DID *

clear

use file_difc_all
gen prepost = 1 if group2 == 0 & year >= 2012
replace prepost = 1 if group2 == 1 & year >= 2014
replace prepost = 1 if group2 == 2 & year >= 2016
replace prepost = 0 if prepost == . & treatment != .
replace prepost = . if prepost == 1 & treatment == .
save file_difc_all, replace

drop if State == "Michigan" | State == "Vermont"
tsset fips year

reghdfe difc000 treatment##prepost, noabsorb
reghdfe difc000 treatment##prepost, absorb(fips year) noconstant

*drivers involved in fatal crashes (high BAC) DID *

clear

use file_dbac_all
gen prepost = 1 if group2 == 0 & year >= 2012
replace prepost = 1 if group2 == 1 & year >= 2014
replace prepost = 1 if group2 == 2 & year >= 2016
replace prepost = 0 if prepost == . & treatment != .
replace prepost = . if prepost == 1 & treatment == .
save file_dbac_all, replace

drop if State == "Michigan" | State == "Vermont"
tsset fips year

reghdfe dbac000 treatment##prepost, noabsorb
reghdfe dbac000 treatment##prepost, absorb(fips year) noconstant

* persons killed (high driver BAC) DID *

clear

use file_pbac_all
gen prepost = 1 if group2 == 0 & year >= 2012
replace prepost = 1 if group2 == 1 & year >= 2014
replace prepost = 1 if group2 == 2 & year >= 2016
replace prepost = 0 if prepost == . & treatment != .
replace prepost = . if prepost == 1 & treatment == .
save file_pbac_all, replace

drop if State == "Michigan" | State == "Vermont"
tsset fips year

reghdfe pbac000 treatment##prepost, noabsorb
reghdfe pbac000 treatment##prepost, absorb(fips year) noconstant
* some more robustness stuff *

clear

use file_marijuana3_0019
gen control2 = 1 if State == "Idaho" | State == "Indiana" | State == "Iowa" | State == "Kansas" | State == "Kentucky" | State == "SouthCarolina" | State == "Tennessee" | State == "Texas" | State == "Wyoming"
keep if control2 == 1 | rml_treat == 1 
save file_mari3_robustc, replace

reghdfe fatalscann_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsodrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsddweed_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsnoimpair_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac0107_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac08_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac10_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals1519_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals2024_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals2529_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals3034_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals3539_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals4044_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals4549_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals50up_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe totsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe alcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe noalcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)

***************

clear

use file_marijuana3_0019
gen control2 = 1 if State == "Idaho" | State == "Indiana" | State == "Iowa" | State == "Kansas" | State == "Kentucky" | State == "SouthCarolina" | State == "Tennessee" | State == "Texas" | State == "Wyoming"
keep if control2 == 1 | (rml_treat == 1 & rml_group == 0)
replace rml_prepost = 1 if year >= 2012
replace rml_prepost = 0 if year < 2012
save file_mari3_robust0, replace

reghdfe fatalscann_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsodrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsddweed_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsnoimpair_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac0107_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac08_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac10_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals1519_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals2024_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals2529_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals3034_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals3539_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals4044_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals4549_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals50up_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe totsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe alcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe noalcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)

clear

use file_marijuana3_0019
gen control2 = 1 if State == "Idaho" | State == "Indiana" | State == "Iowa" | State == "Kansas" | State == "Kentucky" | State == "SouthCarolina" | State == "Tennessee" | State == "Texas" | State == "Wyoming"
keep if control2 == 1 | (rml_treat == 1 & rml_group == 1)
replace rml_prepost = 1 if year >= 2014
replace rml_prepost = 0 if year < 2014
save file_mari3_robust1, replace

reghdfe fatalscann_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsodrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsddweed_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsnoimpair_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac0107_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac08_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac10_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals1519_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals2024_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals2529_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals3034_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals3539_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals4044_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals4549_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals50up_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe totsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe alcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe noalcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)

clear

use file_marijuana3_0019
gen control2 = 1 if State == "Idaho" | State == "Indiana" | State == "Iowa" | State == "Kansas" | State == "Kentucky" | State == "SouthCarolina" | State == "Tennessee" | State == "Texas" | State == "Wyoming"
keep if control2 == 1 | (rml_treat == 1 & rml_group == 2)
replace rml_prepost = 1 if year >= 2016
replace rml_prepost = 0 if year < 2016
save file_mari3_robust2, replace

reghdfe fatalscann_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsodrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsddweed_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsnoimpair_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac0107_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac08_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatalsbac10_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals1519_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals2024_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals2529_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals3034_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals3539_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals4044_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals4549_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe fatals50up_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe totsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe alcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
reghdfe noalcsva_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year)
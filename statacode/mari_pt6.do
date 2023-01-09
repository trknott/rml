clear

use file_marijuana
gen prepost_rml = 1 if rml_group == 0 & year >= 2012
replace prepost_rml = 1 if rml_group == 1 & year >= 2014
replace prepost_rml = 1 if rml_group == 2 & year >= 2016
replace prepost_rml = 0 if prepost_rml == . & rml_treat != .
replace prepost_rml = . if prepost_rml == 1 & rml_treat == .
gen fatal_hunthou = fatal_pc * 100000
gen fatalalc_hunthou = fatalalc_pc * 100000
save file_marijuana, replace

drop if State == "Michigan" | State == "Vermont"
reghdfe fatal_hunthou rml_treat##prepost_rml, noabsorb cluster(fips) resid
	predict rml_hat, xb
	predict resid_hat, residuals
	scatter resid_hat rml_hat
	outreg2 using rml.doc
reghdfe log_fatal_hunthou rml_treat##prepost_rml, noabsorb cluster(fips) resid
	predict rml_hat, xb
	predict resid_hat, residuals
	scatter resid_hat rml_hat
reghdfe fatal_hunthou rml_treat##prepost_rml, absorb(fips year) noconstant cluster(fips)
	outreg2 using rml.doc, append
reghdfe fatalalc_hunthou rml_treat##prepost_rml, noabsorb cluster(fips)
	outreg2 using rml.doc, append
reghdfe fatalalc_hunthou rml_treat##prepost_rml, absorb(fips year) noconstant cluster(fips)
	outreg2 using rml.doc, append

gen fatal_age1519_hunthou = fatal_age1519_pc * 100000
gen fatal_age2039_hunthou = fatal_age2039_pc * 100000
gen fatal_age40up_hunthou = fatal_age40up_pc * 100000

reghdfe fatal_age1519_hunthou rml_treat##prepost_rml, noabsorb
reghdfe fatal_age1519_hunthou rml_treat##prepost_rml, absorb(fips year) noconstant
reghdfe fatal_age2039_hunthou rml_treat##prepost_rml, noabsorb
reghdfe fatal_age2039_hunthou rml_treat##prepost_rml, absorb(fips year) noconstant

************

clear

use file_marijuana
gen prepost_mml = 1 if mml_group == 0 & year >= 1996
replace prepost_mml = 1 if mml_group == 1 & year >= 1998
replace prepost_mml = 1 if year == 1999 & mml_group == 2
replace prepost_mml = 1 if year >= 2000 & mml_group == 3
replace prepost_mml = 1 if year >= 2004 & mml_group == 4
replace prepost_mml = 1 if year >= 2006 & mml_group == 5
replace prepost_mml = 1 if year >= 2007 & mml_group == 6
replace prepost_mml = 1 if year >= 2008 & mml_group == 7
replace prepost_mml = 1 if year >= 2010 & mml_group == 8
replace prepost_mml = 1 if year >= 2011 & mml_group == 9
replace prepost_mml = 1 if year >= 2012 & mml_group == 10
replace prepost_mml = 1 if year >= 2013 & mml_group == 11
replace prepost_mml = 1 if year >= 2014 & mml_group == 12
replace prepost_mml = 1 if year >= 2016 & mml_group == 13
replace prepost_mml = 0 if prepost_mml == . & mml_treat != .
replace prepost_mml = . if prepost_mml == 1 & mml_treat == .
save file_marijuana, replace

drop if State == "WestVirginia" | State == "Oklahoma"
reghdfe fatal_hunthou mml_treat##prepost_mml, noabsorb cluster(fips)
	outreg2 using mml.doc
reghdfe fatal_hunthou mml_treat##prepost_mml, absorb(fips year) noconstant cluster(fips)
	outreg2 using mml.doc, append
reghdfe fatalalc_hunthou mml_treat##prepost_mml, noabsorb cluster(fips)
	outreg2 using mml.doc, append
reghdfe fatalalc_hunthou mml_treat##prepost_mml, absorb(fips year) noconstant cluster(fips)
	outreg2 using mml.doc, append
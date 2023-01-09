clear

use file_marijuana3_0019
gen totalvmt = fatalsall / (vehmiles / 1000)
gen pctsober = fatalsnoimpair / fatalsall
gen pctcann = fatalscann / fatalsall
replace pctcann = 0 if pctcann == .
gen cannvmt = fatalscann / (vehmiles / 1000)
replace cannvmt = 0 if cannvmt == .
gen pctdd = fatalsdd / fatalsall
gen ddvmt = fatalsdd / (vehmiles / 1000)
save file_marijuana3_0019, replace

gen weightsco_pctcann = 0.083 if State == "Arkansas"
replace weightsco_pctcann = 0.429 if State == "Delaware"
replace weightsco_pctcann = 0.060 if State == "Georgia"
replace weightsco_pctcann = 0.103 if State == "Hawaii"
replace weightsco_pctcann = 0.070 if State == "Nevada"
replace weightsco_pctcann = 0.051 if State == "NewHampshire"
replace weightsco_pctcann = 0.114 if State == "RhodeIsland"
replace weightsco_pctcann = 0.090 if State == "WestVirginia"
gen weightsco_cannvmt = 0.180 if State == "Connecticut"
replace weightsco_cannvmt = 0.165 if State == "Delaware"
replace weightsco_cannvmt = 0.058 if State == "Georgia"
replace weightsco_cannvmt = 0.120 if State == "Hawaii"
replace weightsco_cannvmt = 0.020 if State == "Nevada"
replace weightsco_cannvmt = 0.022 if State == "RhodeIsland"
replace weightsco_cannvmt = 0.434 if State == "WestVirginia"
gen weightswa_pctcann = 0.166 if State == "DC"
replace weightswa_pctcann = 0.450 if State == "Hawaii"
replace weightswa_pctcann = 0.047 if State == "Indiana"
replace weightswa_pctcann = 0.054 if State == "Montana"
replace weightswa_pctcann = 0.193 if State == "NewHampshire"
replace weightswa_pctcann = 0.091 if State == "Vermont"
gen weightswa_cannvmt = 0.123 if State == "DC"
replace weightswa_cannvmt = 0.184 if State == "Georgia"
replace weightswa_cannvmt = 0.365 if State == "Hawaii"
replace weightswa_cannvmt = 0.293 if State == "Nevada"
replace weightswa_cannvmt = 0.035 if State == "Vermont"
gen weightsco_pctdd = 0.351 if State == "Delaware"
replace weightsco_pctdd = 0.106 if State == "Georgia"
replace weightsco_pctdd = 0.089 if State == "Hawaii"
replace weightsco_pctdd = 0.091 if State == "NewHampshire"
replace weightsco_pctdd = 0.190 if State == "RhodeIsland"
replace weightsco_pctdd = 0.174 if State == "WestVirginia"
gen weightsco_ddvmt = 0.308 if State == "Arizona"
replace weightsco_ddvmt = 0.107 if State == "Florida"
replace weightsco_ddvmt = 0.147 if State == "Minnesota"
replace weightsco_ddvmt = 0.134 if State == "NewHampshire"
replace weightsco_ddvmt = 0.178 if State == "RhodeIsland"
replace weightsco_ddvmt = 0.127 if State == "SouthDakota"
gen weightswa_pctdd = 0.067 if State == "Delaware"
replace weightswa_pctdd = 0.189 if State == "Hawaii"
replace weightswa_pctdd = 0.632 if State == "Illinois"
replace weightswa_pctdd = 0.112 if State == "SouthDakota"
gen weightswa_ddvmt = 0.354 if State == "California"
replace weightswa_ddvmt = 0.067 if State == "DC"
replace weightswa_ddvmt = 0.150 if State == "Louisiana"
replace weightswa_ddvmt = 0.144 if State == "Nevada"
replace weightswa_ddvmt = 0.114 if State == "RhodeIsland"
replace weightswa_ddvmt = 0.172 if State == "Utah"
gen weightsco_pctsober = 0.113 if State == "Delaware"
replace weightsco_pctsober = 0.072 if State == "Georgia"
replace weightsco_pctsober = 0.048 if State == "Hawaii"
replace weightsco_pctsober = 0.205 if State == "NewHampshire"
replace weightsco_pctsober = 0.258 if State == "Pennsylvania"
replace weightsco_pctsober = 0.040 if State == "RhodeIsland"
replace weightsco_pctsober = 0.118 if State == "SouthCarolina"
replace weightsco_pctsober = 0.065 if State == "SouthDakota"
gen weightsco_totvmt = 0.255 if State =="DC"
replace weightsco_totvmt = 0.275 if State == "Michigan"
replace weightsco_totvmt = 0.116 if State == "Minnesota"
replace weightsco_totvmt = 0.092 if State == "Mississippi"
replace weightsco_totvmt = 0.261 if State == "Texas"
gen weightswa_pctsober = 0.426 if State == "Hawaii"
replace weightswa_pctsober = 0.341 if State == "Illinois"
replace weightswa_pctsober = 0.040 if State == "NewHampshire"
replace weightswa_pctsober = 0.091 if State == "SouthDakota"
replace weightswa_pctsober = 0.101 if State == "Vermont"
gen weightswa_totvmt = 0.196 if State == "California"
replace weightswa_totvmt = 0.043 if State == "Connecticut"
replace weightswa_totvmt = 0.108 if State == "DC"
replace weightswa_totvmt = 0.210 if State == "Massachusetts"
replace weightswa_totvmt = 0.066 if State == "NewJersey"
replace weightswa_totvmt = 0.305 if State == "Ohio"
replace weightswa_totvmt = 0.072 if State == "RhodeIsland"
save file_marijuana3_0019, replace

gen cogroup_pctcann = 1 if weightsco_pctcann != . | State == "Colorado"
gen cogroup_cannvmt = 1 if weightsco_cannvmt != . | State == "Colorado"
gen cogroup_pctdd = 1 if weightsco_pctdd != . | State == "Colorado"
gen cogroup_ddvmt = 1 if weightsco_ddvmt != . | State == "Colorado"
gen cogroup_pctsober = 1 if weightsco_pctsober != . | State == "Colorado"
gen cogroup_totvmt = 1 if weightsco_totvmt != . | State == "Colorado"
gen wagroup_pctcann = 1 if weightswa_pctcann != . | State == "Washington"
gen wagroup_cannvmt = 1 if weightswa_cannvmt != . | State == "Washington"
gen wagroup_pctdd = 1 if weightswa_pctdd != . | State == "Washington"
gen wagroup_ddvmt = 1 if weightswa_ddvmt != . | State == "Washington"
gen wagroup_pctsober = 1 if weightswa_pctsober != . | State == "Washington"
gen wagroup_totvmt = 1 if weightswa_totvmt != . | State == "Washington"
save file_marijuana3_0019, replace

replace weightsco_pctcann = 1 if State == "Colorado"
replace weightsco_cannvmt = 1 if State == "Colorado"
replace weightsco_pctdd = 1 if State == "Colorado"
replace weightsco_ddvmt = 1 if State == "Colorado"
replace weightsco_pctsober = 1 if State == "Colorado"
replace weightsco_totvmt = 1 if State == "Colorado"
replace weightswa_pctcann = 1 if State == "Washington"
replace weightswa_cannvmt = 1 if State == "Washington"
replace weightswa_pctdd = 1 if State == "Washington"
replace weightswa_ddvmt = 1 if State == "Washington"
replace weightswa_pctsober = 1 if State == "Washington"
replace weightswa_totvmt = 1 if State == "Washington"
save file_marijuana3_0019, replace

gen pctcann_weightsco = pctcann * weightsco_pctcann
gen cannvmt_weightsco = cannvmt * weightsco_cannvmt
gen pctdd_weightsco = pctdd * weightsco_pctdd
gen ddvmt_weightsco = ddvmt * weightsco_ddvmt
gen pctsober_weightsco = pctsober * weightsco_pctsober
gen totvmt_weightsco = totalvmt * weightsco_totvmt
gen pctcann_weightswa = pctcann * weightswa_pctcann
gen cannvmt_weightswa = cannvmt * weightswa_cannvmt
gen pctdd_weightswa = pctdd * weightswa_pctdd
gen ddvmt_weightswa = ddvmt * weightswa_ddvmt
gen pctsober_weightswa = pctsober * weightswa_pctsober
gen totvmt_weightswa = totalvmt * weightswa_totvmt
save file_marijuana3_0019, replace

foreach thing in "pctcann" "cannvmt" "pctdd" "ddvmt" "pctsober" "totalvmt" {
	tsset fips year
	gen `thing'_lag = l.`thing'
}
gen dforpermute = rml_treat * rml_prepost
gen recession = 1 if inrange(year, 2008, 2010)
replace recession = 0 if recession == .
gen vmtrecession = vehmiles_hunthou * recession
gen prerecession = 1 if year < 2008
replace prerecession = 0 if prerecession == .
gen postrecession = 1 if year > 2010
replace postrecession = 0 if postrecession == .
gen vmtprerec = vehmiles_hunthou * prerecession
gen vmtpostrec = vehmiles_hunthou * postrecession
save file_marijuana3_0019, replace


****************

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
drop if year > 2016
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe pctcann rml_treat##rml_prepost l.pctcann pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctcann _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctcann c.rml_treat##c.rml_prepost pctcann_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
drop if year > 2016
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe pctcann rml_treat##rml_prepost l.pctcann pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctcann _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctcann c.rml_treat##c.rml_prepost pctcann_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe pctdd rml_treat##rml_prepost l.pctdd pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctdd _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctdd c.rml_treat##c.rml_prepost pctdd_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe pctdd rml_treat##rml_prepost l.pctdd pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctdd _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctdd c.rml_treat##c.rml_prepost pctdd_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe pctsober rml_treat##rml_prepost l.pctsober pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctsober _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctsober c.rml_treat##c.rml_prepost pctsober_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe pctsober rml_treat##rml_prepost l.pctsober pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctsober _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctsober c.rml_treat##c.rml_prepost pctsober_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe cannvmt rml_treat##rml_prepost l.cannvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest cannvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe cannvmt c.rml_treat##c.rml_prepost cannvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe cannvmt rml_treat##rml_prepost l.cannvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest cannvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe cannvmt c.rml_treat##c.rml_prepost cannvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe ddvmt rml_treat##rml_prepost l.ddvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest ddvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe ddvmt c.rml_treat##c.rml_prepost ddvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe ddvmt rml_treat##rml_prepost l.ddvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest ddvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe ddvmt c.rml_treat##c.rml_prepost ddvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe totalvmt rml_treat##rml_prepost l.totalvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest totalvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe totalvmt c.rml_treat##c.rml_prepost totalvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe totalvmt rml_treat##rml_prepost l.totalvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest totalvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe totalvmt c.rml_treat##c.rml_prepost totalvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

**************************

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2012
replace rml_prepost = 1 if year >= 2012
tsset fips year
*reghdfe pctcann rml_treat##rml_prepost l.pctcann pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctcann _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctcann c.rml_treat##c.rml_prepost pctcann_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2012
replace rml_prepost = 1 if year >= 2012
tsset fips year
*reghdfe pctcann rml_treat##rml_prepost l.pctcann pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctcann _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctcann c.rml_treat##c.rml_prepost pctcann_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2012
replace rml_prepost = 1 if year >= 2012
tsset fips year
*reghdfe pctdd rml_treat##rml_prepost l.pctdd pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctdd _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctdd c.rml_treat##c.rml_prepost pctdd_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2012
replace rml_prepost = 1 if year >= 2012
tsset fips year
*reghdfe pctdd rml_treat##rml_prepost l.pctdd pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctdd _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctdd c.rml_treat##c.rml_prepost pctdd_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2012
replace rml_prepost = 1 if year >= 2012
tsset fips year
*reghdfe pctsober rml_treat##rml_prepost l.pctsober pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctsober _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctsober c.rml_treat##c.rml_prepost pctsober_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2012
replace rml_prepost = 1 if year >= 2012
tsset fips year
*reghdfe pctsober rml_treat##rml_prepost l.pctsober pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest pctsober _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe pctsober c.rml_treat##c.rml_prepost pctsober_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2012
replace rml_prepost = 1 if year >= 2012
tsset fips year
*reghdfe cannvmt rml_treat##rml_prepost l.cannvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest cannvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe cannvmt c.rml_treat##c.rml_prepost cannvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2012
replace rml_prepost = 1 if year >= 2012
tsset fips year
*reghdfe cannvmt rml_treat##rml_prepost l.cannvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest cannvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe cannvmt c.rml_treat##c.rml_prepost cannvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
*replace rml_prepost = 0 if year < 2012
*replace rml_prepost = 1 if year >= 2012
tsset fips year
*reghdfe ddvmt rml_treat##rml_prepost l.ddvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest ddvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe ddvmt c.rml_treat##c.rml_prepost pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
*replace rml_prepost = 0 if year < 2014
*replace rml_prepost = 1 if year >= 2014
tsset fips year
*reghdfe ddvmt rml_treat##rml_prepost l.ddvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest ddvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe ddvmt c.rml_treat##c.rml_prepost ddvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noconstant absorb(fips year) cluster(fips)

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Colorado"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
reghdfe totalvmt rml_treat##rml_prepost l.totalvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest totalvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe totalvmt c.rml_treat##c.rml_prepost totalvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb

clear
use file_marijuana3_0019
drop if rml_treat == 1 & State != "Washington"
keep if year < 2017
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
reghdfe totalvmt rml_treat##rml_prepost l.totalvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb
ritest totalvmt _b[rml_treat#rml_prepost], reps(1000) seed(12345) strata(fips): reghdfe totalvmt c.rml_treat##c.rml_prepost totalvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou vmtrecession vmtprerec vmtpostrec, noabsorb







*************

* hansen et al: marijuana-related fatalities *
clear
use file_marijuana3_0019
keep if year < 2017
keep if cogroup_pctcann == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
reghdfe pctcann rml_treat##rml_prepost l.pctcann pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou, noabsorb
gen dforpermute = rml_treat * rml_prepost
gen pctcann_lag = l.pctcann
sort fips year
permute pctcann _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctcann rml_treat rml_prepost dforpermute pctcann_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou

clear
use file_marijuana3_0019
keep if cogroup_pctcann == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctcann rml_treat##rml_prepost, noabsorb
gen dforpermute = rml_treat * rml_prepost
permute pctcann _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctcann rml_treat rml_prepost dforpermute


clear
use file_marijuana3_0019
keep if year < 2017
keep if cogroup_cannvmt == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe cannvmt rml_treat##rml_prepost, noabsorb
gen dforpermute = rml_treat * rml_prepost
permute cannvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg cannvmt rml_treat rml_prepost dforpermute


clear
use file_marijuana3_0019
keep if cogroup_cannvmt == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe cannvmt rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute cannvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg cannvmt rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if year < 2017
keep if wagroup_pctcann == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctcann rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute pctcann _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctcann rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if wagroup_pctcann == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctcann rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute pctcann _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctcann rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if year < 2017
keep if wagroup_cannvmt == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe cannvmt rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute cannvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg cannvmt rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if wagroup_cannvmt == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe cannvmt rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute cannvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg cannvmt rml_treat rml_prepost dforpermute

* hansen et al: alcohol-related fatalities *
clear
use file_marijuana3_0019
keep if year < 2017
keep if cogroup_pctdd == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
reghdfe pctdd rml_treat##rml_prepost l.pctdd pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
gen pctdd_lag = l.pctdd
permute pctdd _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctdd rml_treat rml_prepost dforpermute pctdd_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou, cluster(fips)

clear
use file_marijuana3_0019
keep if cogroup_pctdd == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctdd rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute pctcann _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctcann rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if year < 2017
keep if cogroup_ddvmt == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
reghdfe ddvmt rml_treat##rml_prepost l.ddvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou, noabsorb
gen dforpermute = rml_treat * rml_prepost
gen ddvmt_lag = l.ddvmt
permute ddvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg ddvmt rml_treat rml_prepost dforpermute ddvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou

clear
use file_marijuana3_0019
keep if cogroup_ddvmt == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
tsset fips year
reghdfe ddvmt rml_treat##rml_prepost l.ddvmt pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou, noabsorb
gen dforpermute = rml_treat * rml_prepost
gen ddvmt_lag = l.ddvmt
permute ddvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg ddvmt rml_treat rml_prepost dforpermute ddvmt_lag pcturbanvmt1 urate alctestrate drugtestrate vehmiles_hunthou

clear
use file_marijuana3_0019
keep if year < 2017
keep if wagroup_pctdd == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctdd rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute pctdd _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctdd rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if wagroup_pctdd == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctdd rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute pctdd _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctdd rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if year < 2017
keep if wagroup_ddvmt == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe ddvmt rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute ddvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg ddvmt rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if wagroup_ddvmt == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe ddvmt rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute ddvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg ddvmt rml_treat rml_prepost dforpermute

* hansen et al: sober and total fatalities *
clear
use file_marijuana3_0019
keep if year < 2017
keep if cogroup_pctsober == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctsober rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute pctsober _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctsober rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if cogroup_pctsober == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctsober rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute pctsober _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctsober rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if year < 2017
keep if cogroup_totvmt == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe totalvmt rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute totalvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg totalvmt rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if cogroup_totvmt == 1
drop if rml_treat == 1 & State != "Colorado"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe totalvmt rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute totalvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg totalvmt rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if year < 2017
keep if wagroup_pctsober == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctsober rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute pctsober _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctsober rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if wagroup_pctsober == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe pctsober rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute pctsober _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg pctsober rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if year < 2017
keep if wagroup_totvmt == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe totalvmt rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute totalvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg totalvmt rml_treat rml_prepost dforpermute

clear
use file_marijuana3_0019
keep if wagroup_totvmt == 1
drop if rml_treat == 1 & State != "Washington"
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe totalvmt rml_treat##rml_prepost, noabsorb cluster(fips)
gen dforpermute = rml_treat * rml_prepost
permute totalvmt _b[dforpermute], reps(1000) rseed(12345) strata(fips): reg totalvmt rml_treat rml_prepost dforpermute, cluster(fips)

********************

clear
use file_marijuana3_0019
keep if year < 2017
keep if cogroup_totvmt == 1
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe fatalsall_hunthou rml_treat##rml_prepost, noconstant absorb(fips year) cluster(fips)
clear
use file_marijuana3_0019
keep if year < 2017
keep if cogroup_cannvmt == 1
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe fatalscann_hunthou rml_treat##rml_prepost, noconstant absorb(fips year) cluster(fips)
clear
use file_marijuana3_0019
keep if year < 2017
keep if cogroup_ddvmt == 1
replace rml_prepost = 0 if year < 2014
replace rml_prepost = 1 if year >= 2014
reghdfe fatalsdd_hunthou rml_treat##rml_prepost, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsnoimpair_hunthou rml_treat##rml_prepost, noconstant absorb(fips year) cluster(fips)
reghdfe totalvmt rml_treat##rml_prepost, noconstant absorb(fips year) cluster(fips)
reghdfe pctsober rml_treat##rml_prepost, noconstant absorb(fips year) cluster(fips)
reghdfe pctcann rml_treat##rml_prepost, noconstant absorb(fips year) cluster(fips)
reghdfe cannvmt rml_treat##rml_prepost, noconstant absorb(fips year) cluster(fips)
reghdfe pctdd rml_treat##rml_prepost, noconstant absorb(fips year) cluster(fips)

***************
clear
use file_marijuana3_0019
export excel using "C:/dissertation/data/mari3.xlsx", firstrow(var)

**************


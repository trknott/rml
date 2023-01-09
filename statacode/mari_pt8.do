clear
use file_rmlptrends_fbac10
gen diff = treatment - abs(control)
save file_rmlptrends_fbac10, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
label var diff "Treatment - | Control |"
tsset period, year
scatter treatment control diff period, connect(l l l)



clear
use file_marijuana2
drop if State == "Michigan" | State == "Vermont"
reg fsvaalc_hunthou period_8 period_7 period_6 period_5 period_4 period_3 period_2 period_1 period0 period1 period2 period3 if rml_treat == 1
regsave using plz1, replace
clear
use file_marijuana2
reg fsvaalc_hunthou period_8 period_7 period_6 period_5 period_4 period_3 period_2 period_1 period0 period1 period2 period3 if rml_treat == 0
regsave using plz2, replace

clear
use plz1
gen cons = 2.2199905
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save plz12, replace
clear
use plz2
gen cons = 3.0015094
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control
merge m:1 period using plz12
drop _merge
foreach prd in "8" "7" "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'"
}
foreach prd in "0" "1" "2" "3" {
	replace period = "`prd'" if period == "period`prd'"
}
destring, replace
save plz3, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
scatter treatment control period, connect(l l)
graph export "C:/dissertation/misc/fsvaalcgraph1.png"





clear
use file_marijuana2
drop if State == "Michigan" | State == "Vermont"
reg fbac10_hunthou period_8 period_7 period_6 period_5 period_4 period_3 period_2 period_1 period0 period1 period2 period3 if rml_treat == 1
regsave using plz5, replace
clear
use file_marijuana2
reg fbac10_hunthou period_8 period_7 period_6 period_5 period_4 period_3 period_2 period_1 period0 period1 period2 period3 if rml_treat == 0
regsave using plz6, replace

clear
use plz5
gen cons = 2.445446
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period treatment)
keep period treatment
save plz52, replace
clear
use plz6
gen cons = 3.2043741
drop if var == "_cons"
replace coef = coef + cons
rename (var coef) (period control)
keep period control
merge m:1 period using plz52
drop _merge
foreach prd in "8" "7" "6" "5" "4" "3" "2" "1" {
	replace period = "-`prd'" if period == "period_`prd'"
}
foreach prd in "0" "1" "2" "3" {
	replace period = "`prd'" if period == "period`prd'"
}
destring, replace
save plz7, replace

label var period "Period"
label var control "Control"
label var treatment "Treatment"
tsset period, year
scatter treatment control period, connect(l l)
graph export "C:/dissertation/misc/fbac10graph1.png"
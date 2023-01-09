clear
use file_marijuana3_9919
replace fatals4044_hunthou = (ddage_4044 / state_pop) * 100000
replace fatals4549_hunthou = (ddage_4549 / state_pop) * 100000
replace fatals50up_hunthou = (ddage_50up / state_pop) * 100000
replace fatals1519_hunthou = (ddage_1519 / state_pop) * 100000
replace fatals2024_hunthou = (ddage_2024 / state_pop) * 100000
replace fatals2529_hunthou = (ddage_2529 / state_pop) * 100000
replace fatals3034_hunthou = (ddage_3034 / state_pop) * 100000
replace fatals3539_hunthou = (ddage_3539 / state_pop) * 100000
save file_marijuana3_9919, replace

tsset fips year

reghdfe fatalsall_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fatals1519_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fatals2024_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fatals2529_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fatals3034_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fatals3539_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fatals4044_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fatals4549_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)
reghdfe fatals50up_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income, noconstant absorb(fips year) cluster(fips)

reghdfe fatalsall_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsall_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalscann_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalscann_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsodrugs_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsodrugs_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsdd_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsdd_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsddweed_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsddweed_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
reghdfe fatalsnoimpair_hunthou rml_treat##rml_prepost mml_treat decrim vehmiles_hunthou med_age urate rpc_income l.fatalsnoimpair_hunthou pcturbanvmt1 alctestrate drugtestrate, noconstant absorb(fips year) cluster(fips)
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

keep if rml_treat == 0
// 400 Dis 5 do-file Solution

// Make sure you change your working directory first!

// Setup
clear all
set more off // tells Stata not to pause or display the more message

// Start log
log using "400_sp21_dis-5_sol-log.log", replace




/*
Problem 1
*/

use "http://fmwww.bc.edu/ec-p/data/wooldridge/wage2.dta", clear
reg wage educ
reg wage educ exper
gen log_wage = log(wage)
gen exper_squared = exper^2
reg log_wage educ exper exper_squared south south#c.educ south#c.exper south#c.exper_squared
save "400_sp21_dis-5_wage-data-for-reg-model.dta", replace

// Predict relationship between wage and educ
summarize educ
local n_obs = 18 - 9 + 1
clear all
set obs `n_obs'

// Generate dataset to predict onto (make sure your explanatory variables are named the same as in the original dataset)
egen educ = seq(), from(9) to(18)
gen exper = 10
gen exper_squared = exper^2
gen south = 1
save "400_sp21_dis-5_predicted-data.dta", replace

// Before predict, need to run the original regression model again
use "400_sp21_dis-5_wage-data-for-reg-model.dta", clear
quietly reg log_wage educ exper exper_squared south south#c.educ south#c.exper south#c.exper_squared

use "400_sp21_dis-5_predicted-data.dta", clear
predict south_10_exper_log

replace south = 0 // now for non-southerner with 10 years of experience
predict nonsouth_10_exper_log

// Recall that our original response variable was log_wage: need to convert to wage level by taking exponential
gen south_10_exper_level = exp(south_10_exper_log)
gen nonsouth_10_exper_level = exp(nonsouth_10_exper_log)
save "400_sp21_dis-5_predicted-data.dta", replace

// Plot the relationship between predicted wage level and educ
label variable south_10_exper_level "south = 1, exper = 10"
label variable nonsouth_10_exper_level "south = 0, exper = 10"
line south_10_exper_level nonsouth_10_exper_level educ, legend(size(medsmall)) ytitle("Monthly wage ($)") xtitle("Years of education")
graph export "400_sp21_dis-5_1g.png", replace




// Close log
log close

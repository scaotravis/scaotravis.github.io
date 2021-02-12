// 400 Dis 3 do-file Solution

// Make sure you change your working directory first!

// Setup
clear all
set more off // tells Stata not to pause or display the more message

// Start log
log using "400_sp21_dis-3_sol-log.log", replace




/*
Problem 1
*/

// Part a-d
use "http://fmwww.bc.edu/ec-p/data/wooldridge/sleep75.dta", clear
reg sleep totwrk
predict u_hat, residuals

// Part e
use "400_sp21_dis-3_dataset.dta", clear
rename total_work totwrk
predict sleep_new_hat

// Part f
use "http://fmwww.bc.edu/ec-p/data/wooldridge/sleep75.dta", clear
reg sleep totwrk

// Part g
twoway scatter sleep totwrk || lfit sleep totwrk
graph export "sleep_vs_totwrk.png", replace




/*
Problem 2
*/

use "http://fmwww.bc.edu/ec-p/data/wooldridge/sleep75.dta", clear
mean sleep
tabstat sleep, statistics(sd)
ci means sleep, level(95)




// Close log
log close

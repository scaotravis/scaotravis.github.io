// 400 Dis 6 do-file Solution

// Make sure you change your working directory first!

// Setup
clear all
set more off // tells Stata not to pause or display the more message

// Start log
log using "400_sp21_dis-6_sol-log.log", replace




/*
Problem 1
*/

use "http://fmwww.bc.edu/ec-p/data/wooldridge/wage2.dta", clear
reg wage educ exper black urban married hours
rvfplot, yline(0)
graph export "400_sp21_dis-6_4e.png", replace
estat hettest, rhs fstat
estat imtest, white

reg wage educ exper black urban married hours, robust




// Close log
log close

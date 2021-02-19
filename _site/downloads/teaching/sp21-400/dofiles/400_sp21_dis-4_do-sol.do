// 400 Dis 4 do-file Solution

// Make sure you change your working directory first!

// Setup
clear all
set more off // tells Stata not to pause or display the more message

// Start log
log using "400_sp21_dis-4_sol-log.log", replace




/*
Problem 1
*/

use "http://fmwww.bc.edu/ec-p/data/wooldridge/sleep75.dta", clear
reg hrwage educ
reg hrwage educ exper black male union
reg hrwage educ exper black male union, level(90)
test black = union = .5




// Close log
log close

// 400 Dis 1 do-file Solution

// Make sure you change your working directory to where the unzipped data files is located at first!

// Setup
clear
set more off // tells Stata not to pause or display the more message

// Start log
log using "400_sp21_dis-1_sol-log.log", replace

/* 
Actual program starts here
*/

// Q2
use "panel2007.dta", clear
destring(id), replace
save "panel2007.dta", replace

// Q3

* Append
gen year=2007
save "panel2007_append", replace
use "panel2008.dta", clear
gen year=2008
append using "panel2007_append.dta"
save "appended_data.dta", replace

* Merge
use "panel2007"
rename score score2007
save "panel2007merge", replace
use "panel2008"
rename score score2008
merge 1:1 id using "panel2007merge"
save "merge_data.dta", replace

/*
Actual program ends here
*/

// Close log
log close

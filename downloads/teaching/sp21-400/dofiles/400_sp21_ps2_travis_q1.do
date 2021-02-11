// Set up environment
clear all
set more off

// REMEMBER TO CHANGE YOUR WORKING DIRECTORY! 

// Log your result
log using "400_sp21_ps2_q1.log", replace




/*
Problem #1
*/

// Import and clean PrisonAdmissions.xls
import excel "PrisonAdmissions.xls", clear sheet("Sheet1") firstrow
drop if _n == 1

// Merge with CountyPopulation.dta
duplicates drop CNTY_FIPS STATE_FIPS, force
merge 1:m CNTY_FIPS STATE_FIPS using CountyPopulation
duplicates drop CNTY_FIPS STATE_FIPS, force
drop if STATE_FIPS == . // drop missing variable

// 1. Generate variable describing prison admissions per 10,000 residents in 2006, 2013, and 2014
drop _merge
gen adm_per_10000_2006 = (admissions2006 / (population2006 / 10000))
gen adm_per_10000_2013 = (admissions2013 / (population2013 / 10000))
gen adm_per_10000_2014 = (admissions2014 / (population2014 / 10000))

save "Q1_before_merging_with_name", replace

// 2. Include the names of each county associated
import delimited "CountyNames.txt", clear
rename (state_fips cnty_fips) (STATE_FIPS CNTY_FIPS)
save "CountyNames.dta", replace

use "Q1_before_merging_with_name", clear
merge 1:m CNTY_FIPS STATE_FIPS using "CountyNames.dta"

// 3. Keep certain variables and data from certain counties
keep if state == "AZ"
keep county adm_per_10000_2013
order county adm_per_10000_2013 // Change variable order
label variable county "County Name"
label variable adm_per_10000_2013 "Prison Admission Per 10000 Residents in 2013"

// Export data into a single table
// Method 1: Directly print out table in Stata's result window
list county adm_per_10000_2013
// Method 2: Export table to an Excel spreadsheet
export excel "Q1_output", firstrow(varlabels) replace keepcellfmt




// Close log
log close

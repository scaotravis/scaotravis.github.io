// 400 Dis 2 do-file Solution

// Make sure you change your working directory to where the data file is located at first!

// Setup
clear all
set more off // tells Stata not to pause or display the more message

// Start log
log using "400_sp21_dis-2_sol-log.log", replace



/* 
Question 2
*/

// Calculate E(Y|X)
use "400_sp21_dis-2_dataset", clear
forval i = 1/4 {
	egen col_sum = sum(x`i')
	replace x`i' = x`i' / col_sum
	replace x`i' = x`i' * y
	drop col_sum
}
collapse (sum) x1 x2 x3 x4
save "E_Y_cond_X", replace

// Calculate E(Y) = E[ E(Y|X) ] = \sum_i E(Y|X = x_i) f_X(x_i) <- using law of iterated expectation

// First need to calculate marginal distribution of X
use "400_sp21_dis-2_dataset", clear
collapse (sum) x1 x2 x3 x4
save "marginal_x", replace

// Then we need to append the row of E(Y|X) to the marginal density of X
append using "E_Y_cond_X"
xpose, clear // transpose the dataset (rows now become columns), so that all conditional means are in one column (i.e. treated as a variable)
rename (v1 v2) (marginal_X E_Y_cond_X)
gen Y_weight = marginal_X * E_Y_cond_X
collapse (sum) Y_weight
rename Y_weight E_Y
save "E_Y", replace
local E_Y_local E_Y
display "E(Y) = " `E_Y_local' // E(Y) = 2.03125

// Calculate E(Y) = sum_i Y_i * f(Y_i) <- using the marginal distribution
use "400_sp21_dis-2_dataset", clear
drop y
xpose, clear
collapse (sum) v1-v3
xpose, clear
rename v1 marginal_y
egen y = seq(), from(1) to(3)
gen Y_weight = y * marginal_y
collapse (sum) Y_weight
rename Y_weight E_Y
local E_Y_local_alt E_Y
display "E(Y) = " `E_Y_local_alt' // E(Y) = 2.03125

// Calculate Var(Y) = E(Y^2) - [E(Y)]^2 -> Need E(Y^2): use marginal distribution method
use "400_sp21_dis-2_dataset", clear
drop y
xpose, clear
collapse (sum) v1-v3
xpose, clear
rename v1 marginal_y
egen y = seq(), from(1) to(3)
gen Y2_weight = y^2 * marginal_y
collapse (sum) Y2_weight
rename Y2_weight E_Y2
save "E_Y2", replace
local E_Y2_local E_Y2
display "E(Y^2) = " `E_Y2_local' // E(Y^2) = 4.65625, and Var(Y) can then be calculated by hand




/* 
Question 3 (Part of Problem #5 from this week's PS)
*/

// Generate math SAT data
clear all
local n_obs = (800 - 300)/10 + 1 // need to set number of observations in Stata first before any data can be generated
set obs `n_obs'
gen math_SAT = 10 * (_n-1) + 300 // _n here records each row's ID number

// Generate normal density, using gen
gen f_math_SAT = 1/sqrt(2 * _pi * 100^2) * exp(-1/2 * ( (math_SAT - 500)/100 )^2)

// Generate normal density, using normalden
gen f_math_SAT_2 = normalden(math_SAT, 500, 100) // this should generate a variable identical to f_math_SAT

// Save data
save "math_SAT", replace



// Close log
log close


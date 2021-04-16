// 400 Dis 11 Do file

// Make sure you change your working directory first! 

// Setup
clear all
set more off // tells Stata not to pause or display the more message




/*
Problem 1 (Shrinkage Estimator)
*/

// (a) Plot SSR as a function of b
clear all
set obs 101
egen b = seq(), from(-40) to(60)
replace b = b / 10

gen SSR = (2 - b)^2 + (6 - 3 * b)^2
line SSR b, title("SSR for OLS")
graph export "400_sp21_dis-11_q1-a.png", replace

// (c) Plot penalized SSR as a function of b, for \lambda_Lasso = 10
gen penalized_1 = 10 * abs(b)
gen PSSR_1 = SSR + penalized_1
line PSSR_1 b, ytitle("Penalized SSR") title("Penalized SSR for Lasso, with lambda = 10")
graph export "400_sp21_dis-11_q1-c.png", replace

// (e) Plot penalized SSR as a function of b, for \lambda_Lasso = 100
gen penalized_2 = 100 * abs(b)
gen PSSR_2 = SSR + penalized_2
line PSSR_2 b, ytitle("Penalized SSR") title("Penalized SSR for Lasso, with lambda = 100")
graph export "400_sp21_dis-11_q1-e.png", replace





/*
Problem 2 (Time Series)
*/

clear all
use "400_sp21_dis-11_dataset.dta", clear
tsset time

// (a) Start by running AR(1) model to forecast real GDP growth
reg gdp l.gdp, robust
estimates store ar1
local ar_models ar1

// (b) Try an AR(2) model
reg gdp l(1/2).gdp, robust
estimates store ar2
local ar_models `ar_models' ar2

// (c) Increase AR(p) gradually to p = 4
forvalues i = 3/4 {
	
	quietly reg gdp l(1/`i').gdp, robust
	estimates store ar`i'
	local ar_models `ar_models' ar`i'
	
}

// Evaluate how many lags should be included in an AR model
estimate stats `ar_models'

// (d) Try ADL(1, 1) model, using pdi variable as the X variable
reg gdp l.gdp l.pdi, robust

// (e) Try ADL(p, q) with all possible combinations of p and q, up to p = 4 and q = 4
forvalues p = 1/4 {
	forvalues q = 1/4 {
		
		quietly reg gdp l(1/`p').gdp l(1/`q').pdi, robust
		estimates store adl`p'`q'
		local adl_models `adl_models' adl`p'`q'
		
	}
}

// Evaluate how many lags should be included in an ADL model
estimate stats `adl_models'

// (f) Choose between AR and ADL models
estimate stats `ar_models' `adl_models'


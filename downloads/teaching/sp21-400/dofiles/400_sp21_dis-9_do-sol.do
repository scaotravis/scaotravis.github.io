// 400 Dis 9 do-file Solution

// Make sure you change your working directory first!

// Setup
clear all
set more off // tells Stata not to pause or display the more message

// Start log
log using "400_sp21_dis-9_sol-log.log", replace




/*
Problem 1 (Binary Response)
*/

use "http://fmwww.bc.edu/ec-p/data/wooldridge/mroz.dta", clear

// (a) Linear probability model
reg inlf i.city faminc unem kidslt6 kidsge6 age educ

// (b) Test homoskedasticity assumption
rvfplot, yline(0)
graph export "400_sp21_dis-9_1b.png", replace
reg inlf i.city faminc unem kidslt6 kidsge6 age educ, robust

// (e) Logit model
logit inlf i.city faminc unem kidslt6 kidsge6 age educ
scalar m1 = e(ll) // store log-likelihood level as m1

// (f) Logit marginal effects for all variables
margins, dydx(*) atmeans

// (g) Logit predicted probability of living in a city vs. not for a set of characteristics
margins city, at(faminc=25000 unem=10 kidslt6=1 kidsge6=1 age=30 educ=16)

// (h) Add two more regressors and perform test
logit inlf i.city faminc unem kidslt6 kidsge6 age educ huswage husage
scalar m2 = e(ll) // store log-likelihood level of new model as m2

di "chi2(2) = " 2*(m2-m1) // test statistic
di "Prob > chi2 = "chi2tail(2, 2*(m2-m1)) // p-value; DOF = 2 since there are two newly included parameter; you can think of this as the model in (e) restricted coef on huswage and husage to be 0

// (i) Probit model
probit inlf i.city faminc unem kidslt6 kidsge6 age educ

// (j) Probit marginal effects for all variables
margins, dydx(*) atmeans





// Close log
log close

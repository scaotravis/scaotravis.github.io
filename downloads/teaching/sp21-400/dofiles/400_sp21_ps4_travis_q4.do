// 400 PS 4 
// Travis Cao

// Change your working directory first!!!

// Set up environment
clear all
set more off

/*
Problem #4
*/
use "CPS2015.dta", clear

// (a)
reg ahe age female bachelor

// (b)
gen log_ahe = log(ahe)
reg log_ahe age female bachelor

// (c)
gen log_age = log(age)
reg log_ahe log_age female bachelor

// (d)
gen age_squared = age^2
reg log_ahe age age_squared female bachelor

// (h) Plot (b), (c), (d) for male with high school diploma
save "CPS2015_with_gen_variables.dta", replace // save a version of CPS2015 with the variables we already generated

// Create a dataset for predicted values to store
clear all
local n_obs = 34 - 25 + 1
set obs `n_obs'
egen age = seq(), from(25) to(34)
gen log_age = log(age)
gen age_squared = age^2
gen female = 0
gen bachelor = 0
save "CPS2015_to_predict.dta", replace

// Prepare to plot (b)
use "CPS2015_with_gen_variables.dta", clear
quietly reg log_ahe age female bachelor // quietly suppress table output -- we already produced regression result earlier in (b)
use "CPS2015_to_predict.dta", clear
predict result_b // recall that predict uses the last stored linear model to predict value of y, which is why we need to regress right before we predict
save "CPS2015_to_predict.dta", replace

// Prepare to plot (c)
use "CPS2015_with_gen_variables.dta", clear
quietly reg log_ahe log_age female bachelor
use "CPS2015_to_predict.dta", clear
predict result_c
save "CPS2015_to_predict.dta", replace

// Prepare to plot (d)
use "CPS2015_with_gen_variables.dta", clear
quietly reg log_ahe age age_squared female bachelor
use "CPS2015_to_predict.dta", clear
predict result_d
save "CPS2015_to_predict.dta", replace

// Actually plot (b), (c), (d)
label variable result_b "Part (b)"
label variable result_c "Part (c)"
label variable result_d "Part (d)"
line result_b result_c result_d age, legend(size(medsmall)) ytitle("log of AHE") xtitle("Age")
graph export "4h.png", replace

// (i)
use "CPS2015_with_gen_variables.dta", clear
reg log_ahe age age_squared female bachelor female#c.bachelor

// (j)
gen female_age = female * age
gen female_age_squared = female * age_squared
reg log_ahe age age_squared female bachelor female#c.bachelor female_age female_age_squared
test female_age female_age_squared

// (k)
gen bachelor_age = age * bachelor
gen bachelor_age_squared = age_squared * bachelor
reg log_ahe age age_squared female bachelor female#c.bachelor bachelor_age bachelor_age_squared
test bachelor_age bachelor_age_squared

// (l)
reg log_ahe age age_squared female bachelor female#c.bachelor female#c.age female#c.age_squared bachelor#c.age bachelor#c.age_squared // use a complete regression model

// Let's show the result visually: 
use "CPS2015_to_predict.dta", clear
predict male_hs // current data has female = 0 and bachelor = 0

replace female = 1 // make female = 1, bachelor remains at 0
predict female_hs

replace bachelor = 1 // make bachelor = 1, female remains at 1
predict female_college

replace female = 0 // make female = 0, bachelor remains at 1
predict male_college

label variable male_hs "Male with HS deg"
label variable female_hs "Female with HS deg"
label variable female_college "Female with college deg"
label variable male_college "Male with college deg"

line male_hs female_hs female_college male_college age, legend(size(medsmall)) ytitle("log of AHE") xtitle("Age")
graph export "4l.png", replace

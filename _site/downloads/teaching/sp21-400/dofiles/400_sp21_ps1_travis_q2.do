/* Problem #2 */

// Remember to change your working directory!!!

clear all
set more off

// Log result
log using "400_ps1_q2_log.log", replace

/*
Actual program starts here
*/


// Get data into the right shape
import delimited "Earnings.csv", clear rowr(2:31) colr(2:12) varn(2)
rename (v1-v11) (ahe age_25 age_26 age_27 age_28 age_29 age_30 age_31 age_32 age_33 age_34)
save "Earnings.dta", replace



// a: Marginal dist of age
collapse (sum) age_25 age_26 age_27 age_28 age_29 age_30 age_31 age_32 age_33 age_34
save "marginal_age", replace



// b: Mean of AHE for each age group
use "Earnings", clear
// E(ahe | age = 25) = \sum_{i} ahe_i * f_ahe(ahe_i | age = 25)
forval i = 25/34 {
	egen col_sum = sum(age_`i')
	replace age_`i' = age_`i' / col_sum
	replace age_`i' = age_`i'*ahe
	drop col_sum
}
collapse (sum) age_25 age_26 age_27 age_28 age_29 age_30 age_31 age_32 age_33 age_34
save "E_ahe_cond_age", replace



// c: Compute and plot the mean of AHE versus age
xpose, clear // transpose data
rename v1 ahe_cond_mean
egen age = seq(), from(25) to(34)
set graphics off
scatter ahe_cond_mean age
graph export "ahe_cond_mean_vs_age.png", replace



// d: Compute overall mean of AHE
// E(ahe) = E[ E(ahe|age) ] = \sum_{i} E(ahe | age_i) * f_age(age_i)
use "E_ahe_cond_age", clear
append using "marginal_age"
xpose, clear
rename (v1 v2) (E_ahe_cond_age marginal_age)
gen ahe_weight = E_ahe_cond_age * marginal_age
collapse (sum) ahe_weight
rename ahe_weight E_ahe
local ahe_mean_l E_ahe
display "E(ahe) = " `ahe_mean_l'



// e-g: Need E(ahe^2), E(age), E(age^2), E(ahe*age) to calculate all the variance / covariance / correlation
// E(ahe^2) = \sum_{i} (ahe_i)^2 * f_ahe(ahe_i)
use "Earnings", clear
drop ahe
xpose, clear
collapse (sum) v1-v29
save "marginal_ahe", replace

use "Earnings", clear
keep ahe
xpose, clear
append using "marginal_ahe"
xpose, clear
rename (v1 v2) (ahe marginal_ahe)

gen ahe2_weight = ahe^2 * marginal_ahe
collapse (sum) ahe2_weight
rename ahe2_weight E_ahe2
local ahe2_mean_l E_ahe2
display "E(ahe^2) = " `ahe2_mean_l'

// E(age)
use "marginal_age", clear
xpose, clear
egen age = seq(), from(25) to(34)
gen age_weight = v1 * age
collapse (sum) age_weight
rename age_weight E_age
local age_mean_l E_age
display "E(age) = " `age_mean_l'

// E(age^2)
use "marginal_age", clear
xpose, clear
egen age = seq(), from(25) to(34)
gen age_weight = v1 * age^2
collapse (sum) age_weight
rename age_weight E_age2
local age2_mean_l E_age2
display "E(age^2) = " `age2_mean_l'

// E(ahe*age) = \sum_{i, j} (ahe_i * age_j) * f(ahe_i, age_j)
use "Earnings", clear
forval i = 25/34 {
	replace age_`i' = age_`i' * ahe * `i'
}
collapse (sum) age_25 age_26 age_27 age_28 age_29 age_30 age_31 age_32 age_33 age_34
xpose, clear
collapse (sum) v1
rename v1 ahe_age_inter_mean
local ahe_age_inter_mean_l ahe_age_inter_mean
display "E(ahe*age) = " `ahe_age_inter_mean_l'


/*
The rest of e-g is to calculate the actual statistics asked by hand: 
Var(ahe) = E(ahe^2) - [E(AHE)]^2
Cov(ahe, age) = E(ahe * age) - E(ahe)*E(age)
Corr(ahe, age) = Cov(ahe, age) / [ sd(ahe) * sd(age) ]   <- sd(ahe) = sqrt(Var(ahe)); sd(age) = sqrt(Var(age))
*/


/*
Actual program ends here
*/

// Close log
log close



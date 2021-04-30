// 400 Dis 13 Do file

// Make sure you change your working directory first! 

// Setup
clear all
set more off // tells Stata not to pause or display the more message




/*
Problem 2
*/

// (a) Merge Two Datasets
import delimited "400_sp21_dis-13_data-1.csv", clear
save "400_sp21_dis-13_data-1.dta", replace

import delimited "400_sp21_dis-13_data-2.csv", clear
merge 1:1 id using "400_sp21_dis-13_data-1.dta"

// (c) Use residual plot to identify heteroskedasticity
reg colgpa hsgpa act soph junior senior campus greek alcohol
rvfplot, yline(0)

// (d) Interaction term on hsgpa
reg colgpa hsgpa act soph junior senior campus greek alcohol i.male#c.hsgpa 

// (e) Create binary variable of highcolgpa
gen highcolgpa = 0
replace highcolgpa = 1 if colgpa >= 3.5

reg highcolgpa hsgpa act soph junior senior campus greek alcohol, robust // need robust option for linear probability model

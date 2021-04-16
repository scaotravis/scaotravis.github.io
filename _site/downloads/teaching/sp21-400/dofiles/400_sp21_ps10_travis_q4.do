// 400 PS 10
// Travis Cao

// Set up environment
clear all
set more off




/*
Problem #4
*/

sysuse nlsw88, clear
reg wage union hours age grade collgrad married south smsa c_city ttl_exp tenure

// Rename variables
rename (hours age grade collgrad married south smsa c_city ttl_exp tenure) (v1 v2 v3 v4 v5 v6 v7 v8 v9 v10)

// Regress on all possible combinations, while retaining results
local counter = 0
local sum_coef = 0
local sum_stat_significant = 0
local sum_se = 0 
local sum_positive = 0
local xvars union

forval i1 = 0/1 { // either include variable 1 or not; hence the iteration from 0 to 1
forval i2 = 0/1 {
forval i3 = 0/1 {
forval i4 = 0/1 {
forval i5 = 0/1 {
forval i6 = 0/1 {
forval i7 = 0/1 {
forval i8 = 0/1 {
forval i9 = 0/1 {
forval i10 = 0/1 {
		
	// Keep track on the number of rounds of iteration
	local counter = `counter' + 1
		
	if `i1' == 1 {
		local xvars `xvars' v1
	}
	if `i2' == 1 {
		local xvars `xvars' v2
	}
	if `i3' == 1 {
		local xvars `xvars' v3
	}
	if `i4' == 1 {
		local xvars `xvars' v4
	}
	if `i5' == 1 {
		local xvars `xvars' v5
	}
	if `i6' == 1 {
		local xvars `xvars' v6
	}
	if `i7' == 1 {
		local xvars `xvars' v7
	}
	if `i8' == 1 {
		local xvars `xvars' v8
	}
	if `i9' == 1 {
		local xvars `xvars' v9
	}
	if `i10' == 1 {
		local xvars `xvars' v10
	}
	
	// Running the regression
	quietly reg wage `xvars', robust // quietly syntax suppress output in the result window
	
	// Storing relevant regression result
	local sum_coef = `sum_coef' + e(b)[1, 1]
	
	if (e(b)[1, 1] > 0) {
		local sum_positive = `sum_positive' + 1
	}
	
	local sum_se = `sum_se' + sqrt(e(V)[1, 1])
	
	quietly test union
	
	if (r(p) < .05) {
		local sum_stat_significant = `sum_stat_significant' + 1
	}
	
	// Reset xvars
	local xvars union
	
}
}
}
}
}
}
}
}
}
}

disp "Total number of regressions run = " `counter'
disp "(a) Average value of coef estimate on union = " `sum_coef' / `counter'
disp "(b) Portion of coef estimates that are statistically significant at 5% size = " (`sum_stat_significant' / `counter') * 100 "%"
disp "(b) Average Robust SE of coef = " `sum_se' / `counter'
disp "(c) Portion of coef estimates that are positive = " (`sum_positive' / `counter') * 100 "%"

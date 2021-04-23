// 400 PS 11 Q1
// Travis Cao

// Set up environment
clear all
set more off




/*
Problem #1
*/




/*
(a)
*/

// (i)
set seed 1111
quietly set obs 100

gen e = rnormal()
quietly gen Y = e in 1
forvalues i = 2/`=_N' {
	quietly replace Y = Y[_n-1] + e[_n] in `i'
}

// (ii)
gen a = rnormal()
quietly gen X = a in 1
forvalues i = 2/`=_N' {
	quietly replace X = X[_n-1] + a[_n] in `i'
}

// (iii)
reg Y X



/*
(b) Repeat (a) 1000 times, with T = 100
*/

matrix R2 = J(1000,1,0)
matrix t_stat = J(1000,1,0)

forvalues s = 1/1000 {
	
	clear
	quietly set obs 100
	gen e = rnormal()
	quietly gen Y = e in 1
	forvalues i = 2/`=_N' {
		quietly replace Y = Y[_n-1] + e[_n] in `i'
	}

	gen a = rnormal()
	quietly gen X = a in 1
	forvalues i = 2/`=_N' {
		quietly replace X = X[_n-1] + a[_n] in `i'
	}

	quietly reg Y X	
	matrix R2[`s', 1] = e(r2)
	
	quietly test X
	matrix t_stat[`s', 1] = sign(_b[X]) * sqrt(r(F))
	
}

disp "Result for T = " _N ": "

svmat double R2
svmat double t_stat

summarize R21, detail
summarize t_stat1, detail

// Portion of t-stat whose absolute value exceeds 1.96 
local sum_significant = 0

forvalues s = 1/1000 {
	
	if (abs(t_stat1[`s']) > 1.96) {
		local sum_significant = `sum_significant' + 1
	}
	
}

disp "Fraction of simulated dataset with t-statistic exceeding 1.96 in absolute value = " `sum_significant' / 1000 * 100 "%"



/*
(c) Try (b) with different T
*/

// T = 50
clear all
matrix R2 = J(1000,1,0)
matrix t_stat = J(1000,1,0)

forvalues s = 1/1000 {
	
	clear
	quietly set obs 50
	gen e = rnormal()
	quietly gen Y = e in 1
	forvalues i = 2/`=_N' {
		quietly replace Y = Y[_n-1] + e[_n] in `i'
	}

	gen a = rnormal()
	quietly gen X = a in 1
	forvalues i = 2/`=_N' {
		quietly replace X = X[_n-1] + a[_n] in `i'
	}

	quietly reg Y X	
	matrix R2[`s', 1] = e(r2)
	
	quietly test X
	matrix t_stat[`s', 1] = sign(_b[X]) * sqrt(r(F))
	
}

disp "Result for T = " _N ": "

svmat double R2
svmat double t_stat

summarize R21, detail
summarize t_stat1, detail

// Portion of t-stat whose absolute value exceeds 1.96 
local sum_significant = 0

forvalues s = 1/1000 {
	
	if (abs(t_stat1[`s']) > 1.96) {
		local sum_significant = `sum_significant' + 1
	}
	
}

disp "Fraction of simulated dataset with t-statistic exceeding 1.96 in absolute value = " `sum_significant' / 1000 * 100 "%"




// T = 200
clear all
matrix R2 = J(1000,1,0)
matrix t_stat = J(1000,1,0)

forvalues s = 1/1000 {
	
	clear
	quietly set obs 200
	gen e = rnormal()
	quietly gen Y = e in 1
	forvalues i = 2/`=_N' {
		quietly replace Y = Y[_n-1] + e[_n] in `i'
	}

	gen a = rnormal()
	quietly gen X = a in 1
	forvalues i = 2/`=_N' {
		quietly replace X = X[_n-1] + a[_n] in `i'
	}

	quietly reg Y X	
	matrix R2[`s', 1] = e(r2)
	
	quietly test X
	matrix t_stat[`s', 1] = sign(_b[X]) * sqrt(r(F))
	
}

disp "Result for T = " _N ": "

svmat double R2
svmat double t_stat

summarize R21, detail
summarize t_stat1, detail

// Portion of t-stat whose absolute value exceeds 1.96 
local sum_significant = 0

forvalues s = 1/1000 {
	
	if (abs(t_stat1[`s']) > 1.96) {
		local sum_significant = `sum_significant' + 1
	}
	
}

disp "Fraction of simulated dataset with t-statistic exceeding 1.96 in absolute value = " `sum_significant' / 1000 * 100 "%"




// T = 1000
clear all
matrix R2 = J(1000,1,0)
matrix t_stat = J(1000,1,0)

forvalues s = 1/1000 {
	
	clear
	quietly set obs 1000
	gen e = rnormal()
	quietly gen Y = e in 1
	forvalues i = 2/`=_N' {
		quietly replace Y = Y[_n-1] + e[_n] in `i'
	}

	gen a = rnormal()
	quietly gen X = a in 1
	forvalues i = 2/`=_N' {
		quietly replace X = X[_n-1] + a[_n] in `i'
	}

	quietly reg Y X	
	matrix R2[`s', 1] = e(r2)
	
	quietly test X
	matrix t_stat[`s', 1] = sign(_b[X]) * sqrt(r(F))
	
}

disp "Result for T = " _N ": "

svmat double R2
svmat double t_stat

summarize R21, detail
summarize t_stat1, detail

// Portion of t-stat whose absolute value exceeds 1.96 
local sum_significant = 0

forvalues s = 1/1000 {
	
	if (abs(t_stat1[`s']) > 1.96) {
		local sum_significant = `sum_significant' + 1
	}
	
}

disp "Fraction of simulated dataset with t-statistic exceeding 1.96 in absolute value = " `sum_significant' / 1000 * 100 "%"

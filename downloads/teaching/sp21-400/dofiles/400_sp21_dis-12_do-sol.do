// 400 Dis 12 Do file

// Make sure you change your working directory first! 

// Setup
clear all
set more off // tells Stata not to pause or display the more message




/*
Problem 1
*/

// (a) Transform date to Date type

// Date information recorded in two columns
use "http://fmwww.bc.edu/ec-p/data/wooldridge/cement.dta", clear
gen date2 = ym(year, month)
format date2 %tm
browse year month date2
tsset date2
tsline ip

// Daily data: S&P 500
import delimited "https://scaotravis.github.io/downloads/teaching/sp21-400/datasets/sp500.csv", clear
gen date2 = date(date, "YMD")
format date2 %td // %td specifies that data should be a time-series of daily frequency
tsset date2
tsline sp500

// Monthly data: Personal savings rate
import delimited "https://scaotravis.github.io/downloads/teaching/sp21-400/datasets/psr.csv", clear
gen date2 = mofd(date(date, "YMD")) // mofd() function gets out month from the date
format date2 %tm // %tm specifies that data should be a time-series of monthly frequency
tsset date2
tsline psr

// Quarterly data: Private fixed investment
import delimited "https://scaotravis.github.io/downloads/teaching/sp21-400/datasets/pfi.csv", clear
gen date2 = qofd(date(date, "YMD")) // qofd() function gets out quarter from the date
format date2 %tq // %tq specifies that data should be a time-series of quarterly frequency
tsset date2
tsline pfi

// (b) Create plots for pfi to determine stationarity
tsline pfi
graph export "400_sp21_dis-12_b-tsline.png", replace

ac pfi
graph export "400_sp21_dis-12_b-ac.png", replace

pac pfi
graph export "400_sp21_dis-12_b-pac.png", replace

// (c) Dickey-Fuller tests
dfuller pfi, drift
dfuller pfi, trend

// (d) Try first difference of pfi
gen pfi_fd = pfi - l.pfi
tsline pfi_fd
graph export "400_sp21_dis-12_d.png", replace

dfuller pfi_fd // run dfuller test one more time to make sure that the data is stationary

// (e) Determine number of lags to include using ACF
ac pfi_fd
graph export "400_sp21_dis-12_e.png", replace

// (f) Construct pseudo out-of-sample estimate of MSFE
reg pfi_fd l.pfi_fd if date2 < tq(2005, 1)
predict forecast_error, residuals
gen squared_forecast_error = forecast_error^2
keep if date2 >= tq(2005, 1)

local MSFE = sum( squared_forecast_error ) / `=_N' // `=_N' evaluates the number of observations in the data. Since data is now all the pseudo out-of-sample portion, this equals to the number of pseudo out-of-sample observations  
disp "Pseudo out-of-sample estimate of MSFE = " `MSFE'


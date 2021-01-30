***Week 1 Discussion Sessions***

clear all
cd "E:\Wisc\Study\Econ400_TA\Discussions\400_Dis_1\400_sp21_dis-1_dataset"

log using stata_week1, replace

*****Q1*****
import excel "gss2014.xls" //import gss2014.xls
import delimited "gss2014.csv", rowrange(1:2) clear //import first row of gss2014.csv
save "gss2014.dta", replace //save dataset
use "gss2014.dta", clear //open gss2014.dta

*****Q2*****
use "panel2007.dta", clear
browse
describe
destring(id), replace
save "panel2007.dta", replace
****Learn basic information of variables
codebook score
tabulate score   //tab score
summarize score  //sum score
summarize score, detail  //sum score, d 

*****Q3*****
****Way 1
gen year=2007 //generate a variable called year
save "panel2007_append", replace
use "panel2008.dta", clear //Load panel2008 data into Stata
gen year=2008 //Generate the year variable for the 2008 data
append using "panel2007_append.dta" //Grab the 2007 data we saved before, and appending it to the 2008 dataset
save "appended_data.dta", replace //Save the appended data

****Way 2
use "panel2007.dta", clear
rename score score2007
save "panel2007 merge", replace
use "panel2008.dta", clear
rename score score2008
merge 1:1 id using "panel2007 merge"
save "merge_data.dta", replace

log close

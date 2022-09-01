clear all
set more off
import delimited "GPA.csv", clear
browse
describe
summarize hsgpa, detail
histogram hsgpa
correlate hsgpa act
scatter act hsgpa
ttest hsgpa=3.5, level(90)

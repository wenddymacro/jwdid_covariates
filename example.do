******************************************
* Wenli Wenddy Xu,Anhui University
* 2022-08-03
******************************************


use "Divorce-Wolfers-AER.dta", clear 
set matsize 1000


/* Matrix saving the average effects from 0 to 7 years after the law, from the 
different methods */
matrix res_avg = J(5,2,0)

* Part 1 Wolfers' results in table 2, w/o linear time trends
xi i.years_unilateral i.st i.year 
quietly: reg div_rate _I* if year>1955 & year<1989 [w=stpop]

matrix temp = e(V)
matrix V_b = temp[1..4,1..4]
matrix e2 = J(4,1,1/4)

matrix temp=r(table)'
matrix res = ((0\1\2\3), temp[1..4,1], temp[1..4,5], temp[1..4,6])
matrix list res

matrix res_avg[1,1] = res[1..4,2]'*e2

matrix temp = e2'*(V_b*e2)
matrix res_avg[1,2] = sqrt(temp[1,1])

encode st, generate(state)

gen unilateral_year=unilateral*year
replace unilateral_year=3000 if unilateral_year==0
bys state: egen cohort=min(unilateral_year)
replace cohort=. if cohort==3000
gen controlgroup=(cohort==.)
replace cohort=0 if cohort==.

// without covariates

jwdid div_rate if year>1955 & year<1989 [weight=stpop], ivar(state) tvar(year) gvar(cohort)

estat event

// plot
/*  produce a graph */ 
matrix temp=r(table)'
matrix res=J(12,4,0)

forvalues x = 0/11 {
matrix res[`x'+1,1]=`x'
matrix res[`x'+1,2]=temp[`x'+1,1]
matrix res[`x'+1,3]=temp[`x'+1,5]
matrix res[`x'+1,4]=temp[`x'+1,6]
}

preserve
drop _all
svmat res
twoway (scatter res2 res1, msize(medlarge) msymbol(o) mcolor(navy) legend(off)) ///
	(line res2 res1, lcolor(navy)) (rcap res4 res3 res1, lcolor(maroon)), ///
	 title("Wooldridge's Method") xtitle("Relative Time to Event") ///
	 ytitle("Effect") yline(0,lp(dash)) yscale(range(-0.02 0))

// with covariates

jwdid div_rate evdiv50 married if year>1955 & year<1989 [weight=stpop], ivar(state) tvar(year) gvar(cohort)

estat event

// plot
/*  produce a graph */ 
matrix temp=r(table)'
matrix res=J(12,4,0)

forvalues x = 0/11 {
matrix res[`x'+1,1]=`x'
matrix res[`x'+1,2]=temp[`x'+1,1]
matrix res[`x'+1,3]=temp[`x'+1,5]
matrix res[`x'+1,4]=temp[`x'+1,6]
}

preserve
drop _all
svmat res
twoway (scatter res2 res1, msize(medlarge) msymbol(o) mcolor(navy) legend(off)) ///
	(line res2 res1, lcolor(navy)) (rcap res4 res3 res1, lcolor(maroon)), ///
	 title("Wooldridge's Method") xtitle("Relative Time to Event") ///
	 ytitle("Effect") yline(0,lp(dash)) yscale(range(-0.02 0))



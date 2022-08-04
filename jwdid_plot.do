/* As above, to produce a graph and compute average effects */ 
matrix temp=r(table)'
matrix res=J(4,4,0)
/* matrix res[10,1]=-1
forvalues x = 3/11 {
matrix res[`x'-2,1]=`x'-13
matrix res[`x'-2,2]=temp[`x',1]
matrix res[`x'-2,3]=temp[`x',5]
matrix res[`x'-2,4]=temp[`x',6]
}
*/
forvalues x = 1/4 {
matrix res[`x',1]=`x'
matrix res[`x',2]=temp[`x',1]
matrix res[`x',3]=temp[`x',5]
matrix res[`x',4]=temp[`x',6]
}

preserve
drop _all
svmat res
twoway (scatter res2 res1, msize(medlarge) msymbol(o) mcolor(navy) legend(off)) ///
	(line res2 res1, lcolor(navy)) (rcap res4 res3 res1, lcolor(maroon)), ///
	 title("Wooldridge") xtitle("Relative Time to Event") ///
	 ytitle("Effect") yline(0,lp(dash)) yscale(range(-0.02 0))

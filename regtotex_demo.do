/*******************************************************************************
																			   
	    Exporting regression results to LaTeX, with different fixed effects 						       
				      		 Elena Casanovas, Dec 2020 				 	   	   	   
		   	   																   
*******************************************************************************/
	cd "/Users/elenacasanovas/Desktop/untitled folder 2"
	
*-- 01. Run regressions 
	webuse regsmpl.dta, clear
	eststo clear
	
	eststo: reg ln_wage grade tenure // Reg 1, plain
	
	eststo: reg ln_wage grade tenure i.year  // Reg 2, year FE 
	estadd  local yearfe "Y", replace
	
	eststo: reg ln_wage grade tenure i.year i.age // Reg 3, year and age FE
	estadd  local yearfe "Y", replace
	estadd  local agefe  "Y", replace
	
	
*-- 02. Export results to LaTeX	
	label var ln_wage "Wage"
	label var grade   "Grade"
	label var tenure  "Job tenure"
	
	#delimit ;
	esttab using "reg_demo.tex", se ar2 label nostar obslast k(grade tenure) 
	s(yearfe agefe r2 N, 
	label("Year FE" "Age FE" "R-squared" "Observations")) replace ; 
	#delimit cr 
	
	
							*	End of the do-file	*

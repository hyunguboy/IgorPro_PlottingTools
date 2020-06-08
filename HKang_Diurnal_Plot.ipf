#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#Pragma version = 1.00

//	2020 Hyungu Kang, www.hazykinetics.com, hyunguboy@gmail.com
//
//	Version 1.0 (Released 2020-01-31)
//	1.	Initial release tested with Igor Pro 6.37 and 8.04.

////////////////////////////////////////////////////////////////////////////////

//	Take time and concentration wave and create diurnal plots on an
//	hourly basis.
//	
//	
//	
//	
//	

////////////////////////////////////////////////////////////////////////////////

//	Get diurnal plot.
Function HKang_DiurnalPlot(w_conc, w_time)
	Wave w_conc, w_time

	Variable iloop, jloop

	// Make time bins.
	Make/O/D/N=25 w_DiurnalBins1hr = NaN

	For(iloop = 0; iloop < numpnts(w_DiurnalBins1hr); iloop += 1)
		w_DiurnalBins1hr[iloop] = iloop
	EndFor

	// Center of those time bins.
	Make/O/D/N=24 w_DiurnalBinCenters = NaN

	For(iloop = 0; iloop < numpnts(w_DiurnalBinCenters); iloop += 1)
		w_DiurnalBinCenters[iloop] = 0.5 + iloop
	EndFor

	// Waves of statistics for concentration values in each time bin.
	Make/O/D/N=24 w_DiurnalMean = NaN
	Make/O/D/N=24 w_DiurnalStdDev = NaN
	Make/O/D/N=24 w_DiurnalMedian = NaN
	Make/O/D/N=24 w_Diurnal90p = NaN
	Make/O/D/N=24 w_Diurnal75p = NaN
	Make/O/D/N=24 w_Diurnal25p = NaN
	Make/O/D/N=24 w_Diurnal10p = NaN

	// Waves of concentrations of each time bin.
	Make/O/D/N=0 w_DiurnalBin1
	Make/O/D/N=0 w_DiurnalBin2
	Make/O/D/N=0 w_DiurnalBin3
	Make/O/D/N=0 w_DiurnalBin4
	Make/O/D/N=0 w_DiurnalBin5
	Make/O/D/N=0 w_DiurnalBin6
	Make/O/D/N=0 w_DiurnalBin7
	Make/O/D/N=0 w_DiurnalBin8
	Make/O/D/N=0 w_DiurnalBin9
	Make/O/D/N=0 w_DiurnalBin10
	Make/O/D/N=0 w_DiurnalBin11
	Make/O/D/N=0 w_DiurnalBin12
	Make/O/D/N=0 w_DiurnalBin13
	Make/O/D/N=0 w_DiurnalBin14
	Make/O/D/N=0 w_DiurnalBin15
	Make/O/D/N=0 w_DiurnalBin16
	Make/O/D/N=0 w_DiurnalBin17
	Make/O/D/N=0 w_DiurnalBin18
	Make/O/D/N=0 w_DiurnalBin19
	Make/O/D/N=0 w_DiurnalBin20
	Make/O/D/N=0 w_DiurnalBin21
	Make/O/D/N=0 w_DiurnalBin22
	Make/O/D/N=0 w_DiurnalBin23
	Make/O/D/N=0 w_DiurnalBin24
	
	
	
	
	
	// Fill the output waves.
	For(iloop = 0; iloop < numpnts(w_DiurnalBins1hr); iloop += 1)
		For(jloop = 0; jloop < numpnts(w_time); jloop += 1






	EndFor



End
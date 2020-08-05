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

Function HKang_DisplayDiurnalPlot()






End

////////////////////////////////////////////////////////////////////////////////

//	Get hourly waves for diurnal plot.
Function HKang_GetHourlyWaves(w_conc, w_time)
	Wave w_conc, w_time

	Variable v_binMax, v_binMin
	Variable iloop, jloop
	String str_waveTemp

	// Make new data folder to store these waves.
	NewDataFolder/O/S getdatafolderDFR():Diurnal

	// Make time bins.
	Make/O/D/N=25 w_DiurnalBins1hr = NaN

	For(iloop = 0; iloop < numpnts(w_DiurnalBins1hr); iloop += 1)
		w_DiurnalBins1hr[iloop] = iloop
	EndFor

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

	// Fill the output waves. Start with each time bin.
	For(iloop = 0; iloop < numpnts(w_DiurnalBins1hr); iloop += 1)
		v_binMax = w_DiurnalBins1hr[iloop + 1]
		v_binMin = w_DiurnalBins1hr[iloop]
		
		// Go through w_time and find points.
		For(jloop = 0; jloop < numpnts(w_time); jloop += 1)
			If(w_time[jloop] > v_binMin && w_time[jloop] <= v_binMax && numtype(w_conc[jloop]) == 0)
				str_waveTemp = "w_DiurnalBin" + num2str(iloop + 1)

				Wave w_binWaveRef = $str_waveTemp

				InsertPoints/M=0 numpnts(w_binWaveRef), 1, w_binWaveRef

				w_binWaveRef[numpnts(w_binWaveRef) - 1] = w_conc[jloop]
			EndIf
		EndFor
	EndFor

End

////////////////////////////////////////////////////////////////////////////////

//	Get statistics and waves to be displayed on the diurnal plot.
Function HKang_GetHourlyStats()

	Variable iloop, jloop
	String str_waveTemp0, str_waveTemp1

	SetDataFolder getdatafolderDFR():Diurnal

	// Center of those time bins for graph x-axis.
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

	// Get statistics for diurnal plot.
	For(iloop = 0; iloop < 25; iloop += 1)
		str_waveTemp0 = "w_DiurnalBin" + num2str(iloop + 1)

		Wave w_binWaveRef0 = $str_waveTemp0

		Wavestats/Q w_binWaveRef0
		StatsQuantiles/Q w_binWaveRef0

		w_DiurnalMean[iloop] = V_avg
		w_DiurnalStdDev[iloop] = V_sdev
		w_DiurnalMedian[iloop] = V_Median
		w_Diurnal75p[iloop] = V_Q75
		w_Diurnal25p[iloop] = V_Q25	
	EndFor

	// Get 10 and 90 % points removed waves to be displayed on the diurnal plot.
	For(iloop = 0; iloop < 25; iloop += 1)
		str_waveTemp0 = "w_DiurnalBin" + num2str(iloop + 1)
		str_waveTemp1 = "w_DiurnalBin" + num2str(iloop + 1) + "_1090"

		Wave w_binWaveRef0 = $str_waveTemp0
		Wave w_binWaveRef1 = $str_waveTemp1

		Duplicate/O w_binWaveRef0, w_binWaveRef1

		Sort w_binWaveRef1, w_binWaveRef1

		For(jloop = 0; jloop < numpnts(w_binWaveRef1); jloop += 1)
			If(jloop < numpnts(w_binWaveRef1)/10 || jloop > 9 * numpnts(w_binWaveRef1)/10)
				w_binWaveRef1[jloop] = NaN
			EndIf
		EndFor
	EndFor

End

////////////////////////////////////////////////////////////////////////////////

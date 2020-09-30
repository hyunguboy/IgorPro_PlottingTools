#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#Pragma version = 1.1

//	2020 Hyungu Kang, www.hazykinetics.com, hyunguboy@gmail.com
//
//	Version 1.1 (Released 2020-08-07)
//	1.	No longer compatible with Igor Pro 6 as transparency has been
//		incorporated into the figures.
//	2.	Changed code formatting for consistency.
//
//	Version 1.0 (Released 2020-01-31)
//	1.	Initial release tested with Igor Pro 6.37 and 8.04.

////////////////////////////////////////////////////////////////////////////////

//	Takes time and concentration waves and creates diurnal plots on an
//	hourly basis.
//	
//	
//	
//	
//	

////////////////////////////////////////////////////////////////////////////////

Function HKang_DisplayDiurnalPlot(w_conc, w_time)
	Wave w_conc, w_time

	Variable iloop
	String str_waveTemp0, str_waveTemp1

	DFREF dfr_current = getdatafolderDFR()

	// Make new data folder to store these waves.
	If(dataFolderExists("root:DiurnalPlot") != 1)
		NewDataFolder/O root:DiurnalPlot
		NewDataFolder/O root:DiurnalPlot:StatisticsWaves
		NewDataFolder/O root:DiurnalPlot:PlotWaves
	ElseIf(dataFolderExists("root:DiurnalPlot:FigureWaves") != 1)
		NewDataFolder/O root:DiurnalPlot:StatisticsWaves
		NewDataFolder/O root:DiurnalPlot:PlotWaves
	EndIf

	HKang_GetHourlyWaves(w_conc, w_time)
	HKang_GetHourlyStats()

	// Call diurnal statistics waves to be displayed on the plot.
	// w_DiurnalBinCenters: X-axis wave on diurnal plot.
	// w_DiurnalMean: Average of values in each hourly bin.
	// w_DiurnalStdDev: Standard deviation of values in each hourly bin.
	// w_DiurnalMedian: Median of values in each hourly bin.
	// w_Diurnal90p: Upper 90% point in each hourly bin.
	// w_Diurnal75p: Upper 75% point in each hourly bin.
	// w_Diurnal25p: Upper 25% point in each hourly bin.
	// w_Diurnal10p: Upper 10% point in each hourly bin.
	Wave w_DiurnalBinCenters = root:DiurnalPLot:StatisticsWaves:w_DiurnalBinCenters
	Wave w_DiurnalMean = root:DiurnalPlot:StatisticsWaves:w_DiurnalMean
	Wave w_DiurnalStdDev = root:DiurnalPlot:StatisticsWaves:w_DiurnalStdDev
	Wave w_DiurnalMedian = root:DiurnalPlot:StatisticsWaves:w_DiurnalMedian
	Wave w_Diurnal90p = root:DiurnalPlot:StatisticsWaves:w_Diurnal90p
	Wave w_Diurnal75p = root:DiurnalPlot:StatisticsWaves:w_Diurnal75p
	Wave w_Diurnal25p = root:DiurnalPlot:StatisticsWaves:w_Diurnal25p
	Wave w_Diurnal10p = root:DiurnalPlot:StatisticsWaves:w_Diurnal10p

	// Call waves with points to be displayed on the diurnal plot.
	Wave w_DiurnalBin0_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin0_1090
	Wave w_DiurnalBin1_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin1_1090
	Wave w_DiurnalBin2_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin2_1090
	Wave w_DiurnalBin3_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin3_1090
	Wave w_DiurnalBin4_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin4_1090
	Wave w_DiurnalBin5_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin5_1090
	Wave w_DiurnalBin6_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin6_1090
	Wave w_DiurnalBin7_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin7_1090
	Wave w_DiurnalBin8_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin8_1090
	Wave w_DiurnalBin9_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin9_1090
	Wave w_DiurnalBin10_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin10_1090
	Wave w_DiurnalBin11_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin11_1090
	Wave w_DiurnalBin12_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin12_1090
	Wave w_DiurnalBin13_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin13_1090
	Wave w_DiurnalBin14_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin14_1090
	Wave w_DiurnalBin15_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin15_1090
	Wave w_DiurnalBin16_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin16_1090
	Wave w_DiurnalBin17_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin17_1090
	Wave w_DiurnalBin18_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin18_1090
	Wave w_DiurnalBin19_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin19_1090
	Wave w_DiurnalBin20_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin20_1090
	Wave w_DiurnalBin21_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin21_1090
	Wave w_DiurnalBin22_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin22_1090
	Wave w_DiurnalBin23_1090 = root:DiurnalPlot:PlotWaves:w_DiurnalBin23_1090

	Wave w_DiurnalBin0_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin0_xaxis
	Wave w_DiurnalBin1_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin1_xaxis
	Wave w_DiurnalBin2_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin2_xaxis
	Wave w_DiurnalBin3_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin3_xaxis
	Wave w_DiurnalBin4_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin4_xaxis
	Wave w_DiurnalBin5_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin5_xaxis
	Wave w_DiurnalBin6_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin6_xaxis
	Wave w_DiurnalBin7_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin7_xaxis
	Wave w_DiurnalBin8_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin8_xaxis
	Wave w_DiurnalBin9_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin9_xaxis
	Wave w_DiurnalBin10_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin10_xaxis
	Wave w_DiurnalBin11_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin11_xaxis
	Wave w_DiurnalBin12_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin12_xaxis
	Wave w_DiurnalBin13_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin13_xaxis
	Wave w_DiurnalBin14_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin14_xaxis
	Wave w_DiurnalBin15_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin15_xaxis
	Wave w_DiurnalBin16_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin16_xaxis
	Wave w_DiurnalBin17_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin17_xaxis
	Wave w_DiurnalBin18_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin18_xaxis
	Wave w_DiurnalBin19_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin19_xaxis
	Wave w_DiurnalBin20_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin20_xaxis
	Wave w_DiurnalBin21_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin21_xaxis
	Wave w_DiurnalBin22_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin22_xaxis
	Wave w_DiurnalBin23_xaxis = root:DiurnalPlot:PlotWaves:w_DiurnalBin23_xaxis
	
	// Display diurnal plot.
	Display/K=1 w_DiurnalMean vs w_DiurnalBinCenters
	AppendToGraph w_DiurnalBin0_1090 vs w_DiurnalBin0_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin1_1090 vs w_DiurnalBin1_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin2_1090 vs w_DiurnalBin2_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin3_1090 vs w_DiurnalBin3_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin4_1090 vs w_DiurnalBin4_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin5_1090 vs w_DiurnalBin5_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin6_1090 vs w_DiurnalBin6_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin7_1090 vs w_DiurnalBin7_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin8_1090 vs w_DiurnalBin8_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin9_1090 vs w_DiurnalBin9_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin10_1090 vs w_DiurnalBin10_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin11_1090 vs w_DiurnalBin11_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin12_1090 vs w_DiurnalBin12_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin13_1090 vs w_DiurnalBin13_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin14_1090 vs w_DiurnalBin14_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin15_1090 vs w_DiurnalBin15_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin16_1090 vs w_DiurnalBin16_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin17_1090 vs w_DiurnalBin17_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin18_1090 vs w_DiurnalBin18_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin19_1090 vs w_DiurnalBin19_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin20_1090 vs w_DiurnalBin20_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin21_1090 vs w_DiurnalBin21_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin22_1090 vs w_DiurnalBin22_xaxis; DelayUpdate
	AppendToGraph w_DiurnalBin23_1090 vs w_DiurnalBin23_xaxis; DelayUpdate

	// 
	SetAxis bottom 0,24
	ModifyGraph nticks(bottom)=24
	ModifyGraph manTick(bottom)={0,1,0,0}, manMinor(bottom)={0,0}
	ModifyGraph mode(w_DiurnalMean)=4, mrkThick(w_DiurnalMean)=2
	ModifyGraph msize(w_DiurnalMean)=2, lsize(w_DiurnalMean)=2
	Label bottom "Hour of Day"

	SetDataFolder dfr_current

End

////////////////////////////////////////////////////////////////////////////////

//	Get hourly waves for diurnal plot. Each diurnal bin wave contains all the
//	concentration measurements that occurred within that hourly bin.
Function HKang_GetHourlyWaves(w_conc, w_time)
	Wave w_conc, w_time

	Variable v_binMax, v_binMin
	Variable v_hourMinute
	Variable iloop, jloop
	Variable v_year, v_month, v_day
	String str_waveTemp

	// Make time bins.
	Make/O/D/N=24 w_DiurnalBins1hr = NaN

	For(iloop = 0; iloop < numpnts(w_DiurnalBins1hr); iloop += 1)
		w_DiurnalBins1hr[iloop] = iloop
	EndFor

	// Waves of concentrations of each time bin.
	Make/O/D/N=0 w_DiurnalBin0
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

	// Fill the output waves. Start with each time bin.
	For(iloop = 0; iloop < numpnts(w_DiurnalBins1hr); iloop += 1)
		v_binMin = iloop * 3600
		v_binMax = (iloop + 1) * 3600

		str_waveTemp = "w_DiurnalBin" + num2str(iloop)

		Wave w_binWaveRef = root:Diurnal:$str_waveTemp

		// Go through w_time and find points.
		For(jloop = 0; jloop < numpnts(w_time); jloop += 1)
			sscanf secs2date(w_time[jloop], -2), "%i-%i-%i", v_year, v_month, v_day

			v_hourMinute = w_time[jloop] - date2secs(v_year, v_month, v_day)

			If(v_hourMinute > v_binMin && v_hourMinute <= v_binMax && numtype(w_conc[jloop]) == 0)
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

	// Center of those time bins for graph x-axis.
	Make/O/D/N=24 w_DiurnalBinCenters = NaN

	For(iloop = 0; iloop < numpnts(w_DiurnalBinCenters); iloop += 1)
		w_DiurnalBinCenters[iloop] = 0.5 + iloop
	EndFor

	// Make x-axis wave for each time bin.
	For(iloop = 0; iloop < 24; iloop += 1)
		str_waveTemp0 = "w_DiurnalBin" + num2str(iloop)
		str_waveTemp1 = "w_DiurnalBin" + num2str(iloop) + "_xaxis"
	
		Wave w_binWaveRef0 = root:Diurnal:$str_waveTemp0

		Duplicate/O w_binWaveRef0, $str_waveTemp1
		
		Wave w_binWaveRef1 = root:Diurnal:$str_waveTemp1

		w_binWaveRef1 = NaN
	
		For(jloop = 0; jloop < numpnts(w_binWaveRef1); jloop += 1)
			w_binWaveRef1[jloop] = w_DiurnalBinCenters[iloop] + enoise(0.2)
		EndFor
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
	For(iloop = 0; iloop < 24; iloop += 1)
		str_waveTemp0 = "w_DiurnalBin" + num2str(iloop)

		Wave w_binWaveRef0 = root:Diurnal:$str_waveTemp0

		Wavestats/Q w_binWaveRef0
		StatsQuantiles/Q w_binWaveRef0

		w_DiurnalMean[iloop] = V_avg
		w_DiurnalStdDev[iloop] = V_sdev
		w_DiurnalMedian[iloop] = V_Median
		w_Diurnal75p[iloop] = V_Q75
		w_Diurnal25p[iloop] = V_Q25	
	EndFor

	// Get 10 and 90 % points removed waves to be displayed on the diurnal plot.
	For(iloop = 0; iloop < 24; iloop += 1)
		str_waveTemp0 = "w_DiurnalBin" + num2str(iloop)
		str_waveTemp1 = "w_DiurnalBin" + num2str(iloop) + "_1090"

		Wave w_binWaveRef0 = root:Diurnal:$str_waveTemp0

		Duplicate/O w_binWaveRef0, $str_waveTemp1

		Wave w_binWaveRef1 = root:Diurnal:$str_waveTemp1

		Sort w_binWaveRef1, w_binWaveRef1

		For(jloop = 0; jloop < numpnts(w_binWaveRef1); jloop += 1)
			If(jloop < numpnts(w_binWaveRef1)/10 || jloop > 9 * numpnts(w_binWaveRef1)/10)
				w_binWaveRef1[jloop] = NaN
			EndIf
		EndFor
	EndFor

End

////////////////////////////////////////////////////////////////////////////////
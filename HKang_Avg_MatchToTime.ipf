#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma version = 1.02

//	2020 Hyungu Kang, hyunguboy@gmail.com
//
//	Version 1.02 (Released 2020-03-04)
//	1.	Fixes minor bugs from previous version.
//	2.	Plot and table can be killed without a dialog.
//
//	Version 1.01 (Released 2020-03-03)
//	1.	Changed formatting for better legibility.
//	2.	Sorts time series if needed.
//	3.	Outputs standard deviation wave (from wavestats) as well.
//	4.	Plots time series for quick comparison.
//	5.	Added diagnostic messages to be printed on the command line.
//	6.	Changed loop behavior so it runs faster.
//
//	Version 1.00 (Released 2020-01-16)
//	1.	Works in Igor Pro 6.37.

////////////////////////////////////////////////////////////////////////////////

//	This function will take a wave with its corresponding time wave and average
//	points to match the length of a shorter time wave by averaging.
//
//	w_meas: Wave of values to be averaged.
//	w_meas_time: Corresponding time wave to w_meas.
//	w_matched_time: Time wave to be matched to.
Function Avg_MatchToTime(w_meas, w_meas_time, w_matched_time)
	Wave w_meas, w_meas_time, w_matched_time

	Variable iloop, jloop

	Make/O/D/N = (numpnts(w_matched_time)) w_meas_avg = NaN
	Make/O/D/N = (numpnts(w_matched_time)) w_meas_stdev = NaN

	// Check if measured time wave is sorted.
	iloop = 1

	Do
		If(w_meas_time[iloop] < w_meas_time[iloop - 1])
			Print nameofwave(w_meas_time) + " is not sorted. Making sorted waves."

			Duplicate w_meas_time, w_meas_time_sorted
			Duplicate w_meas, w_meas_sorted
			SetScale d, 0, 1, "dat", w_meas_time_sorted

			Sort w_meas_time, w_meas_time_sorted, w_meas_sorted

			Break
		EndIf

		iloop += 1
	While(iloop < numpnts(w_meas_time))

	// Check if time bin wave is sorted.
	iloop = 1

	Do
		If(w_matched_time[iloop] < w_matched_time[iloop - 1])
			Print nameofwave(w_matched_time) + " is not sorted. Making sorted wave."

			Duplicate w_matched_time, w_matched_time_sorted
			SetScale d, 0, 1, "dat", w_matched_time_sorted

			Sort w_matched_time, w_matched_time_sorted

			Break
		EndIf

		iloop += 1
	While(iloop < numpnts(w_matched_time))

	// In case if time wave(s) is(are) not sorted.
	If(waveexists(w_meas_time_sorted))
		Wave w_timeToMatch = w_meas_time_sorted
		Wave w_measToMatch = w_meas_sorted
	Else
		Wave w_timeToMatch = w_meas_time
		Wave w_measToMatch = w_meas

		Print nameofwave(w_meas_time) + " is sorted. Using this wave."
	EndIf

	If(waveexists(w_matched_time_sorted))
		Wave w_timeMatchTo = w_matched_time_sorted
	Else
		Wave w_timeMatchTo = w_matched_time

		Print nameofwave(w_matched_time) + " is sorted. Using this wave."
	EndIf

	// Main course: Match to time with bin wave.
	jloop = 0

	For(iloop = 1; iloop < numpnts(w_timeMatchTo); iloop += 1)
		Make/O/D/N = 0 w_temporary_bin

		For(jloop = jloop; jloop < numpnts(w_timeToMatch); jloop += 1)
			If(w_timeToMatch[jloop] > w_timeMatchTo[iloop - 1] && w_timeToMatch[jloop] <= w_timeMatchTo[iloop])
				InsertPoints/M = 0 0, 1, w_temporary_bin
				w_temporary_bin[0] = w_measToMatch[jloop]
			EndIf
			
			// Break condition to move to the next time bin.
			If(w_timeToMatch[jloop] >= w_timeMatchTo[iloop])
				jloop += 1

				Break
			EndIf
		EndFor

		If(numpnts(w_temporary_bin) == 0)
			w_meas_avg[iloop] = NaN
			w_meas_stdev[iloop] = NaN
		Else
			WaveStats/Q w_temporary_bin
			w_meas_avg[iloop] = V_avg
			w_meas_stdev[iloop] = V_sdev
		EndIf
	EndFor

	// Dessert: Kill useless variables and waves and make comparison plot.
	KillVariables/Z V_npnts, V_numNaNs, V_numINFs, V_avg, V_Sum, V_sdev
	KillVariables/Z V_sem, V_rms, V_adev, V_skew, V_kurt, V_minloc, V_maxloc
	KillVariables/Z V_min, V_max, V_minRowLoc, V_maxRowLoc, V_startRow, V_endRow
	KillWaves/Z w_temporary_bin
	
	Edit/K = 1 w_timeMatchTo, w_meas_avg, w_meas_stdev

	Display/K = 1 w_meas_avg vs w_timeMatchTo
	ModifyGraph mode(w_meas_avg) = 3;DelayUpdate
	ModifyGraph gaps(w_meas_avg) = 0;DelayUpdate
	ModifyGraph marker(w_meas_avg) = 19;DelayUpdate
	ErrorBars w_meas_avg Y, wave = (w_meas_stdev,w_meas_stdev);DelayUpdate
	AppendToGraph $nameofwave(w_measToMatch) vs w_timeToMatch
	ModifyGraph mode($nameofwave(w_measToMatch)) = 0;DelayUpdate
	ModifyGraph gaps($nameofwave(w_measToMatch)) = 0;DelayUpdate
	ModifyGraph rgb($nameofwave(w_measToMatch)) = (0,0,0);DelayUpdate
	Legend/C/N = text0/A = MC;DelayUpdate
	
End

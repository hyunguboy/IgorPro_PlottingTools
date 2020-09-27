#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma version = 1.1

//	2020 Hyungu Kang, www.hazykinetics.com, hyunguboy@gmail.com
//
//	GNU GPLv3. Please feel free to modify the code as necessary for your needs.
//
//	Version 1.1 (Released 2020-05-26)
//	1.	Fixed bug in the if conditions (mix up between iloop and V_value).
//
//	Version 1.0 (Released 2020-05-24)
//	1.	Initial release tested with Igor Pro 6.37 and 8.04.

////////////////////////////////////////////////////////////////////////////////

//	HKang_ScatterPlotToTime: Takes 2 measurement waves and their corresponding
//	time waves and creates a scatter plot by finding points where the times
//	match.

////////////////////////////////////////////////////////////////////////////////

//	w_measTimeY, w_measY: put on the y-axis.
//	w_measTimeX, w_measX: put on the x-axis.
Function HKang_MatchedTimeScatterPlot(w_measY, w_measTimeY, w_measX, w_measTimeX)
	Wave w_measY, w_measTimeY, w_measX, w_measTimeX

	Variable v_timeMatched
	Variable iloop, jloop

	// Abort if time periods do not overlap.
	If(wavemax(w_measTimeY) < wavemin(w_measTimeX) || wavemax(w_measTimeX) < wavemin(w_measTimeY))
		Print "Aborting: Time periods do not overlap."
		Abort "Aborting: Time periods do not overlap."
	EndIf

	// Abort if the measurement and time waves lengths do not match.
	If(numpnts(w_measTimeY) != numpnts(w_measY))
		Print "Aborting: " + nameofwave(w_measTimeY) + ", " + nameofwave(w_measY) + " have different lengths."
		Abort "Aborting: " + nameofwave(w_measTimeY) + ", " + nameofwave(w_measY) + " have different lengths."
	EndIf

	If(numpnts(w_measTimeX) != numpnts(w_measX))
		Print "Aborting: " + nameofwave(w_measTimeX) + ", " + nameofwave(w_measX) + " have different lengths."
		Abort "Aborting: " + nameofwave(w_measTimeX) + ", " + nameofwave(w_measX) + " have different lengths."
	EndIf

	// Make output waves.
	Make/O/D/N=0 w_measTime_matched
	Make/O/D/N=0 w_measY_matched
	Make/O/D/N=0 w_measX_matched

	SetScale d, 0, 1, "dat", w_measTime_matched

	// Find matched times and fill the output waves.
	If(numpnts(w_measTimeY) < numpnts(w_measTimeX))
		For(iloop = 0; iloop < numpnts(w_measTimeY); iloop += 1)
			FindValue/V=(w_measTimeY[iloop]) w_measTimeX

			// If the y-axis time point exists in the x-axis time wave.
			If(V_value != -1 && numtype(w_measY[iloop]) == 0 && numtype(w_measX[V_value]) == 0)
				InsertPoints/M=0 numpnts(w_measTime_matched), 1, w_measTime_matched
				InsertPoints/M=0 numpnts(w_measY_matched), 1, w_measY_matched
				InsertPoints/M=0 numpnts(w_measX_matched), 1, w_measX_matched

				w_measTime_matched[numpnts(w_measTime_matched) - 1] = w_measTimeY[iloop]
				w_measY_matched[numpnts(w_measTime_matched) - 1] = w_measY[iloop]
				w_measX_matched[numpnts(w_measTime_matched) - 1] = w_measX[V_value]
			EndIf
		EndFor
	Else
		For(iloop = 0; iloop < numpnts(w_measTimeX); iloop += 1)
			FindValue/V=(w_measTimeX[iloop]) w_measTimeY

			// If the y-axis time point exists in the x-axis time wave.
			If(V_value != -1 && numtype(w_measY[V_value]) == 0 && numtype(w_measX[iloop]) == 0)
				InsertPoints/M=0 numpnts(w_measTime_matched), 1, w_measTime_matched
				InsertPoints/M=0 numpnts(w_measY_matched), 1, w_measY_matched
				InsertPoints/M=0 numpnts(w_measX_matched), 1, w_measX_matched

				w_measTime_matched[numpnts(w_measTime_matched) - 1] = w_measTimeX[iloop]
				w_measY_matched[numpnts(w_measTime_matched) - 1] = w_measY[V_value]
				w_measX_matched[numpnts(w_measTime_matched) - 1] = w_measX[iloop]
			EndIf
		EndFor	
	EndIf

	// Abort if not enough measurement times overlap to make a scatter plot.
	If(numpnts(w_measTime_matched) < 3)
		Print "Aborting: Not enough data points to make scatter plot."
		Print "Check that there is enough time overlap between the X and Y waves."
		Abort "Aborting: Scatter plot requires at least 3 points."
	EndIf

	// Table for quick look.
	Edit/K=1 w_measTime_matched, w_measX_matched, w_measY_matched

	// Display scatter plot.
	Display/K=1 w_measY_matched vs w_measX_matched
	SetAxis left 0,*; Delayupdate
	SetAxis bottom 0,*; Delayupdate
	Label left nameofwave(w_measY); Delayupdate
	Label bottom nameofwave(w_measX); Delayupdate
	ModifyGraph standoff=0
	ModifyGraph mode(w_measY_matched)=3,marker(w_measY_matched)=8; Delayupdate
	CurveFit/M=2/W=0/TBOX=(0x300) line, w_measY_matched/X=w_measX_matched/D; DelayUpdate
	ModifyGraph lsize(fit_w_measY_matched)=2; DelayUpdate
	ModifyGraph rgb(fit_w_measY_matched)=(0,0,0); DelayUpdate
	Legend/C/N=text1/A=MC; DelayUpdate

	Print "Number of points where times match: ", numpnts(w_measTime_matched)

End
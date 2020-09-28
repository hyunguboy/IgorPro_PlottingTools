#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma version = 1.0

//	2020 Hyungu Kang, www.hazykinetics.com, hyunguboy@gmail.com
//
//	GNU GPLv3. Please feel free to modify the code as necessary for your needs.
//
//	Version 1.0 (Released 2020-09-27)
//	1.	Initial release tested with Igor Pro 8.04.

////////////////////////////////////////////////////////////////////////////////

//	HKang_GetMatchedTimes: Takes 2 measurement waves and their corresponding
//	time waves and finds points where the times match. These points and their
//	corresponding times are saved in the output waves.

////////////////////////////////////////////////////////////////////////////////

Function HKang_GetMatchedTimes(w_measY, w_measTimeY, w_measX, w_measTimeX)
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

	// Table for quick look.
	Edit/K=1 w_measTime_matched, w_measX_matched, w_measY_matched

	Print "Number of points where times match: ", numpnts(w_measTime_matched)

End
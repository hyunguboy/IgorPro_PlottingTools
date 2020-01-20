#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma version = 1.00

//	2020 Hyungu Kang, hyunguboy@gmail.com
//
//	Version 1.00 (Released 2020-01-16)

////////////////////////////////////////////////////////////////////////////////

//	This function will take a wave with its corresponding time wave and average
//	points to match the length of a shorter time wave.
//
//	w_meas: Wave of values to be averaged.
//	w_meas_time: Corresponding time wave to w_meas.
//	w_matched_time: Time wave to be matched to.

Function Avg_MatchToTime(w_meas, w_meas_time, w_matched_time)
	Wave w_meas, w_meas_time, w_matched_time
	
	Variable i_loop, j_loop
	
	Make/O/D/N = (numpnts(w_matched_time)) w_meas_avg
	
	For(i_loop = 1; i_loop < numpnts(w_matched_time); i_loop += 1)
	
		Make/O/D/N = 0 w_bin
		
		For(j_loop = 0; j_loop < numpnts(w_meas_time); j_loop += 1)
		
			If(w_meas_time[j_loop] > w_matched_time[i_loop - 1] && w_meas_time[j_loop] <= w_matched_time[i_loop] && numtype(w_meas[j_loop]) != 2)
			
				InsertPoints/M = 0 0, 1, w_bin
				w_bin[0] = w_meas[j_loop]
			
			EndIf
		
		EndFor
		
		If(numpnts(w_bin) != 0)
		
			w_meas_avg[i_loop] = mean(w_bin)
			
		EndIf
	
	EndFor
	
	KillWaves/Z w_bin
	
	Edit w_meas_avg

End

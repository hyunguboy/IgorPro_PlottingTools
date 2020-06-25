#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma version=1.0

//	2020 Hyungu Kang, www.hazykinetics.com, hyunguboy@gmail.com
//
//	GNU GPLv3. Please feel free to modify the code as necessary for your needs.
//
//	Version 1.0 (Released 2020-06-25)
//	1.	Initial release tested with Igor Pro 6.37 and 8.04.

////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////

Function HKang_HysplitQuadrants(w_concY, w_concX, w_HysplitClusters, w_time)
	Wave w_concY, w_concX, w_HysplitClusters, w_time

	Variable v_avgY, v_avgX
	Variable v_countUpprLeft = 0
	Variable v_countUpprRght = 0
	Variable v_countLowrLeft = 0
	Variable v_countLowrRght = 0
	Variable/G v_probUpprLeft, v_probUpprRght
	Variable/G v_probLowrLeft, v_probLowrRght
	Variable iloop
	DFREF dfr_current

	dfr_current = GetDataFolderDFR()

	// Error messages in case the user makes a mistake.
	If(datafolderexists("root:HysplitQuadrants") != 1)
		Abort "Aborting: 'root:HysplitQuadrants' not found. Create folder and place waves in that folder."
	Else
		SetDataFolder root:HysplitQuadrants	
	EndIf

	// Averages for the quadrant lines and statistics.
	WaveStats w_concY
	v_avgY = V_avg
	WaveStats w_concX
	v_avgX = V_avg

	// Quadrant lines for the scatter plot.
	Make/O/D/N=2 w_plotQuadLineYMaxMin = {Wavemin(w_concY), Wavemax(w_concY)}
	Make/O/D/N=2 w_plotQuadLineXMaxMin = {Wavemin(w_concX), Wavemax(w_concX)}

	Make/O/D/N=2 w_plotQuadLineYAvg = {v_avgY, v_avgY}
	Make/O/D/N=2 w_plotQuadLineXAvg = {v_avgX, v_avgX}

	// Waves for each quadrant.
	Make/O/D/N=0 w_quadUpprLeft_concY
	Make/O/D/N=0 w_quadUpprLeft_concX
	Make/O/D/N=0 w_quadUpprLeft_cluster
	Make/O/D/N=0 w_quadUpprLeft_time
	Make/O/D/N=0 w_quadUpprRght_concY
	Make/O/D/N=0 w_quadUpprRght_concX
	Make/O/D/N=0 w_quadUpprRght_cluster
	Make/O/D/N=0 w_quadUpprRght_time
	Make/O/D/N=0 w_quadLowrLeft_concY
	Make/O/D/N=0 w_quadLowrLeft_concX
	Make/O/D/N=0 w_quadLowrLeft_cluster
	Make/O/D/N=0 w_quadLowrLeft_time
	Make/O/D/N=0 w_quadLowrRght_concY
	Make/O/D/N=0 w_quadLowrRght_concX
	Make/O/D/N=0 w_quadLowrRght_cluster
	Make/O/D/N=0 w_quadLowrRght_time
		
	// Get waves and probabilities for each quadrant.
	For(iloop = 0; iloop < numpnts(w_time); iloop += 1)
		If(w_concY[iloop] > v_avgY && w_concX[iloop] <= v_avgX)
			v_countUpprLeft += 1
			
			InsertPoints/M=0 numpnts(w_quadUpprLeft_concY), 1, w_quadUpprLeft_concY
			InsertPoints/M=0 numpnts(w_quadUpprLeft_concX), 1, w_quadUpprLeft_concX
			InsertPoints/M=0 numpnts(w_quadUpprLeft_cluster), 1, w_quadUpprLeft_cluster
			InsertPoints/M=0 numpnts(w_quadUpprLeft_time), 1, w_quadUpprLeft_time
			
			w_quadUpprLeft_concY[numpnts(w_quadUpprLeft_concY) - 1] = w_concY[iloop]
			w_quadUpprLeft_concX[numpnts(w_quadUpprLeft_concX) - 1] = w_concX[iloop]
			w_quadUpprLeft_cluster[numpnts(w_quadUpprLeft_cluster) - 1] = w_HysplitClusters[iloop]
			w_quadUpprLeft_time[numpnts(w_quadUpprLeft_time) - 1] = w_time[iloop]
		ElseIf(w_concY[iloop] > v_avgY && w_concX[iloop] > v_avgX)
			v_countUpprRght += 1
			
			InsertPoints/M=0 numpnts(w_quadUpprRght_concY), 1, w_quadUpprRght_concY
			InsertPoints/M=0 numpnts(w_quadUpprRght_concX), 1, w_quadUpprRght_concX
			InsertPoints/M=0 numpnts(w_quadUpprRght_cluster), 1, w_quadUpprRght_cluster
			InsertPoints/M=0 numpnts(w_quadUpprRght_time), 1, w_quadUpprRght_time
			
			w_quadUpprRght_concY[numpnts(w_quadUpprRght_concY) - 1] = w_concY[iloop]
			w_quadUpprRght_concX[numpnts(w_quadUpprRght_concX) - 1] = w_concX[iloop]
			w_quadUpprRght_cluster[numpnts(w_quadUpprRght_cluster) - 1] = w_HysplitClusters[iloop]
			w_quadUpprRght_time[numpnts(w_quadUpprRght_time) - 1] = w_time[iloop]
		ElseIf(w_concY[iloop] <= v_avgY && w_concX[iloop] <= v_avgX)
			v_countLowrLeft += 1
			
			InsertPoints/M=0 numpnts(w_quadLowrLeft_concY), 1, w_quadLowrLeft_concY
			InsertPoints/M=0 numpnts(w_quadLowrLeft_concX), 1, w_quadLowrLeft_concX
			InsertPoints/M=0 numpnts(w_quadLowrLeft_cluster), 1, w_quadLowrLeft_cluster
			InsertPoints/M=0 numpnts(w_quadLowrLeft_time), 1, w_quadLowrLeft_time
			
			w_quadLowrLeft_concY[numpnts(w_quadLowrLeft_concY) - 1] = w_concY[iloop]
			w_quadLowrLeft_concX[numpnts(w_quadLowrLeft_concX) - 1] = w_concX[iloop]
			w_quadLowrLeft_cluster[numpnts(w_quadLowrLeft_cluster) - 1] = w_HysplitClusters[iloop]
			w_quadLowrLeft_time[numpnts(w_quadLowrLeft_time) - 1] = w_time[iloop]
		ElseIf(w_concY[iloop] <= v_avgY && w_concX[iloop] > v_avgX)
			v_countLowrRght += 1
			
			InsertPoints/M=0 numpnts(w_quadLowrRght_concY), 1, w_quadLowrRght_concY
			InsertPoints/M=0 numpnts(w_quadLowrRght_concX), 1, w_quadLowrRght_concX
			InsertPoints/M=0 numpnts(w_quadLowrRght_cluster), 1, w_quadLowrRght_cluster
			InsertPoints/M=0 numpnts(w_quadLowrRght_time), 1, w_quadLowrRght_time
			
			w_quadLowrRght_concY[numpnts(w_quadLowrRght_concY) - 1] = w_concY[iloop]
			w_quadLowrRght_concX[numpnts(w_quadLowrRght_concX) - 1] = w_concX[iloop]
			w_quadLowrRght_cluster[numpnts(w_quadLowrRght_cluster) - 1] = w_HysplitClusters[iloop]
			w_quadLowrRght_time[numpnts(w_quadLowrRght_time) - 1] = w_time[iloop]
		EndIf
	EndFor

	v_probUpprLeft = v_countUpprLeft/numpnts(w_time)
	v_probUpprRght = v_countUpprRght/numpnts(w_time)
	v_probLowrLeft = v_countLowrLeft/numpnts(w_time)
	v_probLowrRght = v_countLowrRght/numpnts(w_time)

	// Display scatter plot with quadrants.
	Display w_concY vs w_concX
	ModifyGraph mode(w_concY)=3; DelayUpdate
	ModifyGraph marker(w_concY)=8; DelayUpdate
	ModifyGraph msize(w_concY)=3; DelayUpdate
	ModifyGraph mrkThick(w_concY)=2; DelayUpdate
	ModifyGraph zColor(w_concY)={w_HysplitClusters,*,*,Rainbow,1}; DelayUpdate
	ColorScale/C/N=text1/A=MC trace=w_HysplitClusters; DelayUpdate
	AppendToGraph w_plotQuadLineYMaxMin vs w_plotQuadLineXAvg; DelayUpdate
	AppendToGraph w_plotQuadLineXMaxMin vs w_plotQuadLineYAvg; DelayUpdate
	ModifyGraph lsize(w_plotQuadLineYMaxMin)=2; DelayUpdate
	ModifyGraph lsize(w_plotQuadLineXMaxMin)=2; DelayUpdate
	ModifyGraph rgb(w_plotQuadLineYMaxMin)=(0,0,0); DelayUpdate
	ModifyGraph rgb(w_plotQuadLineXMaxMin)=(0,0,0); DelayUpdate

	SetDataFolder dfr_current

End
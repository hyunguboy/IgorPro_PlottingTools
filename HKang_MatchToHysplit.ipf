#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#pragma version = 1.00

//	2020 Hyungu Kang, www.hazykinetics.com, hyunguboy@gmail.com
//
//	Version 1.00 (Released 2020/07/XX)
//	1.	Initialial release tested with Igor Pro 6.37 and 8.04.
//	2.	Tested with 1 hour Hysplit cluster modeling results.

////////////////////////////////////////////////////////////////////////////////

//	This function takes the PMF factor time series and matches it to Hysplit model
//	clustering results. Basically, it averages the PMF factor time series into
//	time bins defined by the Hysplitclustering output, since the time series
//	should have higher temporal resolution.

////////////////////////////////////////////////////////////////////////////////

Function HKang_GetHysplitClusterWave(w_conc, w_time, w_HysplitCluster, w_HysplitTime, v_cluster)
	Wave w_conc, w_time, w_HysplitCluster, w_HysplitTime
	Variable v_cluster

	Variable iloop
	String str_tempConc = "w_cluster" + num2str(v_cluster) + "Conc"
	String str_tempTime = "w_cluster" + num2str(v_cluster) + "Time"
	String str_tempClusterTime = "w_HysplitCluster" + num2str(v_cluster) + "Time"

	Make/O/D/N=0 $str_tempConc
	Make/O/D/N=0 $str_tempTime
	Make/O/D/N=0 $str_tempClusterTime

	Wave w_tempConc = $str_tempConc
	Wave w_tempTime = $str_tempTime
	Wave w_tempClusterTime = $str_tempClusterTime


	// Get the input cluster time wave
	For(iloop=0; iloop < numpnts(w_HysplitCluster); iloop += 1)
		If(w_HysplitCluster[iloop] == v_cluster)
			InsertPoints/M=0 numpnts(w_tempClusterTime), 1, w_tempClusterTime

			w_tempClusterTime[numpnts(w_tempClusterTime) - 1] = w_HysplitTime[iloop]
		EndIf
	EndFor


	// Get the input cluster time wave
	For(iloop=0; iloop < numpnts(w_HysplitCluster); iloop += 1)
		If(w_HysplitCluster[iloop] == v_cluster)
			InsertPoints/M=0 numpnts(w_tempConc), 1, w_tempConc
			InsertPoints/M=0 numpnts(w_tempTime), 1, w_tempTime
			InsertPoints/M=0 numpnts(w_tempClusterTime), 1, w_tempClusterTime
			
			w_tempConc[
	
	
	
	
	
		
		EndIf
	EndFor





End

////////////////////////////////////////////////////////////////////////////////

//	w_PMFFactorTSList: Text wave with the wave names of PMF factor time series.
//	w_PMFFactorTime: Time wave of the PMF factor time series.
//	w_HysplitCluster: Wave of cluster designations by Hysplit.
//	w_HysplitTime: Time wave of the Hysplit cluster designations.
Function HKang_MatchToHysplit(w_PMFFactorTSList, w_PMFFactorTime, w_HysplitCluster, w_HysplitTime)
	Wave/T w_PMFFactorTSList
	Wave w_PMFFactorTime, w_HysplitCluster, w_HysplitTime
	Variable v_cluster
	
	Variable iloop, jloop
	Variable v_NumClusters
	
	String s_temporary = "w_ConcCluster" + num2str(v_cluster)
	Make/O/D/N = 0 $s_temporary
	
	For(iloop = 0; iloop < numpnts(w_HysplitCluster); iloop += 1)
		If(w_HysplitCluster[iloop] == v_cluster)
			
			//For(jloop = )
			
			//EndFor

		EndIf
	EndFor
	
	WaveStats $s_temporary
	
	
	
End

Function hyspliter(pmffactor, pmftime, cluster, clustertime)
	Wave pmffactor, pmftime, cluster, clustertime
	
	Variable v_numofclusters = 5
	
	Duplicate 
	
	
	








End

////////////////////////////////////////////////////////////////////////////////




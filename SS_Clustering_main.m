% If your code hangs in SS_NormaliseAndFilter remove '-append' from save 
% command on line 150 in TS_local_clear_remove 

% Set up default run info file
SS_SetupRunOptions;

% Load your data matrix then normalise and filter it
%SS_NormaliseAndFilter;

% Enter values of K you want to calculate 
% NB: The largest value of K will automatically be used for the linkage clustering etc
SS_ClusterKMedoids;

% Calculates residual variance for above clusters 
SS_ResidVariance;

% Calculates time series distances for original and reduced operation sets
SS_TSDistances;

% Cluster K-medoids centres using linkage clustering
SS_LinkageClusterOps;

% Calculate all operation correlations with their cluster centres
SS_CorrOpsWithClusters;

% Output final clusters to a text file
SS_IdentifyBestOps;

% Cluster the time series in the reduced operation space to visualise
% effectiveness of selected operations 
SS_TestOpsOnTSClusters;
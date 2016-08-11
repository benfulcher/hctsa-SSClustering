
% Bug in SS_NormaliseAndFilter so load straight
load('HCTSA_Empirical1000_Aug2015_N_filtered.mat');
save('HCTSA_N.mat');

% SS_NormaliseAndFilter('HCTSA_Empirical1000_Aug2015');

% Enter values of K you want to calculate 
% NB: The largest value of K will automatically be used for the linkage clustering etc
SS_ClusterKMedoids([3,5,10,20]);

% Calculates residual variance for above clusters 
SS_ResidVariance;

% Calculates time series distances for original and reduced operation sets
SS_TSDistances;

% Cluster K-medoids centres using linkage clustering
SS_LinkageClusterOps;

% Calculate all operation correlations with their cluster centres
SS_CorrOpsWithClusters;

% Output final clusters to a text file
SS_OutputBestOpsTxtFile('cluster_info.txt');

% Cluster the time series in the reduced operation space to visualise
% effectiveness of selected operations 
SS_TestOpsOnTSClusters;
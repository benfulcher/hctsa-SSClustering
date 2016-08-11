
% Bug in SS_NormaliseAndFilter so load straight
load('HCTSA_Empirical1000_Aug2015_N_filtered.mat');
save('HCTSA_N.mat');

% SS_NormaliseAndFilter('HCTSA_Empirical1000_Aug2015');

SS_ClusterKMedoids(20);

SS_ResidVariance;

SS_TSCorrelations;

SS_LinkageClusterOps;

SS_CorrOpsWithClusters;

SS_OutputBestOpsTxtFile;

SS_TestOpsOnTSClusters;
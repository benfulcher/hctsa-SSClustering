% If your code hangs in SS_NormaliseAndFilter remove '-append' from save 
% command on line 150 in TS_local_clear_remove 

clear all;
rng(0);

ks = [200];
corrThresholds = [0.2];

% Set up default run info file
SS_SetupRunOptions(ks , 1 , 1000 , 2000 , ...
    'HCTSA_new_data' , '' , 0.1 , 10)

% Load your data matrix then normalise and filter it
SS_NormaliseAndFilter;

% Enter values of K you want to calculate 
% NB: The largest value of K will automatically be used for the linkage clustering etc
SS_ClusterKMedoids;

for i = 1:length(ks)
    for j = 1:length(corrThresholds)
        corr_dist_threshold = corrThresholds(j);
        kToUse = ks(i);
        outTxtFileName = ['cluster_info_',num2str(kToUse),'_',num2str(corr_dist_threshold),'.txt'];

        % Set up default run info file
        SS_SetupRunOptions(ks , kToUse , 500 , 2000 , ...
            'HCTSA_new_data' , outTxtFileName , corr_dist_threshold , 10)

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
        
        % Close all figures
        %close all;
    end
end
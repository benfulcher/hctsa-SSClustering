% If your code hangs in SS_NormaliseAndFilter remove '-append' from save
% command on line 150 in TS_local_clear_remove

% clear all;

% Reset random seed:
rng(0);

%-------------------------------------------------------------------------------
% Set up default run info file
runParams = SetDefaultParams();
% <<Can alter default parameters manually here>>

%-------------------------------------------------------------------------------
% Normalise and filter data
doFilter = false;
runParams = SS_NormaliseAndFilter(runParams,doFilter);

%-------------------------------------------------------------------------------
% Enter values of K you want to calculate
% NB: The largest value of K will automatically be used for the linkage clustering etc
km = SS_ClusterKMedoids(runParams);

for i = 1:length(runParams.ks)
    kToUse = ks(i);
    fprintf(1,'[%u/%u]k = %u\n',i,length(runParams.ks),kToUse);
    for j = 1:length(runParams.corrThresholds)
        corr_dist_threshold = runParams.corrThresholds(j);
        fprintf(1,'  [%u/%u]corrThresh = %.2f\n',j,length(runParams.corrThresholds),...
                                corr_dist_threshold);

        outTxtFileName = sprintf('cluster_info_%u_%.2f.txt',kToUse,runparams.corr_dist_threshold);

        % Set up default run info file
        SS_SetupRunOptions(ks,kToUse,500,2000,'HCTSA_new_data',outTxtFileName,corr_dist_threshold,10)

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

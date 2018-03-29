function [distMat_cl,cluster_Groupi,ord,orderedNames,kmed] = SS_LinkageClusterOps(runParams,km,reducedDataMat)

% km from SS_ClusterKMedoids
% reducedDataMat from SS_ResidVariance

if nargin < 3
    load('resid_variance.mat','reducedDataMat');
end

% Load in normalized hctsa data
load(runParams.normMatFile,'TS_DataMat','Operations');

%===============================================================================
kmed = km(kIdx);

% Find representative features:
chosenOps = Operations(kmed.CCi);

% First calculate pairwise distances between features in the low-dimensional space
switch runParams.opDist
case 'abscorr'
    rawDistVec = pdist(reducedDataMat','corr');
    % Transform correlations to absolute correlation distances
    distVec = 1-abs(1-rawDistVec);
end

%-------------------------------------------------------------------------------
% Cluster linkages using a cutoff value for minimum inter-cluster distance
[distMat_cl,cluster_Groupi,ord] = BF_ClusterDown(distVec,...
                'clusterThreshold',runParams.corr_dist_threshold,...
                'whatDistance','general',...
                'linkageMeth',runParams.linkageMeth);
% Customize plot:
ax = gca;
ax.YTick = 1:kmed.k;
ax.YTickLabel = orderedNames;
ax.TickLabelInterpreter = 'none';
colormap(BF_getcmap('redyellowblue',10,false)); % custom colormap

fprintf(['Linkage clustering reduced %u operations to %u groups using '...
        'a distance threshold of %.2f\n'],kmed.k,length(cluster_Groupi),...
        runParams.corr_dist_threshold);


% Save info regarding the most representative operations:
opNames = {chosenOps.Name};
orderedNames = opNames(ord);

%-------------------------------------------------------------------------------
if saveToFile
    save('linkage_clustered_ops.mat','kmed','distMat_cl','orderedNames',...
        'ord','cluster_Groupi');
end

end

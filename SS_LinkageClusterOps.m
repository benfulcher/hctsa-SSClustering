function SS_LinkageClusterOps

load('run_options.mat');
load('HCTSA_N.mat');
load('clusters_kmedoids.mat');
load('resid_variance.mat');

kmed = km(kIdx);

% Find best operations
chosenOps = Operations(kmed.CCi);

% First calculate distance vector 
distVec = 1- abs(1 - pdist(reducedDataMat','correlation'));

% Cluster linkages using a cutoff value for minimum inter-cluster distance
[distMat_cl,cluster_Groupi,ord]  = BF_ClusterDown(distVec,...
    'clusterThreshold',corr_dist_threshold,'whatDistance','general',...
    'linkageMeth','average');
colormap(BF_getcmap('redyellowblue',10));

fprintf(['Linkage clustering reduced %i operations to %i groups using '...
    'a distance threshold of %.2f \n'],...
    kmed.k, length(cluster_Groupi),corr_dist_threshold);

opNames = {chosenOps.Name};
orderedNames = opNames(ord);
set(gca,'Ytick',1:kmed.k,'YtickLabel',orderedNames,'TickLabelInterpreter','none');

% Save info regarding best operations
save('linkage_clustered_ops.mat','kmed','distMat_cl','orderedNames',...
    'ord','cluster_Groupi');

end


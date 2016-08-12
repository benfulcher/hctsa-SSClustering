function SS_LinkageClusterOps

load('run_options.mat');
load('HCTSA_N.mat');
load('clusters_kmedoids.mat');
load('resid_variance.mat');


kmed = km(kIdx);

% Find best operations
chosenOps = Operations(kmed.CCi);

% First calculate number of linkage clusters required to group below threshold 
distVec = 1- abs(1 - pdist(reducedDataMat','correlation'));
Z = linkage(distVec,'complete');
T = cluster(Z,'cutoff',corr_dist_threshold,'criterion','distance');
nLinkageClusters = max(T);

% Then use Ben's fancy function to plot it nicely
[distMat_cl,cluster_Groupi,ord]  = BF_ClusterDown(distVec,...
    nLinkageClusters,'whatDistance','general','linkageMeth','complete');
colormap(BF_getcmap('redyellowgreen',10));

fprintf(['Linkage clustering reduced %i operations to %i groups using '...
    'a distance threshold of %f \n'],...
    kmed.k, nLinkageClusters,corr_dist_threshold);

opNames = {chosenOps.Name};
orderedNames = opNames(ord);
set(gca,'Ytick',1:kmed.k,'YtickLabel',orderedNames,'YTickLabelRotation',0,...
    'TickLabelInterpreter','none');

% Save info regarding best operations
save('linkage_clustered_ops.mat','kmed','distMat_cl','orderedNames',...
    'ord','cluster_Groupi');

end


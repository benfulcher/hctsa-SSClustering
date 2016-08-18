function SS_CorrOpsWithClusters

load('run_options.mat');
load('HCTSA_N.mat');
load('clusters_kmedoids.mat');
load('linkage_clustered_ops');

kmedoidsClusters = km(kIdx);

allClusters = cluster_Groupi;

fprintf('Calculating correlations of operations to their linkage clustered centres\n');

for i = 1:length(allClusters)
    % Within linkage clusters take the mean of members to find cluster centre
    cluster = cell2mat(allClusters(i));
    kmedCentres = [];
    for j = 1:length(cluster)
        kmedCentres = [kmedCentres TS_DataMat(:,kmedoidsClusters.CCi(cluster(j)))];
    end
    av = mean(kmedCentres,2);
    
    % Find correlation distance of each cluster member to cluster centre
    memIdxs = find(ismember(kmedoidsClusters.Cass,cluster))';
    memDists = zeros(length(memIdxs),1);
    for j = 1:length(memIdxs)
        op = TS_DataMat(:,memIdxs(j));
        memDists(j) = 1 - abs(corr(op,av));
    end

    linkageClusters(i).kmedCentres = cluster;
    linkageClusters(i).centre = av;
    linkageClusters(i).memIdxs = memIdxs;
    linkageClusters(i).memDists = memDists;
end

save('linkage_clusters_with_member_corrs.mat','linkageClusters',...
    'kmedoidsClusters');
end


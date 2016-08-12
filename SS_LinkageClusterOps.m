function SS_LinkageClusterOps

load('run_options.mat');
load('HCTSA_N.mat');
load('clusters_kmedoids.mat');
load('resid_variance.mat');


kmed = km(kIdx);

% Find best operations
chosenOps = Operations(kmed.CCi);

% Correlation distance between reduced set of operations
reducedOpCorrDists = squareform(pdist(reducedDataMat','correlation'));
reducedOpCorrDists = 1 - abs(1-reducedOpCorrDists);

% Iteratively linkage cluster the operations based on a minimum correlation
% distance within the clusters
keepGoing = true;
nLinkageClusters = kmed.k * 0.75;
shouldIncrement = true; 
incAmount = round(max(kmed.k/100,1));
while keepGoing    
    if shouldIncrement
        if nLinkageClusters >= kmed.k; break; end

        nLinkageClusters = nLinkageClusters + incAmount;
        fprintf('Trying with %i linkage clusters\n',nLinkageClusters);
        shouldIncrement = false;
    else
        break;
    end
        
    [distMat_cl,cluster_Groupi,ord]  = BF_ClusterDown(reducedOpCorrDists,...
        nLinkageClusters,'whatDistance','general');

    % Check all clusters generated
    group = cluster_Groupi{1};
    for i = 1:nLinkageClusters
        iGroup = group{i};
        
        % Check all combinations inside each cluster
        [A,B] = meshgrid(iGroup,iGroup);
        c=cat(2,A',B');
        d=reshape(c,[],2);
        d = d(d(:,1)~=d(:,2),:);
        for j = 1:size(d,1)
            % If cluster contains operations which are too different try
            % again with more clusters
            if reducedOpCorrDists(d(j,1),d(j,2)) > corr_dist_threshold
                shouldIncrement = true;
                close;
                break;
            end
        end
        if shouldIncrement; break; end
    end
    if shouldIncrement; continue; end

    % Successfully clustered
    fprintf(['Linkage clustering reduced %i operations to %i groups using '...
        'a distance threshold of %f \n'],...
        kmed.k, nLinkageClusters,corr_dist_threshold);
    keepGoing = false;
    colormap(BF_getcmap('redyellowgreen',10));
end

opNames = {chosenOps.Name};
orderedNames = opNames(ord);
set(gca,'Ytick',1:kmed.k,'YtickLabel',orderedNames,'YTickLabelRotation',0,...
    'TickLabelInterpreter','none');

% Save info regarding best operations
save('linkage_clustered_ops.mat','kmed','distMat_cl','orderedNames',...
    'ord','cluster_Groupi');

end


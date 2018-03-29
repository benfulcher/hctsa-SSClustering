function km = SS_ClusterKMedoids(runParams)

load(runParams.normMatFile,'TS_DataMat');
numFeatures = size(TS_DataMat,2);

% Cluster operations using correlation distances and k-medoids clustering
fprintf('Computing pairwise %s distances between %u operations\n',runParams.opDist,numFeatures);
switch runParams.opDist
    case 'abscorr'
        D = squareform(pdist(TS_DataMat','corr'));
        % Convert correlations to absolute correlation distances:
        D = 1-abs(1-D);
end

%-------------------------------------------------------------------------------
% Compute k-medoids clustering for each k in ks:
numKs = length(runParams.ks);
for i = 1:numKs
    k = runParams.ks(i);
    fprintf('[%u/%u]Calculating k-medoids for k = %u\n',i,numKs,k);
    km(i).k = k;
    [km(i).CCi,km(i).Cass,km(i).err,km(i).Cord] = BF_kmedoids(D,k,runParams.maxIter,runParams.op_km_repeats);
    % Slower MATLAB method calculates pdist each time
    % [km(i).idx,km(i).C,km(i).sumd,km(i).D] = kmedoids(TS_DataMat',k,...
    %     'Distance','correlation',...
    %     'Options',statset('UseParallel',true),...
    %     'Replicates',2);
end

%-------------------------------------------------------------------------------
% Save to file:
saveToFile = false;
if saveToFile
    save('clusters_kmedoids.mat','km');
end

end

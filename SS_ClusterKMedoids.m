function km = SS_ClusterKMedoids(runParams)

load(runParams.normMatFile,'TS_DataMat');

% Cluster operations using correlation distances and k-medoids clustering
fprintf('Computing pairwise correlation distances for operations\n');
D = squareform(pdist(TS_DataMat','corr'));
D = 1-abs(1-D);

% Compute k-medoids for each k in ks
maxIter = 100;
for i = 1:length(ks)
    k = ks(i);
    fprintf('[%u/%u]Calculating k-medoids for k = %u\n',i,length(ks),k);
    km(i).k = k;
    [km(i).CCi,km(i).Cass,km(i).err,km(i).Cord] = BF_kmedoids(D,k,maxIter,op_km_repeats);
    % Slower MATLAB method calculates pdist each time
    % [km(i).idx,km(i).C,km(i).sumd,km(i).D] = kmedoids(TS_DataMat',k,...
    %     'Distance','correlation',...
    %     'Options',statset('UseParallel',true),...
    %     'Replicates',2);
end

save('clusters_kmedoids.mat','km');

end

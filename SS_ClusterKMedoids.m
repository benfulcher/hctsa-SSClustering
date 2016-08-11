function km = SS_ClusterKMedoids( ks )

load('HCTSA_N.mat');

if nargin < 1
    ks = [2,5,10,20,50,100];
end

%% CLUSTER OPERATIONS USING K MEDOIDS METHOD
fprintf('Computing pairwise correlation distances for operations\n');
D = squareform(pdist(TS_DataMat','correlation'));
D = 1-abs(1-D);
maxIter = 100;
nrepeats = 100;
for i = 1:length(ks)
    k = ks(i);
    
    fprintf('Calculating k-medoids for k = %i\n',k);

    km(i).k = k;
    
    [km(i).CCi, km(i).Cass, km(i).err, km(i).Cord] = ...
        BF_kmedoids(D, k, maxIter, nrepeats); 
    
    % Slower MATLAB method calculates pdist each time
    % [km(i).idx,km(i).C,km(i).sumd,km(i).D] = kmedoids(TS_DataMat',k,...
    %     'Distance','correlation',...
    %     'Options',statset('UseParallel',true),...
    %     'Replicates',2);
end

save('clusters_kmedoids.mat','km');

end

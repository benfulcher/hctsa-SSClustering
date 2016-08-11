function SS_ResidVariance
% PLOT RESIDUAL VARIANCE AS FUNCTION OF K

load('clusters_kmedoids.mat');
load('HCTSA_N.mat');

fprintf('Computing pairwise Euclidian distances for TS using all operations\n');
residVars = [];
S = pdist(TS_DataMat);

% Loop through each
for i = 1:size(km,2)
    kmed = km(i);    
    reducedDataMat = TS_DataMat(:,kmed.CCi);
    fprintf('Computing residual variance for k = %i\n',kmed.k);
    S_red = pdist(reducedDataMat);
    R = corr2(S,S_red);
    residVars = [residVars , 1 - (R^2)];
end

figure;
plot([km.k],residVars)
title('Residual Variance');
xlabel('k');

save('resid_variance.mat','residVars','S','S_red','reducedDataMat');

end


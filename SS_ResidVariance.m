function SS_ResidVariance
% PLOT RESIDUAL VARIANCE AS FUNCTION OF K

load('run_options.mat');
load('clusters_kmedoids.mat');
load('HCTSA_N.mat');

fprintf('Computing pairwise Euclidian distances for TS using all operations\n');
residVars = [];
pcaResidVars = [];

S = pdist(TS_DataMat);
[pcaM score] = pca(TS_DataMat);

% Loop through each
for i = 1:size(km,2)
    kmed = km(i);    
    fprintf('Computing residual variance for k = %i\n',kmed.k);
    
    reducedDataMatI = TS_DataMat(:,kmed.CCi);
    S_redI = pdist(reducedDataMatI);
    R = corr2(S,S_redI);
    residVars = [residVars , 1 - (R^2)];

    pcaRedMat = score(:,1:min(kmed.k,size(score,2)));
    S_pcaRed = pdist(pcaRedMat);
    pcaR = corr2(S,S_pcaRed);
    % abs used to stop rounding errors giving -ve values
    pcaResidVars = [pcaResidVars , abs(1 - (pcaR^2))];
    
    if i == kIdx
        reducedDataMat = reducedDataMatI;
        S_red = S_redI;
    end
end

figure;
plot([km.k],residVars);
hold on;
plot([km.k],pcaResidVars);
title('Residual Variance');
xlabel('k');

save('resid_variance.mat','residVars','S','S_red','reducedDataMat');

end


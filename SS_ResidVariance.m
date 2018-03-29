function [residVars,S,S_red,reducedDataMat] = SS_ResidVariance(runParams,km,saveToFile)
% PLOT RESIDUAL VARIANCE AS FUNCTION OF K

if nargin < 2
    fprintf(1,'Loading in k-medoids clustering info from file\n');
    load('clusters_kmedoids.mat','km');
end

% Load the normalized/filtered data matrix:
load(runParams.normMatFile,'TS_DataMat');

%-------------------------------------------------------------------------------
fprintf('Computing pairwise Euclidian distances for TS using all features.\n');

S = pdist(TS_DataMat,runParams.tsDist);
[pcaM,score] = pca(TS_DataMat);

%-------------------------------------------------------------------------------
% Loop through each k-medoids clustering solution:
numSolutions = length(km);
residVars = zeros(numSolutions,1);
pcaResidVars = zeros(numSolutions,1);
for i = 1:numSolutions
    kmed = km(i);
    fprintf('Computing residual variance for k = %u\n',kmed.k);

    reducedDataMatI = TS_DataMat(:,kmed.CCi);
    S_redI = pdist(reducedDataMatI);
    R = corr2(S,S_redI);
    residVars(i) = 1 - R^2;

    pcaRedMat = score(:,1:min(kmed.k,size(score,2)));
    S_pcaRed = pdist(pcaRedMat);
    pcaR = corr2(S,S_pcaRed);
    % abs used to stop rounding errors giving -ve values
    pcaResidVars(i) = abs(1 - (pcaR^2));

    if i == kIdx
        reducedDataMat = reducedDataMatI;
        S_red = S_redI;
    end
end

%-------------------------------------------------------------------------------
% Plot:
f = figure('color','w'); hold on;
plot([km.k],residVars);
plot([km.k],pcaResidVars);
title('Residual Variance');
xlabel('k');
legend('k-medoids','PCA');

%-------------------------------------------------------------------------------
% Save to file:
if saveToFile
    save('resid_variance.mat','residVars','S','S_red','reducedDataMat');
    fprintf(1,'Saved residual variance results to resid_variance.mat\n');
end

end

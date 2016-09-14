function SS_TestOpsOnTSClusters

load('run_options.mat');
load('HCTSA_N.mat');
load('linkage_clustered_ops.mat');
load('auto_chosen_ops.mat');

% Create a reduced data matrix using the automatically chosen operations
reducedMat = TS_DataMat(:,autoChosenIdxs);
reducedDists = pdist(reducedMat);

% Cluster the time series using the reduced (K-medoids) operation space
maxIter = 100;
ts_k = round(size(TS_DataMat,1) / av_ts_cluster_size);

[~,Cass,~,Cord] = BF_kmedoids(squareform(reducedDists), ts_k, maxIter, ts_km_repeats); 
    
% Sort clusters by size
[~,I] = sort(cellfun(@length,Cord),'descend');

figure;
plotOptions	= struct('plotFreeForm',1,'displayTitles',0,'newFigure',0); 
numPerGroup = 40;
maxLength = 500;
numPlots = 12;
for i = 1:numPlots
    subplot(2,numPlots / 2,i);
    series = find(Cass == I(i));

    TS_plot_timeseries('norm',numPerGroup,series,maxLength,plotOptions);
    title(sprintf('Cluster %i (%i time series)',i,length(series)));
end

% Save image
fName = ['ts_clusters_',num2str(ks(kIdx)),'_',num2str(corr_dist_threshold),'.png'];
set(gcf, 'Position', get(0, 'Screensize'));
print(fName,'-dpng')

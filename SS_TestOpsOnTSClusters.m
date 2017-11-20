function SS_TestOpsOnTSClusters

% load('run_options.mat');
% load('HCTSA_N.mat');
% load('linkage_clustered_ops.mat');
% load('auto_chosen_ops.mat');

% Load in data:
[TS_DataMat,~,Operations] = TS_LoadData('norm'); % 'raw');

% filter by name
wantedFeatureNames = { ...
    'CO_Embed2_Basic_tau.incircle_1', ...
    'CO_Embed2_Basic_tau.incircle_2', ...
    'FC_LocalSimple_mean1.taures', ...
    'SY_SpreadRandomLocal_ac2_100.meantaul', ...
    'DN_HistogramMode_10', ...
    'SY_StdNthDer_1', ...
    'AC_9', ...
    'SB_MotifTwo_mean.hhh', ...
    'EN_SampEn_5_03.sampen1', ...
    'CO_FirstMin_ac', ... 'first_min_acf' replaced
    'DN_OutlierInclude_abs_001.mdrmd', ...
    'CO_trev_1.num', ...
    'FC_LocalSimple_lfittau.taures', ...
    'SY_SpreadRandomLocal_50_100.meantaul', ...
    'SC_FluctAnal_2_rsrangefit_50_1_logi.prop_r1', ...
    'PH_ForcePotential_sine_1_1_1.proppos', ...
    'SP_Summaries_pgram_hamm.maxw', ...
    'SP_Summaries_welch_rect.maxw', ...
    };
    
OperationIDs = [Operations.ID];
OperationNames = {Operations.CodeString};

% indices of the wanted features
wantedOpInds = find(cellfun(@(x) ismember(x, wantedFeatureNames), OperationNames));

redOps = Operations(wantedOpInds);

% Create a reduced data matrix using the automatically chosen operations
reducedMat = TS_DataMat(:,wantedOpInds);

% calculate distances between TS
reducedDists = pdist(reducedMat); % TS_DataMat); % 

% Cluster the time series using the reduced (K-medoids) operation space
maxIter = 100;
av_ts_cluster_size = 100; % cluster count can't be more than nTS/nFeatures?
ts_km_repeats = 10;
ts_k = round(size(TS_DataMat,1) / av_ts_cluster_size);

[~,Cass,~,Cord] = BF_kmedoids(squareform(reducedDists), ts_k, maxIter, ts_km_repeats); 
    
% Sort clusters by size
[~,I] = sort(cellfun(@length,Cord),'descend');

figure;
plotOptions	= struct('plotFreeForm',1,'displayTitles',0,'newFigure',0); 
numPerGroup = 25;
maxLength = 500;
numPlots = min(length(I),12);
for i = 1:numPlots
    subplot(2,numPlots / 2,i);
    series = find(Cass == I(i));

    TS_plot_timeseries('norm',numPerGroup,series,maxLength,plotOptions);
    title(sprintf('Cluster %i (%i time series)',i,length(series)));
end

% % Save image
% fName = ['ts_clusters_',num2str(ks(kIdx)),'_',num2str(corr_dist_threshold),'.png'];
% set(gcf, 'Position', get(0, 'Screensize'));
% print(fName,'-dpng')

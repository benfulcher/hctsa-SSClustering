function SS_TestOpsOnTSClusters

load('HCTSA_N.mat');
load('linkage_clustered_ops.mat');
load('resid_variance.mat');

% Cluster the time series using the reduced (K-medoids) operation space
maxIter = 100;
nrepeats = 500;
ts_k = round(size(TS_DataMat,1) / 10);

[CCi, Cass, err, Cord] = BF_kmedoids(squareform(S_red), ts_k, maxIter, nrepeats); 
    
% Sort clusters by size
[~,I] = sort(cellfun(@length,Cord),'descend');

% Plot a few TS from each of the clusters 
sPlotNum = 1;
plotsPerGroup = 4;
plotColours = get(0,'DefaultAxesColorOrder');

for i = 1:8    
    series = find(Cass == I(i));
    for j = 1:min(plotsPerGroup,length(series))
        subplot(8,4,sPlotNum);
        plot(TimeSeries(series(j)).Data,'color',plotColours(max(1,mod(i,8)),:));
        set(gca,'XTickLabel','','YTickLabel','')
        if j == 1
            title(['Group ',num2str(i)]);
        end
        title(TimeSeries(series(j)).Keywords);
        sPlotNum = sPlotNum + 1;
    end
    sPlotNum = (plotsPerGroup * i) + 1;
end

end


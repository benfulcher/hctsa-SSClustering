function SS_TestOpsOnTSClusters(ts_k)

load('HCTSA_N.mat');
load('linkage_clustered_ops.mat');
load('resid_variance.mat');

if nargin < 1
    ts_k = 100;
end

maxIter = 100;
nrepeats = 50;

[CCi, Cass, err, Cord] = BF_kmedoids(squareform(S_red), ts_k, maxIter, nrepeats); 
    
[~,I] = sort(cellfun(@length,Cord),'descend');
sortedCass = Cass(I);

for i = 1:8
    figure
    
    %plotOptions	=	struct('plotFreeForm',1,'displayTitles',0);
    %TS_plot_timeseries('norm','all',40,300,plotOptions)
    
    series = find(Cass == I(i));
    for j = 1:4
        subplot(4,1,j);
        plot(TimeSeries(series(j)).Data);
    end
end

end


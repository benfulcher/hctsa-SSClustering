function SS_TSDistances(S,S_red)
% Plot time-series distances for original and reduced feature sets
% Needs time-series pairwise distance data from SS_ResidVariance

if nargin < 2
    fprintf(1,'Attempting to load in data from file:\n');
    load('resid_variance.mat','S','S_red');
end

%-------------------------------------------------------------------------------
f = figure('color','w');
figure;

% Full operation space
colormap(BF_getcmap('redyellowgreen',10))
ax = subplot(1,2,1);
S_sqr = squareform(S);
S_order = BF_ClusterReorder(S_sqr);
imagesc(S_sqr(S_order,S_order));
title('TS distances using all operations');
ax.YTick = [];
ax.XTick = [];

% Freeze color axis for second plot to have same scale
caxis manual;

% Reduced oeration space
ax = subplot(1,2,2);
S_red_sqr = squareform(S_red);
S_red_order = BF_ClusterReorder(S_red_sqr);
imagesc(S_red_sqr(S_order,S_order));
title('TS distances using reduced operations');
ax.YTick = [];
ax.XTick = [];

end

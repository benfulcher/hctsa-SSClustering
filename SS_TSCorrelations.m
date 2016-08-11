function SS_TSCorrelations

load('resid_variance.mat');

figure;

% Full operation space
colormap(BF_getcmap('redyellowgreen',10))
subplot(1,2,1);
S_sqr = squareform(S);
S_order = BF_ClusterReorder(S_sqr);
imagesc(S_sqr(S_order,S_order));
title('TS distances using all operations');
set(gca,'YTick',[]);
set(gca,'XTick',[]);

% Freeze color axis for second plot to have same scale
caxis manual;

% Reduced oeration space
subplot(1,2,2);
S_red_sqr = squareform(S_red);
S_red_order = BF_ClusterReorder(S_red_sqr);
imagesc(S_red_sqr(S_order,S_order));
title('TS distances using reduced operations');
set(gca,'YTick',[]);
set(gca,'XTick',[]);

end


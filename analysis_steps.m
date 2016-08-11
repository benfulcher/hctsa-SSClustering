TS_init('INP_ts.mat');

TS_compute(1);

TS_normalize('scaledRobustSigmoid',[0.8,1.0]);

distanceMetricRow	=	'euclidean';	%	time-series	feature	distance 
linkageMethodRow	=	'average';	%	linkage	method 
distanceMetricCol	=	'corr_fast';	%	a	(poor)	approximation	of	correlations	with	NaNs 
linkageMethodCol	=	'average';	%	linkage	method
TS_cluster(distanceMetricRow,	linkageMethodRow,	distanceMetricCol,	linkageMethodCol);

TS_plot_DataMatrix('cl');

TS_InspectQuality

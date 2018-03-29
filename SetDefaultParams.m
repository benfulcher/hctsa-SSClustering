function runParams = SetDefaultParams()
% Set default parameters
%-------------------------------------------------------------------------------

% Store all relevant parameters in the runParams structure:
runParams = struct();

% Input/output:
runParams.inMatFileName = 'HCTSA.mat'; % Filename of data to load in

% Normalization of hctsa data matrix:
runParams.normFunction = 'scaledRobustSigmoid';
runParams.filterOptions = [0.8,1];

% k-medoids clustering:
runParams.ks = [200]; % vector of k values (number of k-medoids clusters) to loop over
runParams.kToUse = 200; % k-value to run with...?
runParams.corrThresholds = [0.1]; % [0.1,0.2]
runParams.opDist = 'abscorr'; % measure distances between pairs of features
runParams.tsDist = 'euclidean'; % measure distances between pairs of time series
runParams.maxIter = 100; % number of iterations of the k-medoids algorithm [typically converges within a handful]
runParams.op_km_repeats = 2000; % number of repeats of k-medoids (takes the best solution from amongst these)

% Linkage clustering after k-medoids:
runParams.linkageMeth = 'complete';

%-------------------------------------------------------------------------------
runParams.ts_km_repeats = 1000;
runParams.av_ts_cluster_size = 10;

%-------------------------------------------------------------------------------
runParams.kIdx = find(runParams.ks == runParams.kToUse);
if isempty(runParams.kIdx)
    fprintf('Could not find K = %u in ks - setting kToUse to %u',...
            runParams.kToUse,runParams.ks(length(runParams.ks)));
    runParams.kIdx = length(runParams.ks);
end

end

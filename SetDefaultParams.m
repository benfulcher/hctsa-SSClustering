function runParams = SetDefaultParams()
% Set default parameters
%-------------------------------------------------------------------------------

% Store all relevant parameters in the runParams structure:
runParams = struct();

% Input/output:
runParams.inMatFileName = 'HCTSA.mat'; % Filename of data to load in

% k-medoids clustering:
runParams.ks = [200]; % vector of k values (number of k-medoids clusters) to loop over
runParams.kToUse = 200; % k-value to run with...?
runParams.corrThresholds = [0.1]; % [0.1,0.2]
runParams.opDist = 'abscorr'; % measure distances between pairs of features
runParams.tsDist = 'euclidean'; % measure distances between pairs of time series

% Linkage clustering after k-medoids:
runParams.linkageMeth = 'complete';

%-------------------------------------------------------------------------------
runParams.op_km_repeats = 2000;
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

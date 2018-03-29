function runParams = SetDefaultParams()
% Set default parameters
%-------------------------------------------------------------------------------

runParams = struct();

% Input/output:
runParams.inMatFileName = 'HCTSA_new_data.mat'; % Filename of data to load in

% K-medoids clustering:
runParams.ks = [200]; % vector of k values (number of k-medoids clusters) to loop over
runParams.kToUse = 200; % k-value to run with...?

runParams.op_km_repeats = 2000;
runParams.ts_km_repeats = 1000;

runParams.av_ts_cluster_size = 10;

runParams.corrThresholds = [0.1,0.2];

% K-medoids clustering:
runParams.opDist = 'abscorr'; % measure distances between pairs of features

% Linkage clustering after k-medoids:
runParams.linkageMeth = 'complete';

%-------------------------------------------------------------------------------
runParams.kIdx = find(ks == kToUse);
if isempty(kIdx)
    fprintf('Could not find K = %u in ks - setting kToUse to %u',...
            kToUse,ks(length(ks)));
    runParams.kIdx = length(ks);
end

end

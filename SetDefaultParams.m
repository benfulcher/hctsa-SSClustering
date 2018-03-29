function runParams = SetDefaultParams()
% Set default parameters
%-------------------------------------------------------------------------------


% Input/output:
inMatFileName = 'HCTSA_new_data.mat'; % Filename of data to load in

% K-medoids clustering:
ks = [200]; % vector of k values (number of k-medoids clusters) to loop over
% kToUse = 200;
op_km_repeats = 2000;
ts_km_repeats = 1000;

av_ts_cluster_size = 10;

corrThresholds = [0.1,0.2];

%-------------------------------------------------------------------------------
kIdx = find(ks == kToUse);
if isempty(kIdx)
    fprintf('Could not find K = %u in ks - setting kToUse to %u',...
            kToUse,ks(length(ks)));
    kIdx = length(ks);
end

%-------------------------------------------------------------------------------
paramNames = {'ks','kIdx','op_km_repeats','ts_km_repeats','inMatFileName',...
                'av_ts_cluster_size','corrThresholds'};
numParams = length(paramNames);
runParams = struct();
for i = 1:numParams
    runParams.(paramNames{i}) = eval(paramNames{i});
end

end

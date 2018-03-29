function runParams = SS_NormaliseAndFilter(runParams,doFilter)
if nargin < 2
    doFilter = false;
end

%-------------------------------------------------------------------------------
% Normalize the data
normFunction = 'scaledRobustSigmoid';
filterOptions = [0.8,1];
classVarFilter = false;
outputFileName = TS_normalize(normFunction,filterOptions,runParams.inMatFileName,classVarFilter);
runParams.normMatFile = outputFileName;

if doFilter
    % BUG IN TS_local_clear_remove...
    TS_local_clear_remove('ops',TS_getIDs('locdep','norm','ops'),1,'norm');
    TS_local_clear_remove('ops',TS_getIDs('spreaddep','norm','ops'),1,'norm');
    TS_local_clear_remove('ops',TS_getIDs('lengthdep','norm','ops'),1,'norm');
end

end

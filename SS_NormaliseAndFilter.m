function runParams = SS_NormaliseAndFilter(runParams,doFilter)
if nargin < 2
    doFilter = false;
end

%-------------------------------------------------------------------------------
% Normalize the data
classVarFilter = false;
outputFileName = TS_normalize(runParams.normFunction,runParams.filterOptions,runParams.inMatFileName,classVarFilter);
runParams.normMatFile = outputFileName;

if doFilter
    % BUG IN TS_local_clear_remove...
    TS_local_clear_remove('ops',TS_getIDs('locdep','norm','ops'),1,'norm');
    TS_local_clear_remove('ops',TS_getIDs('spreaddep','norm','ops'),1,'norm');
    TS_local_clear_remove('ops',TS_getIDs('lengthdep','norm','ops'),1,'norm');
end

end

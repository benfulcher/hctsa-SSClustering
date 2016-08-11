function SS_NormaliseAndFilter( filename )

if nargin < 1
    filename = 'HCTSA_Empirical1000_Aug2015';
end

load(strcat(filename,'.mat'));
save('HCTSA.mat');

TS_normalize('scaledRobustSigmoid',[0.8,1.0]);

% BUG IN TS_local_clear_remove...

TS_local_clear_remove('ops',TS_getIDs('locdep','norm','ops'),1,'norm');
TS_local_clear_remove('ops',TS_getIDs('spreaddep','norm','ops'),1,'norm');
TS_local_clear_remove('ops',TS_getIDs('lengthdep','norm','ops'),1,'norm');

end


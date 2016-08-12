function SS_SetupRunInfo( ks , kToUse , op_km_repeats , ts_km_repeats , ...
    inMatFileName , outTxtFileName , corr_dist_threshold)

if nargin < 1
    ks = [5,7,10,20:20:100,200,500,1000];
end
if nargin < 2
    kToUse = 40;
end
if nargin < 3
    op_km_repeats = 50;
end
if nargin < 4
    ts_km_repeats = 500;
end
if nargin < 5
    inMatFileName = 'HCTSA_new_data';
end
if nargin < 6
    outTxtFileName = 'cluster_info.txt';
end
if nargin < 7
    corr_dist_threshold = 0.2;
end

kIdx = find(ks == kToUse);
if isempty(kIdx)
    fprintf('Could not find K = %i in ks - setting kToUse to %i',...
        kToUse , ks(length(ks)));
    kIdx = length(ks); 
end

save('run_options.mat','ks','kIdx','op_km_repeats','ts_km_repeats',...
    'inMatFileName','outTxtFileName','corr_dist_threshold');

end


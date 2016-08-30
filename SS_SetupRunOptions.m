function SS_SetupRunInfo( ks , kToUse , op_km_repeats , ts_km_repeats , ...
    inMatFileName , outTxtFileName , corr_dist_threshold , av_ts_cluster_size)

if ~exist('ks','var')
    ks = [30];
end
if ~exist('kToUse','var') 
    kToUse = 30;
end
if ~exist('op_km_repeats','var')
    op_km_repeats = 300;
end
if ~exist('ts_km_repeats','var')
    ts_km_repeats = 1000;
end
if ~exist('inMatFileName','var')
    inMatFileName = 'HCTSA_new_data';
end
if ~exist('outTxtFileName','var')
    outTxtFileName = 'cluster_info.txt';
end
if ~exist('corr_dist_threshold','var')
    corr_dist_threshold = 0.2;
end
if ~exist('av_ts_cluster_size','var')
    av_ts_cluster_size = 10;
end

kIdx = find(ks == kToUse);
if isempty(kIdx)
    fprintf('Could not find K = %i in ks - setting kToUse to %i',...
        kToUse , ks(length(ks)));
    kIdx = length(ks); 
end

save('run_options.mat','ks','kIdx','op_km_repeats','ts_km_repeats',...
    'inMatFileName','outTxtFileName','corr_dist_threshold','av_ts_cluster_size');

end


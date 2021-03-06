function [autoChosenOps,autoChosenIDs] = SS_OutputBestOpsTxtFile(runParams,linkageClusters,kmedoidsClusters)

% Load normalized data:
load(runParams.normMatFile,'Operations');

%-------------------------------------------------------------------------------
fprintf('Saving clustering information to %s.txt\n',runParams.outFileNameBase);
fID = fopen([runParams.outFileNameBase,'.txt'],'w');
fprintf(fID,['Output from kmedoids clustering (k = %u) followed by ',...
    'linkage clustering (threshold = %.2f)\n\n'],...
    kmedoidsClusters.k,runParams.corrDistThreshold);

%-------------------------------------------------------------------------------
numLinkageClusters = length(linkageClusters);
autoChosenOps = cell(numLinkageClusters,1);

for i = 1:length(linkageClusters)
    dists = linkageClusters(i).memDists;
    mems = linkageClusters(i).memIdxs;
    kmedCentres = linkageClusters(i).kmedCentres;
    ops = Operations(mems);

    % Sort by increasing distance
    [sortedDists sortIdx] = sort(dists);
    sortedMems = mems(sortIdx);
    sortedOps = ops(sortIdx);

    kmCentreOps = Operations(kmedoidsClusters.CCi(kmedCentres));
    kmCentreNames = {kmCentreOps.Name};
    kmCentreKeys = {kmCentreOps.Keywords};

    % Write cluster centres:
    fprintf(fID,'CLUSTER %u: ',i);
    for j = 1:length(kmCentreNames)
        fprintf(fID,'%s (%s), ',kmCentreNames{j},kmCentreKeys{j});
    end
    fprintf(fID,'\n');

    % Write top 10 operations highly correlated with cluster centre:
    maxList = 10;
    for j = 1:min(length(sortedOps),maxList)
        fprintf(fID,'(%f) %s - %s\n',1-sortedDists(j),sortedOps(j).Name,...
            sortedOps(j).Keywords);
    end

    autoChosenOps{i} = sortedOps(1);
    fprintf(fID,'\n');
end
fclose(fID);

%-------------------------------------------------------------------------------
% Take feature IDs:
autoChosenIDs = cellfun(@(x)x.ID,autoChosenOps);

%-------------------------------------------------------------------------------
% Save info to a .mat file
saveToMatFile = true;
if saveToMatFile
    matFileName = [runParams.outFileNameBase,'.mat'];
    save(matFileName,'autoChosenOps','autoChosenIDs');
    fprintf(1,'Saved reduced operation info to %s\n',matFileName);
end

end

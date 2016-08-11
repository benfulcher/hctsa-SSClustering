clear all;

load('HCTSA_N.mat');
load('best_20_ops.mat');

idx = kmed.idx;

for i = 1:length(chosenOps)
    memberList(i).opIdxs = find(idx == i);
    memberList(i).opName = chosenOps(i).Name;
end

for i = 1:length(memberList)
    opVec = kmed.C(i,:);
    mOps = memberList(i).opIdxs;
    
    corrs = [];
    for j = 1:length(mOps)
        memberOpVec = TS_DataMat(:,mOps(j));
        ops(j) = Operations(mOps(j)); 
        ops(j).correlation = corr(opVec',memberOpVec);
    end
    [memberList(i).corrs , sortIdx] = sort(corrs,'descend');
    memberList(i).ops = ops(sortIdx);
    memberList(i).opIdxs = memberList(i).opIdxs(sortIdx);
end
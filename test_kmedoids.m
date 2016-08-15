rng('default'); % For reproducibility
data = [randn(100,2)*0.75+ones(100,2);
    randn(100,2)*0.55-ones(100,2)];

k = 2;
maxIter = 50;
reps = 200;

D = squareform(pdist(data));

[CCi, Cass, err, Cord] = BF_kmedoids(D, k, maxIter, reps); 

[idx,C] = kmedoids(data,k);
    

# hctsa-SSClustering


Highly Comparative Time Series Analysis ([hctsa](https://github.com/benfulcher/hctsa)) uses a large number of features, many of which are highly inter-correlated.
This code repository selects a reduced set of representative features using the empirical behaviour of operations on a given time-series dataset.
As explained in our [original paper](http://rsif.royalsocietypublishing.org/content/10/83/20130048), the main approach involves two steps:
1. k-medoids clustering (to first sample the densely-populated parts of the space).
2. Linkage clustering on the remaining features (to ensure the final set of features are not highly inter-correlated).

## Set up
- Ensure that you have fully installed the _hctsa_ library from the above link - and the external toolboxes required.
- Run `startup.m` from the _hctsa_ library each time before you use this code to add the _hctsa_ functions to your path.

## Usage

Save your dataset in the standard _hctsa_ format (i.e., as `HCTSA.mat`), and ensure this filename is entered in `SetDefaultParams`.

To start the analysis, set parameters in `SetDefaultParams`, then run the code from `SS_Clustering_main`.
Individual functions can be used to reproduce individual steps separately.

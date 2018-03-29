# hctsa-SSClustering

This code is a study into the Highly Comparative Time Series Analysis ([HCTSA](https://github.com/benfulcher/hctsa)) package.

It provides a method of selecting a reduced set of operations from the full library available, using the operations' empirical behaviour on a diverse dataset.

# Set up

  - Ensure that you have fully installed the HCTSA library from the above link - and the external toolboxes required.
  - Run `startup.m` from the HCTSA library each time before you use this code to add the HCTSA functions to your path.

# Usage

Save your dataset in the standard HCTSA format (i.e., as `HCTSA.mat`).

To start the analysis run the code from `SS_Clustering_main`

  - The separate functions can be used to reproduce individual steps separately
  - However if changing an important parameter (e.g., k for the k-medoids method) __it is recommended to re-run the whole `SS_Clustering_main` script__ to ensure all saved files are in sync.

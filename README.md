# hctsa-SSClustering

This code is a study into the Highly Comparative Time Series Analysis (HCTSA) library developed by Ben Fulcher - https://github.com/benfulcher/hctsa.

It provides a method of selecting a reduced set of operations from the full library available, using the operations' empirical behaviour on a widely varied data set. 

# Set up

  - Ensure that you have fully installed the HCTSA library from the above link - and the external toolboxes required
  - Run <code>startup.m</code> from the HCTSA library each time before you use this code to add the HCTSA functions to your path
  
# Usage 

Ensure your dataset is from as widely varied sources as possible to ensure the most generally useful operations are given. Save this dataset in the standard HCTSA format

To start the analysis run the code from <code>SS_Clustering_main</code> 
  
  - The separate functions can be used to reproduce individual steps separately
  - However if changing an important parameter (e.g. K for the k-medoids method) <b>it is recommended to re-run the whole <code>SS_Clustering_main</code> script</b> to ensure all saved files are in sync.
  

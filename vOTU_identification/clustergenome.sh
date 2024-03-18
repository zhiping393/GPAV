#!/bin/bash


## working directory  %%% need to change
workDir=workDir=~/working_folder/GPAV/vOTU_clustering
cd $workDir

## input contigs
inputcont=virus_GPAV_contigs.fasta

## load tool
module use /users/PAS1117/osu7810/local/share/modulefiles
module load clustergenome/0.9.0

## run command; 80% coverage + 95% identity. it generates a document 'virus_contigs_95-80.fna' conting DNA sequences of each vOTU seed, used for later reads mapping
Cluster_genomes_simon_3.pl -f $inputcont -c 80 -i 95

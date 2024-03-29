#!/bin/bash


## working directory  %%% need to change
workDir=~/working_folder/GPAV/HostPrediction
cd $workDir

## input viral contigs   %%%%%%  need to change
input_viral_cont=${workDir}/virus_GPAV.fna

## input path to bacterial host genomes   %%%%%%  need to change
input_path_bacG=${workDir}/01_host_genomes_bacteria

## input path to archaeal host genomes   %%%%%%  need to change
input_path_arcG=${workDir}/01_host_genomes_archaea

## input taxonomy file to bacterial hosts   %%%%%%  need to change
input_taxa_bac=${workDir}/hostTaxa-all_VirMatcher_bacteria.txt

## input taxonomy file to archaeal hosts   %%%%%%  need to change 
input_taxa_arc=${workDir}/hostTaxa-all_VirMatcher_archaea.txt

## thread number  %%%%%%  may need to change 
thread_num=12


## tools
module use /fs/project/PAS1117/modulefiles
module load VirMatcher

## run VirMatcher
VirMatcher -v $input_viral_cont --archaea-host-dir ${input_path_arcG} --archaea-taxonomy $input_taxa_arc --bacteria-host-dir $input_path_bacG --bacteria-taxonomy $input_taxa_bac --threads $thread_num -o output_VirMatcher --python-aggregator


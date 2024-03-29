#!/bin/bash


## working directory  %%%%%% need to change
workDir=~/working_folder/GPAV/AMG
cd $workDir

## input contig (single genome)    %%%%%% need change
input_cont=${workDir}/virus_GPAV.fasta

## core number    %%%%%% may need change
thread_num=10

## names
input_cont_name_tem=${input_cont##*/}
input_cont_name=${input_cont_name_tem%.*}

## output folder
outputDir=${workDir}/output_checkV_${input_cont_name}
mkdir $outputDir


## load tools
module load singularity/current
module use /fs/project/PAS1117/modulefiles
module load singularityImages

## run checkV
CheckV-2020.04.27.sif contamination $input_cont $outputDir -t $thread_num
CheckV-2020.04.27.sif completeness $input_cont $outputDir -t $thread_num
CheckV-2020.04.27.sif terminal_repeats $input_cont $outputDir 
CheckV-2020.04.27.sif quality_summary $input_cont $outputDir 

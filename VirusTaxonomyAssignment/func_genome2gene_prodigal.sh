#!/bin/bash






## help message
usage() {
echo -e "
This script make the contig-gene.csv file with prodigal's output 'proteins.faa' as input. It will
generate the contig-gene file: genome2gene_file_prodigal.csv, which could be used as input file of -p option of vcontact2

Contact: zhongzhipingemail@gmail.com

Required arguments:
-i      input protein file from virsorter's output (default: proteins.faa)

-o      output genome-to-gene file name (default: genome2gene_file_prodigal.csv)

Optional arguments:
-h, --help   show this help message
"
}

if [ -z "$1" ] || [[ $1 == -h ]] || [[ $1 == --help ]]; then
  usage
  exit 1
fi

## determine if the 1st argument is start with "-"
head=${1:0:1}
if [[ $head != - ]]; then
  echo "syntax error. You need an argument"
  usage
  exit 1
fi

## arguments, variables, and default values

input_pro_file=proteins.faa # prodigal's outpus
output_file_name=genome2gene-file_prodigal.csv
while getopts "i:o:" opt
do
  case $opt in
    i)
        input_protein_file=$OPTARG;;

    o)  output_file_name=$OPTARG;;

    \?)
        echo "invalid argument"
        exit 1;;
  esac
done

## message
echo -e "    "

## path of base working directory
path_input=$(readlink -f $input_protein_file)
workDir=${path_input%/*}
cd $workDir

##### run script
## generate new protein file -- remove redundant lables on the lines with gene name
input_protein_file_name_tem=${path_input##*/}
input_protein_file_name=${input_protein_file_name_tem%.*}
cat $path_input | cut -f1 -d " " | sed "s/\*//g" >  ${input_protein_file_name}_vcontact_prot.faa

## get all gene names
grep "^>" ${input_protein_file_name}_vcontact_prot.faa | sed "s/^>//g" > gene_name_tem.txt

## get contig names
cat gene_name_tem.txt | sed "s/\(.*\)_/\1|/" | cut -f1 -d "|" > contig_name_tem.txt

## combine gene name and contig name
paste -d "," gene_name_tem.txt contig_name_tem.txt > $output_file_name

## add "None" to the third column
sed -i 's/$/,None/' $output_file_name

## add header file
sed -i '1 i\protein_id,contig_id,keywords' $output_file_name

## clean files
rm gene_name_tem.txt contig_name_tem.txt


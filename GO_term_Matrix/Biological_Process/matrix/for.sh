#!/bin/bash
#run script.sh for all selected GOterms
for i in `ls -r ../selected_level_3_goterm/*gene.tsv ../selected_level_4_goterm/*gene.tsv`
do
echo $i
./script.sh $i
done
#move output matrix to result folder
mkdir result_output
mkdir ../gene_subset
mkdir ../gene_subset/input
path="result_output/"
path2="../gene_subset/input/"

mv ../selected_level_3_goterm/*tiff $path
mv ../selected_level_3_goterm/*final.tsv $path
mv ../selected_level_3_goterm/*gene_count.tsv $path2

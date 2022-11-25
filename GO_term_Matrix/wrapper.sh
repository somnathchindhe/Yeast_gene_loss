#!/bin/bash
#run all GO script to get GO term lists
#for i in `ls -r *GO.R`
#do
#echo $i
#Rscript $i
#done
#            ######

#for j in `cat list`
#do 
#cd $j 
#chmod 777 gene_list.sh
#./gene_list.sh
#chmod 777 select.sh
#./select.sh
#cd -
#done

##
#for m in `cat list`
#do
#cd $m/matrix
#chmod 777 for.sh
#./for.sh
#cd -
#done

for a in `cat list`
do
cd $a/gene_subset/input
chmod 777 awk.sh
./awk.sh
cd -
done

for b in `cat list`
do
cd $a/gene_subset/upset_plot
chmod 777 script_upset.sh
./script_upset.sh
cd -
done

#!/bin/bash
#script need input as Gene satble id lists of two pathway and give output as correlation plot of gene between two pathway in yeast preWGD species 
#To run script requires Pillers.tab,preWGD combination list,file1_preWGD.txt,file2_preWGD.txt and preWGD.R files 
#Input Gene stable  id list file should have file name same as pathway name 

a="RNA_metabolism"                  #Input =pathway 1 gene stable id list eg.a="lipid_metabolism'
b="Vitamin_metabolism"                  #Input= pathway 2 gene stable id list  eg. b='Glucose_metabolism"

#for_getting_pathway gene from pillerstab
for i in `cat "$a"`
do
echo $i
cat Pillars.tab |awk -v val=$i '$12==val||$22==val{print$0}' >>output.pathway1.tsv
done

for i in `cat "$b"`
do
echo $i
cat Pillars.tab |awk -v val=$i '$12==val||$22==val{print$0}' >>output.pathway2.tsv
done



#Get list of genes from $a pathway which are lost preWGD yeast species but present in S.cerevisiae species
for i in `cat combi_list_preWGD.txt`
do 
j=`echo $i |cut -f1 -d "_"`
k=`echo $i |cut -f2 -d "_"`
sed "s/aaa/$j/g" file1_preWGD.txt|sed "s/ccc/$k/g" >>main_script1.sh
done

chmod 777 main_script1.sh
./main_script1.sh

#Get list of genes from $a pathway which are lost preWGD yeast species but present in S.cerevisiae species
for i in `cat combi_list_preWGD.txt`
do 
j=`echo $i |cut -f1 -d "_"`
k=`echo $i |cut -f2 -d "_"`
sed "s/aaa/$j/g" file2_preWGD.txt|sed "s/ccc/$k/g" >>main_script2.sh
done

chmod 777 main_script2.sh
./main_script2.sh




#create table for number of genes lost in preWGD  species in $a pathway
wc -l *path1.preWGD.tsv| grep "path1.preWGD.tsv"| sed 's/      //g'| sed 's/^[ \t]* //'|sed 's/ /\t/g' >"$a"_preWGD.table 
echo -e $a"\t"species_name |cat - "$a"_preWGD.table  >"$a"_preWGD.table.tsv



#create table for number of genes lost in preWGD  species in $b pathway
wc -l *path2.preWGD.tsv| grep "path2.preWGD.tsv"| sed 's/      //g'| sed 's/^[ \t]* //'|sed 's/ /\t/g' >"$b"_preWGD.table 
echo -e  $b"\t"species_name |cat - "$b"_preWGD.table >"$b"_preWGD.table.tsv

paste "$a"_preWGD.table.tsv "$b"_preWGD.table.tsv -d "\t"|cut -f1,3,4| sed 's/.path2.preWGD.tsv//g' > "$a"_"$b".preWGD.tsv

#Correlation plot
Rscript preWGD.R "$a"_"$b".preWGD.tsv

rm output.pathway1.tsv output.pathway2.tsv main_script1.sh main_script2.sh
rm *path1.preWGD.tsv *path2.preWGD.tsv "$a"_preWGD.table "$b"_preWGD.table

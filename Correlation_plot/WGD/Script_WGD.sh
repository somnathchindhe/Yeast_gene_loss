#!/bin/bash
#script need input as Gene satble id lists of two pathway and give output as correlation plot of gene between two pathway in yeast WGD species 
#To Run script requires Piilers.tab, combinatiion list, file1.txt ,file2.txt and WGD.R files
#Input Gene stable  id list file should have file name same as pathway name 
a="Vitamin_metabolism"                  #Input =pathway 1 gene stable id list eg.a="lipid_metabolism'
b="RNA_metabolism"                  #Input= pathway 2 gene stable id list  eg. b='Glucose_metabolism"

#Get pathway genes from pillerstab
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



#Get list of genes from $a pathway which are lost in WGD yeast species but present in S.cerevisiae species (two copies lost in WGD and atleast one copy present in s.cere)
for i in `cat combi_list_WGD.txt`
do 
j=`echo $i |cut -f1 -d "_"`
k=`echo $i |cut -f2 -d "_"`
l=`echo $i |cut -f3 -d "_"`
sed "s/aaa/$j/g" file1.txt|sed "s/bbb/$k/g" |sed "s/ccc/$l/g" >>main_script1.sh
done

chmod 777 main_script1.sh
./main_script1.sh

#Get list of genes from $b pathway which are lost in WGD yeast species but present in S.cerevisiae species (two copies lost in WGD >
for i in `cat combi_list_WGD.txt`
do 
j=`echo $i |cut -f1 -d "_"`
k=`echo $i |cut -f2 -d "_"`
l=`echo $i |cut -f3 -d "_"`
sed "s/aaa/$j/g" file2.txt|sed "s/bbb/$k/g" |sed "s/ccc/$l/g" >>main_script2.sh
done

chmod 777 main_script2.sh
./main_script2.sh




#create table for number of genes lost in WGD species in $a pathway
wc -l *path1.WGD.tsv | grep "path1.WGD.tsv"| sed 's/      //g'|sed 's/^[ \t]* //'|sed 's/ /\t/g'>"$a".table 
echo -e $a"\t"species_name |cat - "$a".table >"$a".table2


#create table for number of genes lost in WGD  species in $b pathway
wc -l *path2.WGD.tsv | grep "path2.WGD.tsv"| sed 's/      //g'| sed 's/^[ \t]* //'|sed 's/ /\t/g' >"$b".table 
echo -e $b"\t"species_name |cat - "$b".table >"$b".table2

paste "$a".table2 "$b".table2 -d "\t"|cut -f1,3,4|sed 's/.path2.WGD.tsv//g' >"$a"_"$b".WGD.tsv


#Correlation plot
Rscript WGD.R "$a"_"$b".WGD.tsv

rm output.pathway1.tsv output.pathway2.tsv main_script1.sh main_script2.sh
rm *path1.WGD.tsv *path2.WGD.tsv "$a".table "$b".table


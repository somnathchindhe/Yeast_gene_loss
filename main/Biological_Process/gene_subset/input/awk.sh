#!/bin/bash
for i in `ls -r *gene_count.tsv`
do
echo $i
name=`echo $i| cut -f1 -d  "."`
cat $i|awk '{ if ($4 >= 2 && $4<=4 && $5<=6) print$0}'> "$name".preWGD.subset
cat $i|awk '{ if ($2>=6 && $5 >= 2 && $5<=6) print$0}'>"$name".WGD.subset

cat "$name".preWGD.subset "$name".WGD.subset>$name.subset
cut -f1 "$name".preWGD.subset|sed s/$/,$name/ |sed 's/,/\t/g' >>preWGD.Gene_subset.tsv
cut -f1 "$name".WGD.subset|sed s/$/,$name/ |sed 's/,/\t/g' >>WGD.Gene_subset.tsv
rm "$name".WGD.subset "$name".preWGD.subset
done
cut -f1 preWGD.Gene_subset.tsv|sort|uniq> preWGD_gene.txt
cut -f1 WGD.Gene_subset.tsv|sort|uniq> WGD_Gene.txt
cat preWGD_gene.txt WGD_Gene.txt |sort|uniq >Biological_process
cp -r preWGD* ../
cp -r WGD* ../
cp -r Biological_process ../upset_plot

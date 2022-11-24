#!/bin/bash
g="Biological_process" 
for i in `cat $g`
do
echo $i
cat Pillars.tab |awk -v val=$i '$12==val||$22==val{print$0}' >>Input.output.tsv
done

cat Input.output.tsv|awk '{if ($12=="---") {$12=$22}}1'|cut -f12 >"$g".list
cat "$g".list|sed 's/ /\t/g'|cut -f12 >"$g"1.list

#To create main script for WGD species
for i in `cat combi_list`
do 
y=`echo $i|cut -f1 -d "_"`
x=`echo $i|cut -f2 -d "_"`
z=`echo $i|cut -f3 -d "_"` 
sed "s/zzz/$y/g" file.txt |sed "s/aaa/$x/g" |sed "s/bbb/$z/g" >>WGD.2.main.sh
done

#To create main script for preWGD species
for i in `cat combi_list_preWGD.txt`
do  
x=`echo $i |cut -f1 -d "_"`  
y=`echo $i |cut -f2 -d "_"` 
sed "s/aaa/$x/g" file.preWGD.txt| sed "s/ccc/$y/g" >>main.preWGD.sh 
done

chmod 777 WGD.2.main.sh
./WGD.2.main.sh
chmod 777 main.preWGD.sh
./main.preWGD.sh

cat 21.output.tsv |awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$14,$15,$16,$17,$18,$19,$20,$21}'|sed "s/ /\t/g">"$g".raw_table.output.tsv
sed 's/S/0/g' "$g".raw_table.output.tsv|sed 's/P/0/g'|sed 's/D/1/g'|sed 's/L/1/g' > "$g".matrix.tsv
paste "$g"1.list  "$g".matrix.tsv >"$g".table.tsv
echo -e "Gene ID\tV.polysp\tT.phaffi\tT.blatta\tN.dairen\tN.castel\tK.nagani\tK.africa\tC.glabra\tS.uvarum\tS.kudria\tS.mikata\tS.cerevi\tZ.rouxii\tT.delbru\tK.lactis\tE.gossyp\tE.cymbal\tL.kluyve\tL.thermo\tL.waltii"| cat - "$g".table.tsv >"$g".tsv
grep -v 'Scer_' "$g".tsv >"$g".final.tsv


rm -v *[1234567890]*.output.tsv "$g".tsv
rm WGD.2.main.sh main.preWGD.sh Input.output.tsv "$g".table.tsv "$g".list "$g"1.list  "$g".raw_table.output.tsv "$g".matrix.tsv

#upset plot

Rscript upset.R "$g".final.tsv "$g"
#mv $g* upset_plot/

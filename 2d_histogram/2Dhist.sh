#!/bin/bash 
#This script will create 2D histogram 
#script requires file.txt file.preWDG.txt,combination lists and Pillaer.tab files.
#Get total Gene satble ids of Saccharomyces cerevisiae from Pillers.tab(file obtained from YGOB server)
cat Pillars.tab |awk '$12!="---"||$22!="---"{print$12}' >12
cat Pillars.tab |awk '$12!="---"||$22!="---"{print$22}' >22
cat 12 22|grep -vE 'Scer|---'> Yeast


g="Yeast"              ###########Gene list##########
for i in `cat $g`
do
echo $i
cat Pillars.tab |awk -v val=$i '$12==val||$22==val{print$0}' >>Input.output.tsv
done
cat Input.output.tsv|awk '{if ($12=="---") {$12=$22}}1'|cut -f12 >"$g".list
cat "$g".list|sed 's/ /\t/g'|cut -f12 >"$g"1.list


#Create main script for WGD species
for i in `cat combi_list`
do
y=`echo $i|cut -f1 -d "_"`
x=`echo $i|cut -f2 -d "_"`
z=`echo $i|cut -f3 -d "_"`
sed "s/zzz/$y/g" file.txt |sed "s/aaa/$x/g" |sed "s/bbb/$z/g" >>WGD.2.main.sh
done

#Create main script for preWGD species
for i in `cat combi_list_preWGD.txt`
do
x=`echo $i |cut -f1 -d "_"`
y=`echo $i |cut -f2 -d "_"`
sed "s/aaa/$x/g" file.preWGD.txt| sed "s/ccc/$y/g" >>main.preWGD.sh 
done

#run main scripts
chmod 777 WGD.2.main.sh
./WGD.2.main.sh
chmod 777 main.preWGD.sh
./main.preWGD.sh


#create text matrix table 
cat 21.output.tsv |awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$14,$15,$16,$17,$18,$19,$20,$21}'|sed "s/ /\t/g">"$g".raw_table.output.tsv
paste "$g"1.list "$g".raw_table.output.tsv >"$g".table.tsv
echo -e "Gene ID\tV.polysp\tT.phaffi\tT.blatta\tN.dairen\tN.castel\tK.nagani\tK.africa\tC.glabra\tS.uvarum\tS.kudria\tS.mikata\tS.cerevi\tZ.rouxii\tT.delbru\tK.lactis\tE.gossyp\tE.cymbal\tL.kluyve\tL.thermo\tL.waltii"| cat - "$g".table.tsv >"$g".tsv
grep -v 'Scer_' "$g".tsv >"$g".final.tsv

#remove unnecessary files
rm -v *[1234567890]*.output.tsv
rm WGD.2.main.sh main.preWGD.sh Input.output.tsv "$g".table.tsv "$g".list 12 22 "$g".tsv "$g".raw_table.output.tsv "$g"1.list


#run count.R script
Rscript count.R "$g".final.tsv $g

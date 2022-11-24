for file in `ls -r level_3_goterm_genelist/*gene.tsv `
do
echo $file 
#if (( $(<"${file}" wc -l) > 25 ));then
if (( $(<"${file}" wc -l) > 20 ));then
cp -r $file selected_level_3_goterm/
fi
done
#if (( $(<"level_4_goterm_genelist/${file}" wc -l) > 25 ))
##########################################################
for file in `ls -r level_4_goterm_genelist/*gene.tsv `
do
echo $file
if (( $(<"${file}" wc -l) > 20 ));then
cp -r $file selected_level_4_goterm/
fi
done

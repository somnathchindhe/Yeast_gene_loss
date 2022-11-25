for file in `ls -r level_3_goterm_genelist/`
do
echo $file 
#if (( $(<"${file}" wc -l) >= 20 ));then
if (( $(<"level_3_goterm_genelist/${file}" wc -l) > 20 ));then
cp -r level_3_goterm_genelist/$file selected_level_3_goterm/
fi
done
#if (( $(<"level_3_goterm_genelist/${file}" wc -l) > 25 ))

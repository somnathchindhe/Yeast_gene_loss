#!/bin/bash
for i in `cat List_GO_term/level4_GO_Cellular_Componant`
do
Rscript Gene.R $i
done


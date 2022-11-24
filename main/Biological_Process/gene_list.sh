#!/bin/bash
for i in `cat List_GO_term/level3_GO_BIOLOGICAL_PROCESS`
do
Rscript Gene.R $i
done


#!/bin/bash
for i in `cat List_GO_term/level3_GO_MOLECULAR_FUNCTION`
do
Rscript Gene.R $i
done


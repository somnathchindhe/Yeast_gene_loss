#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
library(biomaRt)

#mart = useEnsembl("ENSEMBL_MART_ENSEMBL")
#mart=useEnsembl(biomart="ENSEMBL_MART_ENSEMBL",host="www.ensembl.org", dataset="scerevisiae_gene_ensembl")
#mart = useEnsembl("ENSEMBL_MART_ENSEMBL")
mart = useEnsembl(biomart="ENSEMBL_MART_ENSEMBL", dataset="scerevisiae_gene_ensembl" ,host="https://www.ensembl.org",mirror="asia",verbose=TRUE,version=107)

#mart=useEnsembl(biomart="ENSEMBL_MART_ENSEMBL", dataset="scerevisiae_gene_ensembl" ,host="www.ensembl.org",mirror="asia",verbose=TRUE)
gene_list<-getBM(attributes=c('ensembl_gene_id','external_gene_name'), filters="go",values=args[1], mart=mart)


file=(paste(args[1],".gene.tsv",sep=""))
setwd("level_4_goterm_genelist/")
write.table(gene_list, file=file , sep="\t",row.names=FALSE,quote = FALSE,col.names=FALSE)

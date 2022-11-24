#!/usr/bin/env Rscript
library(GO.db)
getAllMFChildren <- function(goids)
{
     ans <- unique(unlist(mget(goids, GOMFCHILDREN), use.names=FALSE))
     ans <- ans[!is.na(ans)]
 }
level1_MF_terms <- getAllMFChildren("GO:0003674")
level2_MF_terms <- getAllMFChildren(level1_MF_terms)
level3_MF_terms <- getAllMFChildren(level2_MF_terms) 
level4_MF_terms <- getAllMFChildren(level3_MF_terms)  
level5_MF_terms <- getAllMFChildren(level4_MF_terms) 
setwd("Molecular_Function/List_GO_term")
write.csv(level3_MF_terms, file="level3_GO_MOLECULAR_FUNCTION",row.names=FALSE,col.names=F,quote = FALSE)
write.csv(level4_MF_terms, file="level4_GO_MOLECULAR_FUNCTION",row.names=FALSE,col.names=F,quote = FALSE)
write.csv(level2_MF_terms, file="leveL2_GO_MOLECULAR_FUNCTION",row.names=FALSE,col.names=F,quote = FALSE)
write.csv(level5_MF_terms, file="level5_GO_MOLECOLAR_FUNCTION",row.names=FALSE,col.names=F,quote = FALSE)

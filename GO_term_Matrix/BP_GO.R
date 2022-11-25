#!/usr/bin/env Rscript
library(GO.db)
getAllBPChildren <- function(goids)
{
     ans <- unique(unlist(mget(goids, GOBPCHILDREN), use.names=FALSE))
     ans <- ans[!is.na(ans)]
 }
 level1_BP_terms <- getAllBPChildren("GO:0008150")     # 23 terms
 level2_BP_terms <- getAllBPChildren(level1_BP_terms)  # 256 terms
 level3_BP_terms <- getAllBPChildren(level2_BP_terms)  # 3059 terms
 level4_BP_terms <- getAllBPChildren(level3_BP_terms)  # 9135 terms
 level5_BP_terms <- getAllBPChildren(level4_BP_terms)  # 15023 terms

setwd("Biological_Process/List_GO_term/")
write.csv(level3_BP_terms, file="level3_GO_BIOLOGICAL_PROCESS",row.names=FALSE,col.names=F,quote = FALSE)
write.csv(level4_BP_terms, file="level4_GO_BIOLOGICAL_PROCESS",row.names=FALSE,col.names=F,quote = FALSE)
write.csv(level2_BP_terms, file="leveL2_GO_BIOLOGICAL_PROCESS",row.names=FALSE,col.names=F,quote = FALSE)
write.csv(level5_BP_terms, file="level5_GO_BIOLOGICAL_PROCESS",row.names=FALSE,col.names=F,quote = FALSE)

#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
library(GO.db)
getAllCCChildren <- function(goids)


{
     ans <- unique(unlist(mget(goids, GOCCCHILDREN), use.names=FALSE))
     ans <- ans[!is.na(ans)]
   }



level1_CC_terms <- getAllCCChildren("GO:0005575")
level2_CC_terms <- getAllCCChildren(level1_CC_terms)
level3_CC_terms <- getAllCCChildren(level2_CC_terms)  
level4_CC_terms <- getAllCCChildren(level3_CC_terms)  
level5_CC_terms <- getAllCCChildren(level4_CC_terms)

setwd("Cellular_Componant/List_GO_term")
write.csv(level2_CC_terms, file="level2_GO_Cellular_Componant",row.names=FALSE,col.names=F,quote = FALSE)
write.csv(level3_CC_terms, file="level3_GO_Cellular_Componant",row.names=FALSE,col.names=F,quote = FALSE)
write.csv(level4_CC_terms, file="level4_GO_Cellular_Componant",row.names=FALSE,col.names=F,quote = FALSE)
write.csv(level5_CC_terms, file="level5_GO_Cellular_Componant",row.names=FALSE,col.names=F,quote = FALSE)

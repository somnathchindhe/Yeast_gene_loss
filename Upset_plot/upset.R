#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE) 
library(UpSetR)
df2<-read.table(args[1],header=T,sep="\t")
P1<-upset(df2,sets=c("V.polysp","T.phaffi","T.blatta","N.dairen","N.castel","K.nagani","K.africa","C.glabra","S.uvarum","S.kudria"
,"S.mikata","S.cerevi","Z.rouxii","T.delbru","K.lactis","E.gossyp","E.cymbal","L.kluyve","L.thermo","L.waltii"),, order.by ="freq",main.bar.color = "#A66CFF" ,mainbar.y.label="Intersecting Genes",
sets.x.label="no. of genes",mb.ratio =c(0.55,0.45),shade.alpha=T,color.pal="green",matrix.color="#D61C4E",sets.bar.color="#7DCE13",
point.size = 2.5, line.size = 0.9)

tiff(paste(args[2],".upset.tiff",sep=""),height=8,width=10,units="in",res=300) #plot dimensions
P1
dev.off()

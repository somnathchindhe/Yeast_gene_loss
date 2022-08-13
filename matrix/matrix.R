#!/usr/bin/env Rscript
#matrix.R script take input pathway final.tsv table and plot character matrix according gene status for given pathway in 20 yeast species(preWGD and WGD)
args = commandArgs(trailingOnly=TRUE)

A<-read.table(args[1],header=T,sep="\t")
B<-as.matrix(A) 
row.names(B)<-A$Gene.ID
df=subset(B,select=-c(Gene.ID))
#To get pattern of gene loss count for all genes of given pathway in  20 yeast species(preWGD and WGD)
AA<-A
AA$Present<-rowSums(AA[-1]=="P")
AA$Single_lost_WGD<-rowSums(AA[-1]=="S")
AA$Lost_preWGD<-rowSums(AA[-1]=="L")
AA$Double_lost_WGD<-rowSums(AA[-1]=="D")
df3<-subset(AA,select=-c(2:21))
write.table(df3, file=paste(args[2],".gene_count.tsv",sep=""),sep="\t",row.names=FALSE,quote = FALSE)

#TO change order of coloumns according to phylogenetic tree
colorder<-c("K.lactis","E.cymbal" ,"E.gossyp", "L.kluyve", "L.thermo", "L.waltii",  "T.delbru", "Z.rouxii",
"N.dairen",  "N.castel", "K.africa",  "K.nagani",  "C.glabra", "S.uvarum", "S.kudria", "S.mikata",
"S.cerevi", "T.blatta", "T.phaffi", "V.polysp")
df2<-df[ ,colorder]

genes<-dim(df2)[1]
species<-dim(df2)[2]
df_width<-dim(df2)[1]/2.5

m<-matrix(df2,nrow=genes,ncol=species)
m2<-m
m2[] <-c("#720e9e","#D82148","#FFF6BE","#CCCCFF")[match(m, c("L","D","S","P"))]
#plot
tiff(paste(args[2],".matrix.tiff",sep="") ,width = df_width, height = 15, units = 'in', res=300)
par(mar = c(10, 10, 2, 1))
(plot(row(m2), col(m2),bg=m2,col="black",pch=22,cex=8 ,xlab="", xaxt="n", ylab="",yaxt="n",main=paste(args[2])))
axis(1, at=1:genes, labels=rownames(df2),cex.axis=1.5,las=2,lwd=2,col.ticks = "black",col.axis = "black")
axis(2, at=1:species, labels=colnames(df2),las=2,cex.axis=2,tck = 0.02,col.ticks = "black",col.axis = "#000004")
dev.off()

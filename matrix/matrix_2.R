#!/usr/bin/env Rscript
#matrix.R script take input pathway final.tsv table and plot character matrix according gene status for given pathway in 20 yeast species(preWGD and WGD)
#This matrix plot will be ploted only if given pathway have more then 200 genes
args = commandArgs(trailingOnly=TRUE)
A<-read.table(args[1],header=T,sep="\t")

#To get pattern of gene loss count for all genes of given pathway in  20 yeast species(preWGD and WGD)
AA<-A
AA$Present<-rowSums(AA[-1]=="P")
AA$Single_lost_WGD<-rowSums(AA[-1]=="S")
AA$Lost_preWGD<-rowSums(AA[-1]=="L")
AA$Double_lost_WGD<-rowSums(AA[-1]=="D")
df3<-subset(AA,select=-c(2:21))
write.table(df3, file=paste(args[2],".gene_count.tsv",sep=""),sep="\t",row.names=FALSE,quote = FALSE)

#Split dataframe into two dataframe
chunk<-dim(A)[1]/2
n<- nrow(A)
r <- rep(1:ceiling(n/chunk),each=chunk)[1:n]
d <- split(A,r)
a1<-d$`1`
a2<-d$`2`

#To change column order according to phylogentic tree
colorder<-c("K.lactis","E.cymbal" ,"E.gossyp", "L.kluyve", "L.thermo", "L.waltii",  "T.delbru", "Z.rouxii",
"N.dairen",  "N.castel", "K.africa",  "K.nagani",  "C.glabra", "S.uvarum", "S.kudria", "S.mikata",
"S.cerevi", "T.blatta", "T.phaffi", "V.polysp")

 
b1<-as.matrix(a1)
row.names(b1)<-a1$Gene.ID
df.b1=subset(b1,select=-c(Gene.ID))
b1.df2<-df.b1[ ,colorder]


b2<-as.matrix(a2)
row.names(b2)<-a2$Gene.ID
df.b2=subset(b2,select=-c(Gene.ID))
b2.df2<-df.b2[ ,colorder]


genes1<-dim(b1.df2)[1]
genes2<-dim(b2.df2)[1]
species<-dim(b1.df2)[2]
df_width<-dim(b1.df2)[1]/2.5


#part1 of matrix plot
b1.m<-matrix(b1.df2,nrow=genes1,ncol=species)
b1.m2<-b1.m
b1.m2[] <-c("#720e9e","#D82148","#FFF6BE","#CCCCFF")[match(b1.m, c("L","D","S","P"))]
tiff(paste(args[2],".matrix.tiff",sep="") ,width = df_width, height = 30, units = 'in', res=300)
par(mar = c(8, 11, 2, 1))
par(mfrow=c(2,1))
plot(row(b1.m2), col(b1.m2),bg=b1.m2,col="black",pch=22,cex=8 ,xlab="", xaxt="n", ylab="",yaxt="n")
axis(1, at=1:genes1, labels=rownames(b1.df2),cex.axis=1.4,las=2,lwd=2,col.ticks = "black",col.axis = "black")
axis(2, at=1:species, labels=colnames(b1.df2),las=2,cex.axis=2,tck = 0.02,col.ticks = "black",col.axis = "#000004")


#plot2 of matrix plot
b2.m<-matrix(b2.df2,nrow=genes2,ncol=species)
b2.m2<-b2.m
b2.m2[] <-c("#720e9e","#D82148","#FFF6BE","#CCCCFF")[match(b2.m, c("L","D","S","P"))]
par(mar = c(10, 11, 2, 1))
plot(row(b2.m2), col(b2.m2),bg=b2.m2,col="black",pch=22,cex=8 ,xlab="", xaxt="n", ylab="",yaxt="n")
axis(1, at=1:genes2, labels=rownames(b2.df2),cex.axis=1.4,las=2,col.ticks = "black",col.axis = "black")
axis(2, at=1:species, labels=colnames(b2.df2),las=2,cex.axis=2,tck = 0.02,col.ticks = "black",col.axis = "#000004")

dev.off()

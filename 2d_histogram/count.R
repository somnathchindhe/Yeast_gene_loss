#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
library(grid)

#Make a table containing a gene-wise number of species having status of Present, Single_lost_WGD, Lost_preWGD, Double_lost_WGD, etc.
AA<-read.table(args[1],header=T,sep="\t")
AA$Present<-rowSums(AA[-1]=="P")
AA$Single_lost_WGD<-rowSums(AA[-1]=="S")
AA$Lost_preWGD<-rowSums(AA[-1]=="L")
AA$Double_lost_WGD<-rowSums(AA[-1]=="D")
df3<-subset(AA,select=-c(2:21))
write.table(df3, file=paste(args[2],".gene_count.tsv",sep=""),sep="\t",row.names=FALSE,quote = FALSE)


#".gene.cout.tsv" is input to plot 2D histogram heatmap
#2D_histogram_plot for preWGD species
library(ggplot2)
p <- ggplot(df3, aes(Lost_preWGD,Present))
h2 <- p + stat_bin2d()
library(RColorBrewer)
rf <- colorRampPalette(rev(brewer.pal(9,'YlOrRd')))
r <- rf(32)
h2 <- p + stat_bin2d(bins=8) + scale_fill_gradientn(colours=r)
h2 <- p + stat_bin2d(bins=8) + scale_fill_gradientn(colours=r)
h2<- p+ stat_bin2d(bins=8,geom = "tile",position = "identity")+scale_fill_gradientn(colours=r,trans="log10")
hf2<- h2+labs(y= "Present", x = "Lost(preWGD)",fill="Gene
Count")
#tiff(paste(args[2],".2dhist.preWGD.tiff",sep="") ,width = 10, height = 10, units = 'in', res=300)
hf2

#2D_histogram_plot for WGD species
library(ggplot2)
p1 <- ggplot(df3, aes(Double_lost_WGD,Present))
h3 <- p1 + stat_bin2d()
library(RColorBrewer)
rf <- colorRampPalette(rev(brewer.pal(9,'YlOrRd')))
r <- rf(32)
h3 <- p1 + stat_bin2d(bins=12) + scale_fill_gradientn(colours=r)
h3 <- p1 + stat_bin2d(bins=12) + scale_fill_gradientn(colours=r,trans="log10")
h3<- p1+ stat_bin2d(bins=12,geom = "tile",position = "identity",show.legend = FALSE)+scale_fill_gradientn(colours=r,trans="log10")
hf3<- h3 +labs(y= "Present", x = "Lost(WGD)")
hf3
library("gridExtra")
#tiff(paste(args[2],".2dhist.WGD.tiff",sep="") ,width = 10, height = 10, units = 'in', res=300)
tiff(paste(args[2],".2dhist.tiff",sep="") ,width = 15, height = 9, units = 'in', res=300)
h1<-grid.arrange(hf3, hf2, nrow = 1)
#top=textGrob("Global pattern of gene loss in Yeast",gp=gpar(fontsize=16,font=2))
#)
h1
dev.off()


#!/usr/bin/env Rscript
#To create correaltion plot betwen two pathway in preWDG species
#Take input as table containing number of genes lost from both pathway in preWGD species 
args = commandArgs(trailingOnly=TRUE)
library(ggplot2)
library("ggpubr")
data<- read.table(args[1], header = T, sep = "\t")
pathway_X<-colnames(data)[1]
pathway_Y<-colnames(data)[2]
main<- paste(pathway_Y, pathway_X , sep="_V/s_")
tiff(paste(args[1],"_correlation.preWGD.tiff", sep=""), width = 8, height = 8, units = 'in', res = 500)
ggscatter(data, x= pathway_X, y = pathway_Y, add = "reg.line", conf.int = TRUE,
          cor.coef = TRUE, cor.method = "pearson",
          xlab = pathway_X, ylab = pathway_Y, color = "#0096FF", main = main)
dev.off()

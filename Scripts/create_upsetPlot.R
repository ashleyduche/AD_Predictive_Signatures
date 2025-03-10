#Install and load UpSetR for visualization
if(!requireNamespace("UpSetR", quietly=TRUE)) install.packages("UpSetR")
library(UpSetR)

#Source create_binaryMtx function to prepare data format
source("~/AD_signature_predictions/Scripts/create_binaryMtx.R")

#Upload example data 
df<-read.csv("~/AD_signature_predictions/Data/gene_region_data.csv", stringsAsFactors=FALSE)

#Run function on example data specifying the number of regions genes are shared across 
common_genes_4<-create_binaryMtx(df, min_regions=4)

#Generate UpSet plot showing number of genes shared across regions
upset_plotupset(common_genes_4, nsets=ncol(common_genes_4), 
      sets=colnames(common_genes_4), 
      order.by="freq", 
      sets.x.label="Brain Regions", 
      keep.order=TRUE)

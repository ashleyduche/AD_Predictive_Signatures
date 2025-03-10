# This script defines the create_binaryMtx function for gene-region analysis.

# Function: create_binaryMtx
# This function processes a data frame containing gene and region information 
# and generates a binary matrix where each row represents a gene and each column 
# represents a region. The matrix indicates the presence of genes across regions 
# and filters genes based on a minimum region threshold.

# Parameters:
# df - A data frame with at least two columns: one for gene names and one for regions.
# genes_col - The name of the column containing gene names (default: "genes").
# region_col - The name of the column containing region names (default: "region").
# min_regions - The minimum number of regions a gene must appear in to be retained (default: 3).

# Returns:
# A binary matrix with genes as rows and regions as columns, 
# where 1 indicates presence and 0 indicates absence.

# Example usage:
# binary_matrix<-create_binaryMtx(df, min_regions = 4)

# Install and load required packages
required_packages<-c("dplyr","tidyr","tibble","rlang")
for (pkg in required_packages) {
  if (!requireNamespace(pkg,quietly = TRUE)) install.packages(pkg)
  library(pkg,character.only = TRUE)
}

create_binaryMtx<-function(df,genes_col="genes",region_col="region",min_regions = 3) {
  df<-df %>%
    mutate(!!genes_col := strsplit(as.character(.data[[genes_col]]), ", ")) %>%
    unnest(!!genes_col)
  
  binary_matrix<-df %>%
    mutate(present = 1) %>%
    distinct(!!sym(region_col), !!sym(genes_col),.keep_all = TRUE) %>%
    spread(!!sym(region_col),present,fill = 0) %>%
    mutate(n_regions = rowSums(select(., -!!sym(genes_col)))) %>%
    filter(n_regions >= min_regions) %>%
    select(-n_regions) %>%
    column_to_rownames(var = "genes")
  
  return(binary_matrix)
}

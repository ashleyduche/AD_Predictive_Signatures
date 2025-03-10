# AD_Predictive_Signatures

This repository contains scripts and data to recreate figures from our publication **Predictive Gene Expression Signatures for Alzheimer's Disease Using Post-Mortem Brain Tissue**

### 1. Location of required scripts and data to reproduce **Figure 3A**:
```
Data/
  ├── gene_region_data.csv   # Gene presence data across regions

Scripts/
  ├── create_binaryMtx.R     # Generates binary matrix with gene intersections across regions
  ├── create_upsetPlot.R     # Creates UpSet plot from binary matrix
```

### Steps to Reproduce Figure 3A:
1. Install required R packages:
   ```r
   install.packages(c("tidyverse", "UpSetR"))
   ```
2. Run the script to generate the binary matrix:
   ```r
   source("Scripts/create_binaryMtx.R")
   ```
3. Generate the UpSet plot:
   ```r
   source("Scripts/create_upsetPlot.R")
   ```

### Data Format
`gene_region_data.csv` contains:
| Column Name | Description |
|-------------|------------|
| `genes`     | Gene names (comma-separated) |
| `region`    | Brain or tissue region |


### 3. Location of required scripts and data to reproduce **Figure 3C**:
```
Data/
  ├── shared_compound_data.csv  # Data for Sankey plot

Scripts/
  ├── create_sankeyPlot.R       # Generates the Sankey plot
```
### Steps to Reproduce Figure 3C:
1. Install required R packages:
   ```r 
   required_packages <- c("networkD3", "htmlwidgets", "dplyr", "tidyverse", "webshot", "jsonlite")
     for (pkg in required_packages) {
       if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
       library(pkg, character.only = TRUE)
     }
   ```
2. Run the script to generate the Sankey plot:
   ```r
   source("Scripts/create_sankeyPlot.R")
   ```
## Data Format
'shared_compound_data.csv' contains:
| Name                      | Description                | Target Genes       |
|---------------------------|----------------------------|--------------------|
| albendazole               | Anthelmintic               | CYP1A2, TUBA1A    |
| orantinib                 | FGFR inhibitor             | PDGFRB, EGFR      |

If you use this code, please cite our publication.


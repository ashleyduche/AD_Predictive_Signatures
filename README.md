# AD_Predictive_Signatures

This repository contains scripts and data to recreate figures from our publication **Predictive Gene Expression Signatures for Alzheimer's Disease Using Post-Mortem Brain Tissue**

### Location of required scripts and data to reproduce **Figure 3A**:
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

If you use this code, please cite our publication.

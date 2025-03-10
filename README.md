# AD_Predictive_Signatures

This repository contains scripts and data to recreate figures from our publication **Predictive Gene Expression Signatures for Alzheimer's Disease Using Post-Mortem Brain Tissue**.

---

## 1. Location of Required Scripts and Data to Reproduce **Figure 3A** (Upset Plot)
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

---

## 2. Location of Required Scripts and Data to Reproduce **Figure 3B** (Bubble Plot)
```
Data/
  ├── shared_compound_data.csv  # Shared compound data across regions

Scripts/
  ├── create_bubblePlot.R       # Generates bubble plot of shared compounds and connectivity scores
```
### Steps to Reproduce Figure 3B:
1. Install required R packages:
   ```r
   required_packages <- c("ggplot2", "readr")
   for (pkg in required_packages) {
     if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
     library(pkg, character.only = TRUE)
   }
   ```
2. Run the script to generate the bubble plot:
   ```r
   source("Scripts/create_bubblePlot.R")
   ```

### Data Format
`shared_compound_data.csv` contains:
| Score   | Type  | Compound   | Description                            | Target Genes       |
|---------|------|------------|----------------------------------------|--------------------|
| -90.40  | cp   | SB-216763  | Glycogen synthase kinase inhibitor    | GSK3B, CCNA2      |
| -90.39  | cp   | BRD-K88742 | HDAC inhibitor                        | HDAC8, IL1B       |
| -90.14  | cp   | NS-3694    | Glutamate receptor antagonist         | GRIK1             |

Each row represents a **compound**, its **description**, and a few of its **target genes** across different regions.

---

## 3. Location of Required Scripts and Data to Reproduce **Figure 3C** (Sankey Plot)
```
Data/
  ├── shared_compound_data.csv  # Shared compound data across pathways

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

### Data Format
The same `shared_compound_data.csv` file used for **Figure 3B** is also used for Figure 3C.

---

If you use this code, please cite our publication.

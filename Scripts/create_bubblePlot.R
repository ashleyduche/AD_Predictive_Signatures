# Load required packages
required_packages <- c("ggplot2", "readr")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
  library(pkg, character.only = TRUE)
}

# Load data
data <- read_csv("Data/shared_compound_data.csv")

# Generate bubble plot
shared_comp_plot <- ggplot(data, aes(x = Region, y = Description, size = Score, color = Score)) +
  geom_point(alpha = 0.8, stroke = 1, show.legend = TRUE) +
  scale_size_binned(range = c(8, 2), limits = c(-100, -90), n.breaks = 5) +
  scale_color_continuous(type = "gradient", breaks = seq(-100, -90, length.out = 5), limits = c(-100, -90)) +
  theme_bw() +
  labs(x = "Brain Region", size = "Connectivity Score", color = "Connectivity Score") +
  theme(
    axis.title.y = element_blank(),
    legend.title = element_text(size = 12, face = 'bold', hjust = 0.5), 
    axis.title.x = element_text(vjust = -0.5, size = 12, face = 'bold')
  )




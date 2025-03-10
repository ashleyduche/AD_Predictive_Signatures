#Install and load packages 
required_packages <- c("networkD3", "htmlwidgets", "dplyr", "tidyverse", "webshot", "jsonlite")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
  library(pkg, character.only = TRUE)  # Load package (with messages)
}

#Required data
df <- read.csv("~/AD_Predictive_Signatures/Data/shared_compound_data.csv", stringsAsFactors = FALSE)

#Split multiple gene targets and reorder nodes
df <- df %>%
  mutate(Target = strsplit(Target, ", ")) %>%
  unnest(Target)

node_names <- c(
  unique(df$Description),  
  unique(df$Compound),     
  unique(df$Target)        
)
nodes <- data.frame(name = node_names, stringsAsFactors = FALSE)

#Create links (Descriptions → Compounds → Target Genes)
links <- df %>%
  mutate(source = match(Description, nodes$name) - 1,
         target = match(Compound, nodes$name) - 1) %>%
  select(source, target) %>%
  mutate(value = 1)

links_genes <- df %>%
  mutate(source = match(Compound, nodes$name) - 1,
         target = match(Target, nodes$name) - 1) %>%
  select(source, target) %>%
  mutate(value = 1)

links <- bind_rows(links, links_genes)

#Set and map node colors
custom_colors <- c("#44015480", "#3B528B80", "#21908C80", "#8FD744FF",
                   "#FDE725FF", "#7AD151FF", "#22A884FF", "#2A788EFF",
                   "#414487FF", "#0571B0", "#6666CC", "#0066CC",
                   "#99CCCC", "#27AD81FF", "#33CCCC", "#4DAC26", "slateblue")
num_nodes <- nrow(nodes)
num_Compounds <- length(unique(df$Compound))

Compound_list <- unique(df$Compound)
Compound_colors <- setNames(custom_colors[1:num_Compounds], Compound_list)

node_colors <- nodes %>%
  mutate(color = case_when(
    name %in% df$Compound ~ Compound_colors[name],  # Compound colors
    name %in% df$Description ~ Compound_colors[df$Compound[match(name, df$Description)]],  # Description inherits Compound color
    name %in% df$Target ~ Compound_colors[df$Compound[match(name, df$Target)]]  # Genes inherit Compound color
  ))

links <- links %>%
  mutate(group = as.character(source))

#JavaScript color scale to map color across corresponding nodes
color_scale <- sprintf('d3.scaleOrdinal()
  .domain(%s)
  .range(%s)',
                       jsonlite::toJSON(as.character(0:(num_nodes - 1))),
                       jsonlite::toJSON(unname(node_colors$color))
)

#Generate sankey plot
sankey <- sankeyNetwork(
  Links = links, Nodes = nodes, Source = "source", Target = "target", 
  Value = "value", NodeID = "name", units = "Interactions",
  fontSize = 17, nodeWidth = 30, nodePadding = 2, LinkGroup = "group",
  colourScale = JS(color_scale)
)

#Further refine color transparency of plot using JavaScript
sankey <- htmlwidgets::onRender(
  sankey,
  'function(el, x) {
    d3.select(el).selectAll(".node text")
      .style("font-family", "Arial");  // Apply Calibri font

    d3.select(el).selectAll(".link")
      .style("stroke-opacity", 0.2)  // Set link transparency
      .style("stroke", function(d) { return x.colourScale(d.source); });

    d3.select(el).selectAll(".node rect")
      .style("fill", function(d) { return x.colourScale(d.index); });

    x.sankey.layout(1);  // Re-run layout to apply changes
  }'
)

#Plot the final Sankey diagram
print(sankey)


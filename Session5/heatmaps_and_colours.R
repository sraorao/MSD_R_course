library(tidyverse)
library(RColorBrewer)

# LOAD and prepare data from files ####
# we first make a list of filenames of interest using the list.files() function
filenames = list.files(path = "Session5/data/", pattern = "counts.txt", full.names = TRUE)

# we then use lapply(), which is similar to a for() loop
# to read the tab separated table of count data
# so that we get a list of data.frames in count_data_list
count_data_list = lapply(filenames, function(x) {
                    sample_name = substr(x, 15, 16)
                    each_sample_count = read.table(x, header = TRUE, sep = "\t",
                                                   col.names = c("mir_name", sample_name))
                    return(each_sample_count)
                  })
head(count_data_list[[1]])
str(count_data_list)

# we then merge all the dataframes recursively using Reduce
norm_counts = Reduce(function(x, y) {merge(x, y, by = "mir_name")}, count_data_list)

View(norm_counts)

conditions = as.factor(substr(colnames(norm_counts)[2:7], 1, 1))

# COLOURS ####
# Print available palettes
display.brewer.all()

# set colours
condition_colours = brewer.pal(2, "Accent")[conditions]
bluegreen_colours = colorRampPalette(brewer.pal(9, "GnBu"))(100)

# Draw heatmap ####
# install.packages("gplots)
library(gplots) # do not confuse with ggplot2

# sort results by adjusted p value and pick the top 50 microRNAs
results = arrange(results, padj)
selected_mirs = results$mir[1:50]

# filter norm_counts for only the selected 50 microRNAs
norm_counts %>%
  filter(mir_name %in% selected_mirs) -> norm_counts_selected

# shorten the miR name and assign the result to rowname
# then exclude the mir_name column (because it's in the row names now)
rownames(norm_counts_selected) <- sub("hsa-", "", norm_counts_selected$mir_name)
norm_counts_selected = norm_counts_selected[, 2:7]

# convert to matrix
norm_counts_selected = as.matrix(norm_counts_selected)

# plot heatmap
pdf("heatmap_top50.pdf", width = 8)
heatmap.2(norm_counts_selected, 
          scale = "row", 
          trace = "none", 
          col = bluegreen_colours, 
          Rowv = FALSE, 
          dendrogram = "column", 
          ColSideColors = condition_colours)
dev.off()

# why scaling is important
heatmap.2(norm_counts_selected, 
          trace = "none", 
          col = bluegreen_colours, 
          Rowv = FALSE, 
          dendrogram = "column", 
          ColSideColors = condition_colours)

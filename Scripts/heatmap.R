library(pheatmap)
colgroup=read.table("heatmap_group.txt",sep="\t",header=F,row.names=1)
colnames(colgroup)=c("Group")
mat=read.table("heatmap_geography_lefse.txt", header = T, row.names = 1, sep="\t", check.names = F)
pheatmap(mat, scale = "row", cluster_rows =T, clustering_method = "average", cluster_cols = F, cellwidth = 2, cellheight = 6, main = " ", fontsize = 10, filename = "heatmap_geography_lefse.pdf", angle_col = "0", annotation_col = colgroup, border = FALSE, show_rownames = F, show_colnames = F, color = colorRampPalette(c("#1793d1","#FFFFFF","#ed1c24"))(100))

mat=read.table("heatmap_age_lefse.txt", header = T, row.names = 1, sep="\t", check.names = F)
pheatmap(mat, scale = "row", cluster_rows =T, clustering_method = "average", cluster_cols = F, cellwidth = 2, cellheight = 4, main = " ", fontsize = 10, filename = "heatmap_age_lefse.pdf", angle_col = "0", annotation_col = colgroup, border = FALSE, show_rownames = F, show_colnames = F, color = colorRampPalette(c("#1793d1","#FFFFFF","#ed1c24"))(100))

mat=read.table("heatmap_feeding_style_lefse.txt", header = T, row.names = 1, sep="\t", check.names = F)
pheatmap(mat, scale = "row", cluster_rows =T, clustering_method = "average", cluster_cols = F, cellwidth = 3, cellheight = 6, main = " ", fontsize = 10, filename = "heatmap_feeding_style_lefse.pdf", angle_col = "0", annotation_col = colgroup, border = FALSE, show_rownames = F, show_colnames = F, color = colorRampPalette(c("#1793d1","#FFFFFF","#ed1c24"))(100))

mat=read.table("heatmap_gastrointestinal_tract_lefse.txt", header = T, row.names = 1, sep="\t", check.names = F)
pheatmap(mat, scale = "row", cluster_rows =T, clustering_method = "average", cluster_cols = F, cellwidth = 2, cellheight = 6, main = " ", fontsize = 10, filename = "heatmap_gastrointestinal_tract_lefse.pdf", angle_col = "0", annotation_col = colgroup, border = FALSE, show_rownames = F, show_colnames = F, color = colorRampPalette(c("#1793d1","#FFFFFF","#ed1c24"))(100))

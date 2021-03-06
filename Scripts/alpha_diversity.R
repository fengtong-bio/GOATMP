library(vegan)
library(ggpubr)
library(ggplot2)
otu <- read.delim('alpha_diversity_feeding_style.txt', row.names = 1, sep = '', stringsAsFactors = FALSE, check.names = FALSE)
otu <- t(otu)
groups <- read.delim('alpha_diversity_feeding_style_group.txt', row.names = 1, sep = '', stringsAsFactors = FALSE, check.names = FALSE, colClasses=c("names"="character"))
data_norm_shannon = diversity(otu, "shannon")
data_ggplot = data.frame(data_norm_shannon)
data_ggplot = data.frame(data_ggplot, groups["group"])
pdf(file = "alpha_diversity_feeding_style.pdf")
my_comparisons <- list(c('Grazing','Indoor_feeding'))
ggboxplot(data_ggplot, x="group", y="data_norm_shannon", color = "group", palette = c('#74a9cf','#045a8d'), add = "jitter") + stat_compare_means(comparisons = my_comparisons, label = "p.signif") + theme(panel.background = element_rect(fill = NA, colour = "black", linetype = "solid"), legend.key = element_rect(fill = NA)) + theme(legend.position = "right") + scale_x_discrete(limits = c('Grazing','Indoor_feeding'))
dev.off()

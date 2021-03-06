library(ggplot2)
sample <- read.table("ar_geom_bar.txt",sep = "\t",header = T)
pdf(file = "ar_geom_bar.pdf",width=10, height=5)
ggplot(data = sample, mapping = aes(x = ID, y = Proportions, fill = ID)) + geom_bar(stat = 'identity') + scale_x_discrete(limits = c('Species','Genus','Family','Order','Class','Phylum')) + scale_fill_manual(values = c('#f16913','#fdae6b','#fdd0a2','#fd8d3c','#d94801','#feedde')) + coord_flip() + theme(panel.background = element_rect(fill = NA), legend.position = "none") + labs(y = "Proportions(%)")
dev.off()

sample <- read.table("bac_geom_bar.txt",sep = "\t",header = T)
pdf(file = "bac_geom_bar.pdf",width=10, height=5)
ggplot(data = sample, mapping = aes(x = ID, y = Proportions, fill = ID)) + geom_bar(stat = 'identity') + scale_x_discrete(limits = c('Species','Genus','Family','Order','Class','Phylum')) + scale_fill_manual(values = c('#4292c6','#9ecae1','#c6dbef','#6baed6','#2171b5','#eff3ff')) + coord_flip() + theme(panel.background = element_rect(fill = NA), legend.position = "none") + labs(y = "Proportions(%)")
dev.off()

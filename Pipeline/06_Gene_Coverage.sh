#!/bin/bash

########## Part6 Coverage of Genes ##########
salmon=~/bin/salmon

mkdir -p ./14_Gene_Coverage/

ln -s 10_cd-hit/MAGs_ununique_nuc.fa ./14_Gene_Coverage/

${salmon} index \
	-t 14_Gene_Coverage/MAGs_ununique_nuc.fa \
	-i 14_Gene_Coverage/MAGs_ununique_nuc.index \
	--type quasi \
	-k 31

${salmon} quant \
	-i 14_Gene_Coverage/MAGs_ununique_nuc.index \
	--libType IU 
	-1 03_bowtie2/${sampleID}_meta_clean_R1.fq.gz \
	-2 03_bowtie2/${sampleID}_meta_clean_R2.fq.gz \
	-o 14_Gene_Coverage/${sampleID}.quant \
	-p 80


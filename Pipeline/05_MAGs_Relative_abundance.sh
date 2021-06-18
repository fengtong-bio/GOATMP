#!/bin/bash

########## Part5 Relative abundance of MAGs ##########
bwa=~/bin/bwa
samtools=~/bin/samtools


### Step1: Coverage of each sample in MAGs
mkdir ./13_Relative_abundance/

cat 07_dRep/all_bins_dRep/dereplicated_genomes/*fa > 13_Relative_abundance/MAGs_all.fa

${bwa} mem \
	-t 10 \
	-a 13_Relative_abundance/MAGs_all.fa \
	03_bowtie2/${sampleID}_meta_clean_R1.fq.gz \
	03_bowtie2/${sampleID}_meta_clean_R2.fq.gz \
	| samtools view -bS - > 13_Relative_abundance/${sampleID}.bam

${samtools} sort \
	-@ 10 \
	-o 13_Relative_abundance/${sampleID}.sort.bam \
	13_Relative_abundance/${sampleID}.bam

${samtools} index \
	-@ 10 \
	13_Relative_abundance/${sampleID}.sort.bam

${samtools} depth \
	-a 13_Relative_abundance/${sampleID}.sort.bam > 13_Relative_abundance/${sampleID}.depth


### Step2: Calculate relative abundance according to coverage
perl depth.pl 13_Relative_abundance/${sampleID}.depth > 13_Relative_abundance/${sampleID}_relative_abundance.txt

perl sum_MAG_relative_abundance.pl sampleID.txt > 13_Relative_abundance/MAG_relative_abundance.txt

#Note:
#	depth.pl and sum_MAG_relative_abundance.pl are self written scripts, which can be found in the Scripts folder.
#	sampleID.txt is a file containing all sample IDs, which can be found in the Pre-processed_Files folder.
